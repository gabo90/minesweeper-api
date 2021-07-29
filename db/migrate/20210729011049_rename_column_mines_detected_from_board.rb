class RenameColumnMinesDetectedFromBoard < ActiveRecord::Migration[6.1]
  def change
    rename_column :boards, :mines_detected, :remaining_mines
  end
end
