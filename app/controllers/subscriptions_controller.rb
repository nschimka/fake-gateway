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

    json_response = JSON.parse(response.body)
  	if json_response["success"]
  	  @sub = Subscription.create(subscription_params)
  	  if @sub.save
  	    @sub.create_payment_profile(
  	      token: json_response["token"],
  	      expiration_month: purchase_params[:expiration_month],
  	      expiration_year: purchase_params[:expiration_year]
  	    )
  	    render json: @sub, status: :created
  	  else
  	  	render json: @sub.errors, status: :unprocessable_entity
  	  end
  	else
  	  render json: json_response["error_code"], status: :unprocessable_entity
  	end
  end

  private

  def purchase_params
  	params.require(:subscription).permit(:first_name, :last_name, :amount,
  	  :address, :city, :state, :country, :zip_code, :card_number, :cvv,
  	  :expiration_year, :expiration_month)
  end

  def subscription_params
  	purchase_params.slice(:first_name, :last_name, :address, :city, :state,
  	  :country, :zip_code)
  end
end
