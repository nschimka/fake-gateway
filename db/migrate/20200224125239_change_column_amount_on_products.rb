class ChangeColumnAmountOnProducts < ActiveRecord::Migration[6.0]
  def change
  	rename_column :products, :amount, :amount_in_cents
  end
end
