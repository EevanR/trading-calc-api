class AddDataColumnToExcel < ActiveRecord::Migration[6.0]
  def change
    add_column :excels, :data, :json, default: {}
  end
end
