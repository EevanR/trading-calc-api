class AddUserIdToSetups < ActiveRecord::Migration[6.0]
  def change
    add_column :setups, :user_id, :integer
  end
end
