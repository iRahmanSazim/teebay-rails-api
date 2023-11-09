class ApplicationController < ActionController::API
  # Get /
  def index
    render json: { message: "Server listening at localhost:3000" }
  end
end
