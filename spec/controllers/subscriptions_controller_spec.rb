require "rails_helper"

RSpec.describe SubscriptionsController do

  context "when passed all possible information" do
    let!(:params) do {
      subscription: {
        first_name: "Fiona",
        last_name: "Pomegranate",
        address: "123 Main St",
        city: "San Antonio",
        state: "TX",
        country: "US",
        zip_code: "78216",
        product_id: 1,
        card_number: "4242424242424242",
        expiration_month: "10",
        expiration_year: "2023",
        cvv: "123"
      }
    }
    end

    it "creates a subscription with all the information" do
      VCR.use_cassette('successful_purchase') do
        post :create, { :params => params }
        assert_response :created

        expect(response.body).to eql(Subscription.last.to_json)
      end
    end

    it "creates a payment profile for that subscription" do
      VCR.use_cassette('successful_purchase') do
        post :create, { :params => params }
        assert_response :created

        expect(Subscription.last.payment_profile.token).to_not be_nil
        expect(Subscription.last.payment_profile.expiration_month).to eql("10")
        expect(Subscription.last.payment_profile.expiration_year).to eql("2023")
      end
    end
  end

  context "when not passed a last name" do
  	let!(:params) do {
      subscription: {
        first_name: "Fiona",
        address: "123 Main St",
        city: "San Antonio",
        state: "TX",
        country: "US",
        zip_code: "78216",
        product_id: 1,
        card_number: "4242424242424242",
        expiration_month: "10",
        expiration_year: "2023",
        cvv: "123"
      }
    }
    end

    # A better test would be to test for `eql(the exact response)`
    # But my JSON response has escaped quotes that I'm not sure
    # how to strip out
  	it "returns an appropriate error" do
      VCR.use_cassette('successful_purchase') do
  	    post :create, { :params => params }

        assert_response :unprocessable_entity
        expect(response.body).to have_content("Last name can't be blank")
      end
  	end
  end

  context "when the card passed is expired" do
    let!(:params) do {
      subscription: {
        first_name: "Fiona",
        last_name: "Pomegranate",
        zip_code: "78216",
        product_id: 1,
        card_number: "4242424242424242",
        expiration_month: "10",
        expiration_year: "2010",
        cvv: "123"
      }
    }
    end

    it "returns a descriptive error and not the gateway error code" do
      VCR.use_cassette('expired_card') do
        post :create, { :params => params }

        assert_response :unprocessable_entity
        expect(response.body).to eql("Expired card")
      end
    end
  end
end
