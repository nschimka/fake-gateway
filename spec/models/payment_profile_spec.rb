require 'rails_helper'

RSpec.describe PaymentProfile, type: :model do
	it "is invalid if not passed a token" do
		pp = PaymentProfile.create(expiration_month: 02, expiration_year: 2024)
		pp.save

		expect(pp.errors.full_messages).to include("Token can't be blank")
	end

	it "is invalid if not passed an expiration_year" do
		pp = PaymentProfile.create(token: "1234", expiration_month: 02)
		pp.save

		expect(pp.errors.full_messages).to include("Expiration year can't be blank")
	end

	it "is invalid if not passed an expiration_month" do
		pp = PaymentProfile.create(token: "5678", expiration_year: 2031)
		pp.save

		expect(pp.errors.full_messages).to include("Expiration month can't be blank")
	end
end
