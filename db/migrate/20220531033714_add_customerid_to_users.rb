class AddCustomeridToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :customer_id, :string
  end
end
