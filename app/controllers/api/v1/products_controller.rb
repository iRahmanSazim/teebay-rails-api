class Api::V1::ProductsController < ApplicationController
  include Panko
  before_action :doorkeeper_authorize!
  before_action :set_product, only: [:show, :update, :destroy]
  
  # todo - remove later
  def delete_all
    @products = Product.all
    @products.destroy_all

    render json: {message: 'All products deleted'}
  end

  # GET /products
  def index
    @products = Product.all
    render json: ArraySerializer.new(@products, each_serializer: ProductSerializer).to_json
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
    render json: ProductSerializer.new.serialize(@product).to_json
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: ProductSerializer.new.serialize(@product).to_json, status: :created, location: api_v1_product_url(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /products/1
  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :user_id)
    end
end
