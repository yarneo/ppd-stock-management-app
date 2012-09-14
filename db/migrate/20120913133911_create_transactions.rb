class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :operationtype
      t.text :info
      t.text :reason

      t.timestamps
    end
  end
end
