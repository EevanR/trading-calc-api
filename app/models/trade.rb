class Trade < ApplicationRecord
  validates_presence_of :ticker, :profit, :setup
end
