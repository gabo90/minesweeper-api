class Cell < ApplicationRecord
  extend Enumerize

  belongs_to :board

  enumerize :kind, in: %i[mine counter cell]
  enumerize :marked_as, in: %i[unknown mine]
end
