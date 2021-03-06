class Game < ApplicationRecord
  extend Enumerize

  belongs_to :player
  has_one :board

  enumerize :status, in: %i[initialized playing paused completed], predicates: true
  enumerize :result, in: %i[win lose], predicates: true

  accepts_nested_attributes_for :board

  def over!
    update(status: :completed, result: :lose)
  end

  def you_win!
    update(status: :completed, result: :win)
  end

  def can_resume?
    initialized? || paused?
  end
end
