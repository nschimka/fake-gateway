class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # For the front-end devs to figure out
  def new
  end

  def create
    response = GatewayCall.new(purchase_params).purchase
    if response["success"]
  	  @sub = Subscription.create(subscription_params)
  	  if @sub.save
  	    @sub.create_payment_profile(
  	      token: response["token"],
  	      expiration_month: purchase_params[:expiration_month],
  	      expiration_year: purchase_params[:expiration_year]
  	    )
  	    render json: @sub, status: :created
  	  else
  	  	render json: @sub.errors, status: :unprocessable_entity
  	  end
    else
      render json: translated_error(response), status: :unprocessable_entity
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

  def translated_error(response)
    GatewayCall::GATEWAY_ERRORS[response["error_code"]]
  end
end
