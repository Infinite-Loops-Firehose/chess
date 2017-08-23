class AddPrevTurnYPositionToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :prev_turn_y_position, :integer
  end
end
