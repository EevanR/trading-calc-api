class AddsGrossDataToExcel < ActiveRecord::Migration[6.0]
  def change
    add_column :excels, :grossData, :text, array: true, default: []
  end
end
