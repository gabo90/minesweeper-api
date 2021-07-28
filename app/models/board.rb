class Board < ApplicationRecord
  belongs_to :game
  has_many :cells
  has_one :player, through: :game
end
