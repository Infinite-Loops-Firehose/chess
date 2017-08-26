class RemoveStateColFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :state, :integer, default: 0, null: false
  end
end
