class ApplicationController < ActionController::API
  def render_json(output, status)
    render json: output, status: status
  end
end
