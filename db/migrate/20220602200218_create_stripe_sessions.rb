class CreateStripeSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :stripe_sessions do |t|
      t.string :session_id
      t.string :customer_id

      t.timestamps
    end
  end
end
