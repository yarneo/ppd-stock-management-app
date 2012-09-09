class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.integer :storage
      t.integer :amount
      t.references :product

      t.timestamps
    end
    add_index :quantities, :product_id
  end
end
