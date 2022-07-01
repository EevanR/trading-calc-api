class AddsUserIdToStripeSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :stripe_sessions, :user_id, :integer
  end
end
