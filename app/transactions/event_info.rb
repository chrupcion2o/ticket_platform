# frozen_string_literal: true

class EventInfo
  include Dry::Transaction

  step :find

  private

  def find(params)
    event = Event.select(:name, :date, :info, :id).find(params.to_i)

    Success(event)
  rescue ActiveRecord::RecordNotFound
    Failure("Event not found")
  end
end
