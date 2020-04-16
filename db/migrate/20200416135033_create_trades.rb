class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :ticker, null: false
      t.float :entry
      t.integer :shares
      t.float :stop
      t.string :setup, null: false
      t.string :date
      t.float :profit, null: false
      t.integer :trade_id

      t.timestamps
    end
  end
end
