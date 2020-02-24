require "spec_helper"
require "rails_helper"

RSpec.describe GatewayCall do

  context "when passed all minimum information" do
    let!(:params) do {
      subscription: {
        amount: "1000",
        cvv: "123",
        expiration_month: "01",
        expiration_year: "2023",
        card_number: "4242424242424242",
        zip_code: "54321"
      }
    }
    end

    it "returns successful with a token" do
      VCR.use_cassette('successful_purchase') do
        response = GatewayCall.new(params).purchase

        expect(response["success"]).to be_truthy
        expect(response["token"]).to_not be_nil
      end
    end
  end

	context "when not passed an amount" do
  	let!(:params) do { 
  	  subscription: {
  	  	cvv: "123",
  	  	expiration_month: "12",
  	  	expiration_year: "2024",
  	  	card_number: "4242424242424242",
  	  	zip_code: "12345"
  	  }
  	}
    end

  	it "returns an error" do
  	  VCR.use_cassette('missing_amount_from_gateway_call') do
  	    response = GatewayCall.new(params).purchase

  	    expect(response["success"]).to be_falsy
        expect(response["error_code"]).to eql 1000006
  	  end
  	end
  end
end
