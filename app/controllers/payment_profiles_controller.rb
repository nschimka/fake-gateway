class PaymentProfilesController < ApplicationController
  def create
    @payment_profile = PaymentProfile.create(payment_profile_params)
    if @payment_profile.save
      render json: @payment_profile
    else
      render json: @payment_profile.errors.full_messages
    end
  end

  private

  def payment_profile_params
    params.permit(:expiration_month, :expiration_year, :token)
  end
end
