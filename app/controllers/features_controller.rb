class FeaturesController < ApplicationController
  # GET /events
  def event_info
    result = ::EventInfo.new.call(event_info_params)

    if result.success?
      render_json(result.success, 200)
    else
      render_json({ error: result.failure }, 400)
    end
  rescue StandardError
    render_json({ error: 'Unknown server error' }, 500)
  end

  # GET /events/1
  def event_tickets
    result = ::EventTickets.new.call(event_tickets_params)

    if result.success?
      render_json(result.success, 200)
    else
      render_json({ error: result.failure }, 400)
    end
  rescue StandardError
    render_json({ error: 'Unknown server error' }, 500)
  end

  # POST /events
  def reserve_ticket
    result = ::ReserveTicket.new.call(reserve_ticket_params)

    if result.success?
      render_json(result.success, 200)
    else
      render_json({ error: result.failure }, 400)
    end
  rescue StandardError
    render_json({ error: 'Unknown server error' }, 500)
  end

  # PATCH/PUT /events/1
  def pay; end

  # DELETE /events/1
  def reservation_info; end

  private

  def event_info_params
    params.require(:id)
  end

  def event_tickets_params
    params.require(:id)
  end

  def reserve_ticket_params
    params.require(:ticket).permit(:id, :quantity).to_h.with_indifferent_access
  end

  def pay_params
    params.permit(:reservation_id, :token)
  end

  def reservation_info_params
    params.require(:reservation).permit(:id)
  end
end
