class Api::V1::ProductsController < ApplicationController
  include Panko
  before_action :doorkeeper_authorize!
  before_action :set_product, only: [:show, :update, :destroy]
  
  def truncate
    @products = Product.all
    authorize @products
    @products.destroy_all

    render json: {message: 'All products deleted'}
  end

  # GET /products
  def index
    @products = Product.all
    authorize @products
    render json: ArraySerializer.new(@products, each_serializer: ProductSerializer).to_json
  end

  # GET /products/1
  def show
    authorize @product
    render json: ProductSerializer.new.serialize(@product).to_json
  end

  # POST /products
  def create
    product = {user_id: current_user.id}.merge(product_params)
    @product = Product.new(product)
    authorize @product

    if @product.save
      render json: ProductSerializer.new.serialize(@product).to_json, status: :created, location: api_v1_product_url(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    authorize @product
    @product.destroy!
    render json: {message: 'Product deleted'}
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price)
    end
end
