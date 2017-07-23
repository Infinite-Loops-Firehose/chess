class AddDetailsToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :user_white_id, :integer
    add_index :games, :user_white_id
    add_column :games, :user_black_id, :integer
    add_index :games, :user_black_id
  end
end
