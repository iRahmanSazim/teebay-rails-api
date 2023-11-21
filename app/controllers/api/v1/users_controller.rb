class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # todo - remove later
  def delete_all
    @users = User.all
    @users.destroy_all

    render json: {message: 'All users deleted'}
  end

  def login 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: {message: 'Login successful', user: @user}
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
    puts ()

    if @user.save
      render json: @user, status: :created, location: api_v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:user_name, :email, :password)
    end
end
