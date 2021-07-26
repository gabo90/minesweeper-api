class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :mines, default: 0
      t.integer :rows, default: 8
      t.integer :columns, default: 8
      t.integer :mines_detected, default: 0
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
