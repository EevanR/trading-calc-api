class AddStatsToTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :trades, :open, :string
    add_column :trades, :high, :string
    add_column :trades, :low, :string
    add_column :trades, :close, :string
    add_column :trades, :vol, :string
    add_column :trades, :prevClose, :string
    add_column :trades, :volAvg, :integer
    add_column :trades, :mktCap, :float
    add_column :trades, :company, :string
    add_column :trades, :industry, :string
  end
end
