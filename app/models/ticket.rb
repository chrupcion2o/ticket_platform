class Ticket < ApplicationRecord
  TYPES = %w[even all_together avoid_one].freeze

  has_many :reservations
  belongs_to :event

  validates_numericality_of :quantity, greater_than_or_equal_to: 0
  validates :ticket_type,   inclusion: TYPES

  def allow_reservation?(quantity_to_reserve)
    case ticket_type
    when 'even' then even_reservation?(quantity_to_reserve)
    when 'all_together' then all_together_reservation?(quantity_to_reserve)
    when 'avoid_one' then avoid_one_reservation?(quantity_to_reserve)
    else
      raise 'Ticket type not implemented'
    end
  end

  private

  def even_reservation?(quantity_to_reserve)
    quantity >= quantity_to_reserve && quantity_to_reserve.even?
  end

  def all_together_reservation?(quantity_to_reserve)
    quantity == quantity_to_reserve
  end

  def avoid_one_reservation?(quantity_to_reserve)
    (quantity == quantity_to_reserve) || (quantity - quantity_to_reserve) > 1
  end
end
