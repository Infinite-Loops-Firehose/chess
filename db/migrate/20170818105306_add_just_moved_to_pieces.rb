class AddJustMovedToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :just_moved, :boolean, default: false
  end
end
