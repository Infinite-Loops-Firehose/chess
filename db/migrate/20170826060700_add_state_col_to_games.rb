class AddStateColToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :state, :integer, default: 0, null: false
  end
end
