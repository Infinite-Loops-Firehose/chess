class AddLastMoveNumberToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :last_move_number, :integer, default: 0, null: false
  end
end
