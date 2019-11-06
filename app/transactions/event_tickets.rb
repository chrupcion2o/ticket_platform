# frozen_string_literal: true

class EventTickets
  include Dry::Transaction

  step :find

  private

  def find(params)
    tickets = Ticket.select(:qunantity, :ticket_type, :price, :currency, :event_id, :id).where(event_id: params.to_i)

    if tickets.present?
      Success(tickets)
    else
      Failure("Tickets not found for specified event")
    end
  end
end
