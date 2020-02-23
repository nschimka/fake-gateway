class AddPaymentProfilesTable < ActiveRecord::Migration[6.0]
  def change
  	create_table :payment_profiles do |t|
  	  t.string :token
  	  t.string :expiration_month
  	  t.string :expiration_year
  	  t.integer :subscription_id

  	  t.timestamps
  	end
  end
end
