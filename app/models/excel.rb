class Excel < ApplicationRecord
  validates_presence_of :grossData, :netData
end
