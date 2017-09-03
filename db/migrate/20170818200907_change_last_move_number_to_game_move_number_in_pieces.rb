class ChangeLastMoveNumberToGameMoveNumberInPieces < ActiveRecord::Migration[5.0]
  def change
    rename_column :pieces, :last_move_number, :game_move_number
  end
end
