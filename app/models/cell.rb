class Cell < ApplicationRecord
  extend Enumerize

  belongs_to :board
  has_one :game, through: :board

  scope :mines, -> { where(kind: 'mine') }
  scope :counters, -> { where(kind: 'counter') }
  scope :bare, -> { where(kind: 'cell') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :marked, -> { where.not(marked_as: nil) }
  scope :with_red_flag, -> { where(marked_as: 'red_flag') }
  scope :with_question_mark, -> { where(marked_as: 'question_mark') }

  enumerize :kind, in: %i[mine counter cell], predicates: true
  enumerize :marked_as, in: %i[question_mark red_flag], predicates: true
end
