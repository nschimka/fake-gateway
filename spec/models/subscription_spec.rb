require 'rails_helper'

RSpec.describe Subscription, type: :model do
	it "is invalid if not passed a first name" do
		sub = Subscription.create(last_name: "Crab")
		sub.save

		expect(sub.errors.full_messages).to include("First name can't be blank")
	end

	it "is invalid if not passed a last name" do
		sub = Subscription.create(first_name: "Bobby")
		sub.save

		expect(sub.errors.full_messages).to include("Last name can't be blank")
	end
end
