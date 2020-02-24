class AddColumnProductIdToSubscription < ActiveRecord::Migration[6.0]
  def change
  	add_column :subscriptions, :product_id, :integer
  end
end
