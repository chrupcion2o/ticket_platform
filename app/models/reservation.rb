class Reservation < ApplicationRecord
  has_many :payments
  belongs_to :ticket
end
