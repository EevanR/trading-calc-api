class CreateExcels < ActiveRecord::Migration[6.0]
  def change
    create_table :excels do |t|
      t.string :user_id
      t.float :Comm
      t.string :Currency
      t.float :ECNAdd
      t.float :ECNRemove
      t.float :ExecTime
      t.float :GrossProceeds
      t.string :Liq
      t.float :NSCC
      t.float :Nasdaq
      t.float :NetProceeds
      t.float :Price
      t.integer :Qty
      t.string :SD
      t.float :SEC
      t.string :Side
      t.string :Symbol
      t.string :TD

      t.timestamps
    end
  end
end
