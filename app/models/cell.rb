class Cell < ApplicationRecord
  extend Enumerize

  belongs_to :board
  has_one :game, through: :board

  scope :mines, -> { where(kind: 'mine') }

  enumerize :kind, in: %i[mine counter cell], predicates: true
  enumerize :marked_as, in: %i[question_mark red_flag], predicates: true
end
