class RemoveTypeColumnFromCells < ActiveRecord::Migration[6.1]
  def change
    add_column :cells, :kind, :string, default: 'cell'
    remove_column :cells, :type
  end
end
