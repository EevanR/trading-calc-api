class ChangeReqThreeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :setups, :reqThree, :req3
  end
end
