class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
