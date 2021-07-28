class AddTimestampsDefaultsToCells < ActiveRecord::Migration[6.1]
  def change
    change_column_default :cells, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :cells, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
