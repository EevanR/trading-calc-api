class ChangeReqTwoColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :setups, :reqTwo, :req2
  end
end
