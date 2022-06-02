class AddsDefaultToSessionsStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :stripe_sessions, :status, :string, default: "pending"
  end
end
