class Excel < ApplicationRecord
  validates_presence_of :data, :user_id
end
