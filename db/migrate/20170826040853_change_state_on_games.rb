class ChangeStateOnGames < ActiveRecord::Migration[5.0]
  def change
    change_column_null :games, :state, false
    change_column_default :games, :state, from: nil, to: 0
  end
end
