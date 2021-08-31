class AddsFeesToExcel < ActiveRecord::Migration[6.0]
  def change
    add_column :excels, :fees, :float
  end
end
