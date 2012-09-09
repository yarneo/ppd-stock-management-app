class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :item

      t.timestamps
    end
      add_index :products, :item_id
  end
end