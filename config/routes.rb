Rails.application.routes.draw do
  resource :subscriptions, only: [:new, :create]
  resource :payment_profiles, only: [:create]
end
