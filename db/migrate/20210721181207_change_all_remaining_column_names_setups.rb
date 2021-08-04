class ChangeAllRemainingColumnNamesSetups < ActiveRecord::Migration[6.0]
  def change
    rename_column :setups, :reqFive, :req5
    rename_column :setups, :reqSix, :req6
    rename_column :setups, :reqSeven, :req7
    rename_column :setups, :reqEight, :req8
    rename_column :setups, :reqNine, :req9
    rename_column :setups, :reqTen, :req10
  end
end
