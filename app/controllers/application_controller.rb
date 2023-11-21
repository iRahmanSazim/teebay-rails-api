class ApplicationController < ActionController::API
  def index
    @application = Doorkeeper::Application.find_by(name: 'Postman')
  
    @application = {
      name: @application.name,
      client_id: @application.uid,
      client_secret: @application.secret,
    }
    render json: { message: "Server listening at localhost:3000" , app_credentials: @application}
  end

  private
  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
