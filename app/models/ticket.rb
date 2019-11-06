class Ticket < ApplicationRecord
  TYPES = %w[even all_together avoid_one]
  has_many :reservations
  belongs_to :event
end
