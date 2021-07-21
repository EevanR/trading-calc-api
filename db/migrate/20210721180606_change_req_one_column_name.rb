class ChangeReqOneColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :setups, :reqOne, :req1
  end
end
