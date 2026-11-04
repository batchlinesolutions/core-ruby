# frozen_string_literal: true

RSpec.describe Bls::Core::Fulfillment do
  describe "#create!" do
    it "posts to the V2 fulfillments endpoint" do
      fulfillment = build(:fulfillment)
      body = build_fulfillment_response
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body,
                                                 http_status_code: 202)
      client = build_stubbed_api_v2_client
      allow(client).to receive(:post).and_call_original

      fulfillment.create!

      expect(client).to have_received(:post).with(
        path: "https://core.batchlinesolutions.dev/api/fulfillments",
        body: fulfillment.request_body,
        headers: fulfillment.request_headers
      )
    end

    it "sends the idempotency key header" do
      fulfillment = build(:fulfillment, idempotency_key: "9b2f0c52")
      body = build_fulfillment_response
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body,
                                                 http_status_code: 202)
      request = build_stubbed_post

      fulfillment.create!

      expect(request["X-Idempotency-Key"]).to eq("9b2f0c52")
    end

    it "assigns the fulfillment id as the id" do
      fulfillment = build(:fulfillment)
      body = build_fulfillment_response(fulfillment_id: "f-123")
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body,
                                                 http_status_code: 202)

      result = fulfillment.create!

      expect(result.id).to eq("f-123")
    end

    it "marks the fulfillment as accepted" do
      fulfillment = build(:fulfillment)
      body = build_fulfillment_response
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body,
                                                 http_status_code: 202)

      result = fulfillment.create!

      expect(result).to be_accepted
    end

    context "the response code is not 202" do
      it "raises a FulfillmentNotCreatedError" do
        fulfillment = build(:fulfillment)
        response = error_response(message: "Fulfillment Not Created",
                                  http_status_code: 400)
        stub_api_v2_authentication
        stub_api_response response: response

        expect {
          fulfillment.create!
        }.to raise_error(Bls::Core::FulfillmentNotCreatedError)
      end

      it "marks the fulfillment as invalid" do
        fulfillment = build(:fulfillment)
        response = error_response(message: "Fulfillment Not Created",
                                  http_status_code: 400)
        stub_api_v2_authentication
        stub_api_response response: response

        begin
          fulfillment.create!
        rescue Bls::Core::FulfillmentNotCreatedError
          nil
        end

        expect(fulfillment).not_to be_valid
      end

      it "includes the API error response in the error message" do
        fulfillment = build(:fulfillment)
        body = read_v2_error_response
        response = build_response(body: body, http_status_code: 422)
        stub_api_v2_authentication
        stub_api_response response: response

        expect {
          fulfillment.create!
        }.to raise_error(Bls::Core::FulfillmentNotCreatedError,
                         /#{Regexp.escape(body.to_json)}/)
      end
    end
  end

  describe "#request_body" do
    it "assigns the order id" do
      fulfillment = build(:fulfillment, order_id: 1234)

      result = fulfillment.request_body

      expect(result[:order_id]).to eq("1234")
    end

    it "assigns the zip" do
      fulfillment = build(:fulfillment, zip: "13610")

      result = fulfillment.request_body

      expect(result[:zip]).to eq("13610")
    end

    it "assigns the address delivery notes" do
      address = build(:fulfillment_address, delivery_notes: "Door code 1234")
      fulfillment = build(:fulfillment, address: address)

      result = fulfillment.request_body

      expect(result[:address]).to include(delivery_notes: "Door code 1234")
    end

    it "excludes blank values from the address" do
      address = build(:fulfillment_address, street2: "")
      fulfillment = build(:fulfillment, address: address)

      result = fulfillment.request_body

      expect(result[:address]).not_to have_key(:street2)
    end

    it "assigns the item code" do
      fulfillment_item = build(:fulfillment_item, code: "MP0001", quantity: 2)
      fulfillment = build(:fulfillment, items: [fulfillment_item])

      result = fulfillment.request_body

      expect(result[:items]).to eq([{ code: "MP0001", quantity: 2 }])
    end

    it "assigns optional fulfillment attributes when provided" do
      fulfillment = build(:fulfillment, carrier: "FEDEX",
                                        packing_treatment: "STANDARD",
                                        customer_id: "c-1")

      result = fulfillment.request_body

      expect(result).to include(carrier: "FEDEX",
                                packing_treatment: "STANDARD",
                                customer_id: "c-1")
    end

    it "assigns the validation options" do
      fulfillment = Bls::Core::Fulfillment.new(skip_temperature_check: true)

      result = fulfillment.request_body

      expect(result[:validation_options]).
        to eq(skip_temperature_check: true, skip_address_validation: false)
    end
  end

  describe ".retrieve" do
    it "requests the fulfillment by its id" do
      body = build_fulfillments_response[:content].first
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body)
      client = build_stubbed_api_v2_client
      allow(client).to receive(:get).and_call_original

      Bls::Core::Fulfillment.retrieve("f-123")

      expect(client).to have_received(:get).with(
        path: "https://core.batchlinesolutions.dev/api/fulfillments/f-123"
      )
    end

    context "the response is not successful" do
      it "raises a ResourceRetrievalError" do
        stub_api_v2_authentication
        stub_api_response response: build_response(
          body: read_v2_error_response, http_status_code: 404
        )

        expect {
          Bls::Core::Fulfillment.retrieve("missing")
        }.to raise_error(Bls::Core::ResourceRetrievalError)
      end
    end
  end

  describe ".retrieve_all" do
    it "requests the given page of fulfillments with the provided filters" do
      body = build_fulfillments_response
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body)
      client = build_stubbed_api_v2_client
      allow(client).to receive(:get).and_call_original

      Bls::Core::Fulfillment.retrieve_all(page: 2, size: 50,
                                          delivery_date_from: "2024-02-13",
                                          delivery_date_to: "2024-02-14")

      expect(client).to have_received(:get).with(
        path: "https://core.batchlinesolutions.dev/api/fulfillments",
        params: { delivery_date_from: "2024-02-13",
                  delivery_date_to: "2024-02-14",
                  order_id: nil,
                  page: 2,
                  size: 50 }
      )
    end

    it "returns fulfillments built from the page content" do
      body = build_fulfillments_response
      stub_api_v2_authentication
      stub_api_response response: build_response(body: body)

      result = Bls::Core::Fulfillment.retrieve_all(page: 0)

      expect(result.map(&:id)).to eq(["f-123"])
    end

    context "the response is not successful" do
      it "raises a ResourceRetrievalError" do
        stub_api_v2_authentication
        stub_api_response response: build_response(
          body: read_v2_error_response, http_status_code: 500
        )

        expect {
          Bls::Core::Fulfillment.retrieve_all(page: 0)
        }.to raise_error(Bls::Core::ResourceRetrievalError)
      end
    end
  end

  describe ".build_from_response" do
    it "assigns the fulfillment id as the id" do
      data = build_fulfillments_response[:content].first

      result = Bls::Core::Fulfillment.build_from_response(data)

      expect(result.id).to eq("f-123")
    end

    it "maps the address1 of the address to street1" do
      data = build_fulfillments_response[:content].first

      result = Bls::Core::Fulfillment.build_from_response(data)

      expect(result.address.street1).to eq("123 Main Street")
    end

    it "assigns the shipment item code" do
      data = build_fulfillments_response[:content].first

      result = Bls::Core::Fulfillment.build_from_response(data)

      expect(result.shipments.first.items.first.code).to eq("MP0001")
    end
  end

  describe "#accepted?" do
    it "is true when the status is INGESTED" do
      fulfillment = Bls::Core::Fulfillment.new(status: "INGESTED")

      expect(fulfillment).to be_accepted
    end

    it "is false when the status is CANCELLED" do
      fulfillment = Bls::Core::Fulfillment.new(status: "CANCELLED")

      expect(fulfillment).not_to be_accepted
    end
  end

  describe "#cancel!" do
    it "deletes the fulfillment by its id" do
      fulfillment = Bls::Core::Fulfillment.new(id: "f-123")
      stub_api_v2_authentication
      stub_api_response response: build_response(body: nil,
                                                 http_status_code: 204)
      client = build_stubbed_api_v2_client
      allow(client).to receive(:delete).and_call_original

      fulfillment.cancel!

      expect(client).to have_received(:delete).with(
        path: "https://core.batchlinesolutions.dev/api/fulfillments/f-123"
      )
    end

    it "cancels the fulfillment" do
      fulfillment = Bls::Core::Fulfillment.new(id: 1)
      stub_api_v2_authentication
      stub_api_response response: build_response(body: nil,
                                                 http_status_code: 204)

      result = fulfillment.cancel!

      expect(result).to be_cancelled
    end

    context "the response code is not 204" do
      it "raises a FulfillmentNotCancelledError" do
        fulfillment = Bls::Core::Fulfillment.new(id: 1)
        response = error_response(message: "Fulfillment Not Found",
                                  http_status_code: 400)
        stub_api_v2_authentication
        stub_api_response response: response

        expect {
          fulfillment.cancel!
        }.to raise_error(Bls::Core::FulfillmentNotCancelledError)
      end

      it "marks the fulfillment as not valid" do
        fulfillment = Bls::Core::Fulfillment.new(id: 1)
        response = error_response(message: "Fulfillment Not Found",
                                  http_status_code: 400)
        stub_api_v2_authentication
        stub_api_response response: response

        begin
          fulfillment.cancel!
        rescue Bls::Core::FulfillmentNotCancelledError
          nil
        end

        expect(fulfillment).not_to be_valid
      end
    end
  end
end
