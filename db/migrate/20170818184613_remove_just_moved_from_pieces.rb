class RemoveJustMovedFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :just_moved
  end
end
