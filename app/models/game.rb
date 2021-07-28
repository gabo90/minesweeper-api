class Game < ApplicationRecord
  extend Enumerize

  belongs_to :player
  has_one :board

  enumerize :status, in: %i[initialized playing paused completed]
  enumerize :result, in: %i[win lose]

  accepts_nested_attributes_for :board

end
