class AddIndexToPiecesGameId < ActiveRecord::Migration[5.0]
  def change
    add_index :pieces, :game_id
  end
end
