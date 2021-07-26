class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :alias, null: false
      t.integer :played_games, default: 0
      t.integer :games_won, default: 0
      t.integer :games_lost, default: 0

      t.timestamps
    end
  end
end
