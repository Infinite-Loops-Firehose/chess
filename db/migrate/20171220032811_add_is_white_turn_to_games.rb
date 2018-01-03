class AddIsWhiteTurnToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :is_white_turn, :boolean, default: true
  end
end
