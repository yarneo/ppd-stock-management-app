class FixColumnName < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :transactions, :type, :operationtype
  end


  def down
  end
end
