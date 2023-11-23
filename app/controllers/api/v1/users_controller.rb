class Api::V1::UsersController < ApplicationController
  include Panko
  include AuthHelperModule
  before_action :find_client_app, only: [:create, :login]
  before_action :doorkeeper_authorize!, except: [:login, :create, :truncate]

  # todo - remove later
  def truncate
    @users = User.all
    authorize @users
    @users.destroy_all

    render json: {message: 'All users deleted'}
  end

  def index
    @users = User.all
    authorize @users
    render json: ArraySerializer.new(@users, each_serializer: UserSerializer).to_json
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    render json: UserSerializer.new.serialize(@user).to_json
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      access_token = create_access_token()
      render_user_with_token(access_token)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login 
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      access_token = create_access_token
      render_user_with_token(access_token)
    else
      render json: {message: 'Invalid Credentials'}
    end
  end

  private
    def user_params
      params.permit(:user_name, :email, :password)
    end
end
