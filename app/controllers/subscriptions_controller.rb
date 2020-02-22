class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  FAKEPAY_KEY = ENV['FAKEPAY_KEY']
  
  # For the front-end devs to figure out
  def new
  end

  def create
    response = HTTParty.post(
      "https://www.fakepay.io/purchase",
      body: {
        amount: params[:amount],
        card_number: params[:card_number],
        cvv: params[:cvv],
        expiration_month: params[:expiration_month],
        expiration_year: params[:expiration_year],
        zip_code: params[:zip_code]
      }.to_json,
      headers: {
      	"Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Token #{FAKEPAY_KEY}"
      }
  	)

  	if response.body["success"]
  	  render json: response.body["token"]
  	else
  	  render json: response.body["error_code"]
  	end
  end
end
