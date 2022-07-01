class StripeSession < ApplicationRecord
  validates_presence_of :session_id, :customer_id

  belongs_to :user
end
