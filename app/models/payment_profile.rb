class PaymentProfile < ApplicationRecord
  belongs_to :subscription

  validates :expiration_month, presence: true, length: { maximum: 2 }
  validates :expiration_year, presence: true, length: { maximum: 4 }
  validates :token, presence: true
end
