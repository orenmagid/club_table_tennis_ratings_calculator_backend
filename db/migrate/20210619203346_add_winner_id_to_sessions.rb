class AddWinnerIdToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :winner_id, :integer
  end
end
