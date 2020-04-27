class AddRiskToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :risk, :float, default: 0.01
  end
end
