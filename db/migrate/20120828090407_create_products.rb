class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :supplier_code
      t.string :ppd_code
      t.string :size
      t.integer :min_quantity
      t.references :item

      t.timestamps
    end
      add_index :products, :item_id
  end
end