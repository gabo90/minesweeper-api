class CreateCells < ActiveRecord::Migration[6.1]
  def change
    create_table :cells do |t|
      t.string :type, default_insert_value: 'cell'
      t.boolean :active, default_insert_value: false
      t.integer :around_mines, default_insert_value: 0
      t.integer :row, null: false
      t.integer :column, null: false
      t.string :marked_as
      t.belongs_to :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
