class ChangeReqFourColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :setups, :reqFour, :req4
  end
end
