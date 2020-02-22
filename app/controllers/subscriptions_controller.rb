class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  FAKEPAY_KEY = ENV['FAKEPAY_KEY']

  # For the front-end devs to figure out
  def new
  end

  def create
    response = HTTParty.post(
      "https://www.fakepay.io/purchase",
      :body => purchase_params.to_json,
      headers: {
      	"Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Token #{FAKEPAY_KEY}"
      }
  	)

  	if response.body["success"]
  	  @sub = Subscription.create(subscription_params)
  	  render json: @sub
  	else
  	  render json: response.body["error_code"]
  	end
  end

  private

  def purchase_params
  	params.require(:subscription).permit(:first_name, :last_name, :amount,
  	  :address, :city, :state, :country, :zip, :card_number, :cvv,
  	  :expiration_year, :expiration_month)
  end

  def subscription_params
  	purchase_params.slice(:first_name, :last_name, :address, :city, :state,
  	  :country, :zip)
  end
end
