class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :subscriptions, :zip, :zip_code
  end
end
