class AddsNetDataToExcel < ActiveRecord::Migration[6.0]
  def change
    add_column :excels, :netData, :text, array: true, default: []
  end
end
