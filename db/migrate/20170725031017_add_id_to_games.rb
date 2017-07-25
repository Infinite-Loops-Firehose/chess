class AddIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :game_id, :integer
    drop_table :chesspieces
  end
end
