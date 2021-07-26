class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :status, default_insert_value: 'initialized'
      t.string :result
      t.belongs_to :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
