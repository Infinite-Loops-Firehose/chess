class RemovePrevTurnYPositionFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :prev_turn_y_position
    add_column :pieces, :turn_pawn_moved_twice, :integer
  end
end
