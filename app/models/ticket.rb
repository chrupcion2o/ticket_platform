class Ticket < ApplicationRecord
  has_many :reservations
  belongs_to :event
end
