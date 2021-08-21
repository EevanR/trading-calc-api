class AddsDataToExcel < ActiveRecord::Migration[6.0]
  def change
    add_column :excels, :data, :text, array: true, default: []
  end
end
