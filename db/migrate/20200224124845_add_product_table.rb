class AddProductTable < ActiveRecord::Migration[6.0]
  def change
  	create_table :products do |t|
  	  t.integer :amount
  	  t.integer :interval
  	  t.string :interval_unit
  	  
  	  t.timestamps
  	end
  end
end
