class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :mines, default_insert_value: 0
      t.integer :rows, default_insert_value: 8
      t.integer :columns, default_insert_value: 8
      t.integer :mines_detected, default_insert_value: 0
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
