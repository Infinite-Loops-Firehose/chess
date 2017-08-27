class AddWinPlayerAndLosePlayerToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player_win, :integer
    add_column :games, :player_lose, :integer
  end
end
