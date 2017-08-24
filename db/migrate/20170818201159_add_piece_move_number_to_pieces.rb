class AddPieceMoveNumberToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :piece_move_number, :integer, default: 0, null: false
  end
end
