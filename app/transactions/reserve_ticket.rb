# frozen_string_literal: true

class ReserveTicket
  include Dry::Transaction

  step :check_input
  step :reserve

  private

  def check_input(params)
    ticket = Ticket.find(params[:id])

    if Integer(params[:quantity]).positive?
      Success(ticket: ticket, quantity: params[:quantity].to_i)
    else
      Failure('Tickets not found for specified event')
    end
  rescue ActiveRecord::RecordNotFound, ArgumentError
    Failure('Invalid input, please check if specified values are correct')
  end

  def reserve(data)
    ticket = data[:ticket]

    reservation = (save_reservation(ticket, data[:quantity]) if ticket.allow_reservation?(data[:quantity]))

    if reservation.present?
      Success(reservation)
    else
      Failure('Failed to create reservation, please check if quantity is correct')
    end
  end

  def save_reservation(ticket, reservation_quantity)
    ActiveRecord::Base.transaction do
      ticket.quantity -= reservation_quantity
      ticket.save!

      reservation = ticket.reservations.build(quantity: reservation_quantity)
      reservation.save!
      reservation
    end
  end
end
