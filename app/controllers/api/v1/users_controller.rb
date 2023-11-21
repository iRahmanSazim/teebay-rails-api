class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:login, :create]

  # todo - remove later
  def delete_all
    @users = User.all
    @users.destroy_all

    render json: {message: 'All users deleted'}
  end

  def login 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: @user
    else
      render json: {message: 'Invalid Credentials'}
    end
  end

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    client_id = params[:client_id] || Doorkeeper::Application.find_by(name: 'Postman').uid
    client_app = Doorkeeper::Application.find_by(uid: client_id)
    return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

    if @user.save
      access_token = Doorkeeper::AccessToken.create(
          resource_owner_id: @user.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
      render json: {
        user: {
          id: @user.id,
          email: @user.email,
          access_token: access_token.token,
          refresh_token: access_token.refresh_token,
          expires_in: access_token.expires_in,
        }}, status: :created, location: api_v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:user_name, :email, :password)
    end

    def generate_refresh_token
      loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end
end
