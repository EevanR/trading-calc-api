class RemoveColumnsFromExcel < ActiveRecord::Migration[6.0]
  def change
    remove_column :excels, :netData
    remove_column :excels, :grossData
  end
end
