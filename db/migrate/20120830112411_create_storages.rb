class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.integer :id
	  t.string :name
      t.timestamps
    end
  end
end
