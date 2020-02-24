class Subscription < ApplicationRecord
  has_one :payment_profile
  belongs_to :product

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :product_id, presence: true
end
