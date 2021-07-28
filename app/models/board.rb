class Board < ApplicationRecord
  belongs_to :game
  has_many :cells
end
