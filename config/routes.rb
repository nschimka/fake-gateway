Rails.application.routes.draw do
  resource :subscriptions, only: [:new, :create]
end
