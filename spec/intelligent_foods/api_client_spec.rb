# frozen_string_literal: true

RSpec.describe IntelligentFoods::ApiClient do
  describe ".build" do
    it "sets the api" do
      api = IntelligentFoods::V1.new

      result = IntelligentFoods::ApiClient.build(api)

      expect(result.api).to eq(api)
    end

    it "sets the authentication" do
      api = IntelligentFoods::V1.new
      auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
      allow(api).to receive(:authentication).and_return(auth)

      result = IntelligentFoods::ApiClient.build(api)

      expect(result.authentication).to eq(auth)
    end
  end

  describe "#execute_request" do
    it "sets the authorization bearer header" do
      stub_api_response
      request = build_stubbed_post
      api = IntelligentFoods::V1.new
      auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
      client = IntelligentFoods::ApiClient.new(api: api,
                                               authentication: auth)
      allow(IntelligentFoods::Authorization::Bearer).to receive(:new).
        and_return(auth)
      header = "Bearer 1234"

      client.execute_request(request: request, uri: request.uri)

      expect(request["Authorization"]).to eq(header)
    end

    it "makes the request" do
      request = build_stubbed_post
      http_client = double
      allow(http_client).to receive(:request)
      stub_api_response http: http_client
      client = IntelligentFoods::ApiClient.new

      client.execute_request(request: request, uri: request.uri)

      expect(http_client).to have_received(:request).with(request).once
    end

    it "parses the response body as JSON" do
      request = build_stubbed_post
      http_client = double
      response = OpenStruct.new(code: 200)
      stub_api_response response: response, http: http_client
      client = IntelligentFoods::ApiClient.new
      allow(JSON).to receive(:parse)

      client.execute_request(request: request, uri: request.uri)

      expect(JSON).to have_received(:parse)
    end

    context "the response code is 204" do
      it "does not attempt to parse to response body as JSON" do
        request = build_stubbed_post
        http_client = double
        response = OpenStruct.new(code: 204)
        stub_api_response response: response, http: http_client
        client = IntelligentFoods::ApiClient.new
        allow(JSON).to receive(:parse)

        client.execute_request(request: request, uri: request.uri)

        expect(JSON).not_to have_received(:parse)
      end
    end

    context "the response code is 301" do
      it "does not attempt to parse to response body as JSON" do
        request = build_stubbed_post
        http_client = double
        response = OpenStruct.new(code: 301)
        stub_api_response response: response, http: http_client
        client = IntelligentFoods::ApiClient.new
        allow(JSON).to receive(:parse)

        client.execute_request(request: request, uri: request.uri)

        expect(JSON).not_to have_received(:parse)
      end
    end

    context "the response code is 401" do
      it "raises a IntelligentFoods::AuthenticationError" do
        request = build_stubbed_post
        http_client = double
        response = OpenStruct.new(code: 401)
        stub_api_response response: response, http: http_client
        api = IntelligentFoods::V1.new
        client = IntelligentFoods::ApiClient.new(api: api)

        expect {
          client.execute_request(request: request, uri: request.uri)
        }.to raise_error(IntelligentFoods::AuthenticationError)
      end

      it "resets the apis authentication" do
        request = build_stubbed_post
        http_client = double
        response = OpenStruct.new(code: 401)
        stub_api_response response: response, http: http_client
        api = IntelligentFoods::V1.new
        client = IntelligentFoods::ApiClient.new(api: api)
        allow(api).to receive(:reset_authentication)

        begin
          client.execute_request(request: request, uri: request.uri)
        rescue IntelligentFoods::AuthenticationError
        end

        expect(api).to have_received(:reset_authentication)
      end
    end
  end

  describe "#post" do
    it "performs a post request" do
      stub_api_response
      body = { test: "yes" }
      client = IntelligentFoods::ApiClient.new
      allow(Net::HTTP::Post).to receive(:new).and_call_original

      client.post(path: "http://test.com/orders", body: body)

      expect(Net::HTTP::Post).to have_received(:new)
    end

    it "assigns a body to the request" do
      stub_api_response
      body = { test: "yes" }
      client = IntelligentFoods::ApiClient.new
      path = "http://test.com/orders"
      request = Net::HTTP::Post.new(URI(path))
      allow(Net::HTTP::Post).to receive(:new).and_return(request)

      client.post(path: path, body: body)

      expect(request.body).to eq(body.to_json)
    end

    it "executes the request" do
      stub_api_response
      body = { test: "yes" }
      client = IntelligentFoods::ApiClient.new
      allow(client).to receive(:execute_request).and_call_original

      client.post(path: "http://test.com/orders", body: body)

      expect(client).to have_received(:execute_request)
    end

    context "when authorization is provided" do
      it "executes the request with authorization" do
        stub_api_response
        body = { test: "yes" }
        auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
        client = IntelligentFoods::ApiClient.new(authentication: auth)
        request = Net::HTTP::Post.new(URI("http://test.com/orders"))
        allow(Net::HTTP::Post).to receive(:new).and_return(request)

        client.post(path: "http://test.com/orders", body: body)

        expect(request["Authorization"]).to eq(auth.header)
      end
    end
  end

  describe "#delete" do
    it "performs a delete request" do
      stub_api_response
      client = IntelligentFoods::ApiClient.new
      allow(Net::HTTP::Delete).to receive(:new).and_call_original

      client.delete(path: "http://test.com/orders/1")

      expect(Net::HTTP::Delete).to have_received(:new)
    end

    context "when authorization is provided" do
      it "executes the request with authorization" do
        stub_api_response
        auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
        client = IntelligentFoods::ApiClient.new(authentication: auth)
        request = Net::HTTP::Delete.new(URI("http://test.com/orders/1"))
        allow(Net::HTTP::Delete).to receive(:new).and_return(request)

        client.delete(path: "http://test.com/orders/1")

        expect(request["Authorization"]).to eq(auth.header)
      end
    end
  end

  describe "#get" do
    it "performs a get request" do
      stub_api_response
      client = IntelligentFoods::ApiClient.new
      allow(Net::HTTP::Get).to receive(:new).and_call_original

      client.get(path: "http://test.com/orders/1")

      expect(Net::HTTP::Get).to have_received(:new)
    end

    context "when authorization is provided" do
      it "executes the request with authorization" do
        stub_api_response
        auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
        client = IntelligentFoods::ApiClient.new(authentication: auth)
        request = Net::HTTP::Get.new(URI("http://test.com/orders/1"))
        allow(Net::HTTP::Get).to receive(:new).and_return(request)

        client.get(path: "http://test.com/orders/1", authorization: auth)

        expect(request["Authorization"]).to eq(auth.header)
      end
    end
  end
end
