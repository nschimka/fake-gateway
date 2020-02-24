class Product < ApplicationRecord
  has_one :subscription

  validates :amount_in_cents, presence: true
  validates :interval, presence: true
  validates :interval_unit, presence: true
  validates :name, presence: true

  #attr_accessor :amount_in_cents
end
