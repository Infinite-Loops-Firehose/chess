class RemoveGameIdColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :game_id, :integer
  end
end
