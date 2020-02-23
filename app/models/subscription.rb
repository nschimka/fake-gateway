class Subscription < ApplicationRecord
  has_one :payment_profile

  validates :first_name, presence: true
  validates :last_name, presence: true



end
