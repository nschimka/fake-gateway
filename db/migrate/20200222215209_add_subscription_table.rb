class AddSubscriptionTable < ActiveRecord::Migration[6.0]
  def change
  	create_table :subscriptions do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip

      t.timestamps
    end
  end
end
