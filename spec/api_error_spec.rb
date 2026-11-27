# frozen_string_literal: true

RSpec.describe Bls::ApiError do
  describe ".build" do
    context "when the response lists validation errors" do
      it "assigns the validation errors as the details" do
        data = { status: 422, title: "Unprocessable Entity",
                 validation_errors: [{ field: "items", error: "is empty" }] }
        response = OpenStruct.new(data: data)

        result = Bls::ApiError.build(response)

        expect(result.details).to eq([{ field: "items", error: "is empty" }])
      end
    end
  end

  describe "#message" do
    context "when the details list validation errors" do
      it "describes each validation error" do
        validation_errors = [
          { field: "address.zip", error: "is invalid" },
          { field: "items", error: "must not be empty" },
        ]
        error = Bls::ApiError.new(status: 422, title: "Unprocessable Entity",
                                  details: validation_errors)

        result = error.message

        expect(result).to eq("422 Unprocessable Entity - " \
                             "address.zip is invalid, items must not be empty")
      end
    end
  end
end
