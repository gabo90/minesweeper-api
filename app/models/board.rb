class Board < ApplicationRecord
  belongs_to :game
  has_many :cells
  has_one :player, through: :game

  before_create :set_mines

  def set_mines
    self.remaining_mines = mines
  end
end
