class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.boolean :is_white
      t.string :type
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
