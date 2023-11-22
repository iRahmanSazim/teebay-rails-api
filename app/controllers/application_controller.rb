class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @application = Doorkeeper::Application.find_by(name: 'Postman')
  
    @application = {
      name: @application.name,
      client_id: @application.uid,
      client_secret: @application.secret,
    }
    render json: { message: "Server listening at localhost:3000" , app_credentials: @application}
  end

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end

  
  private
  def user_not_authorized(exception)
    render json: {error: "Forbidden", message: "You are not authorized to perform this action"}, status: :forbidden
  end
  def doorkeeper_unauthorized_render_options(error: nil)
    render json: '{"error": "Unauthorized", "message":"Token is missing or invalid"}', staus: :unauthorized
  end
end
