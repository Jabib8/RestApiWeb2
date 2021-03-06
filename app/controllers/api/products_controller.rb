module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET /products
    # GET /products.json
    def index
          @user = User.find_by(token: params[:token])
    if params[:user_id] && params[:token]
      render json: Product.where(:user_id => @user.id , :active => true).all, status: :ok
    else
             render json: Product.all, status: :ok
    end
    end

    # GET /products/1
    # GET /products/1.json
    def show
      @product = Product.find(params[:id])
      render json: @product, status: :ok
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    # POST /products.json
    def create
      product = Product.new()
      product.name = (params[:name])
      product.description = (params[:description])
      product.active = true
      product.user_id = (params[:user_id])
      product.url_img = (params[:url_img])
      if product.save
        render json: '[{"message":"The product was Created"}]', status: :ok
      else
        render json: product.errors, status: :unprocessable_entity
      end
    rescue  ActiveRecord::InvalidForeignKey
      render json: '[{"error":"No valid foreign keys asignation"}]', status: 422
    end

    # PATCH/PUT /products/1
    # PATCH/PUT /products/1.json
    def update
      product = Product.find_by id: (params[:id])
      product.name = (params[:name])
      product.description = (params[:description])
      product.active = (params[:active])
      product.user_id = (params[:user_id])
      product.url_img = (params[:url_img])
      if product.save
        render json: '[{"message":"The product was Updated"}]', status: :ok
      else
        render json: product.errors, status: :unprocessable_entity
      end
    rescue  ActiveRecord::InvalidForeignKey
      render json: '[{"error":"No valid foreign keys asignation"}]', status: 422
    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
        @product.destroy
        render json: '[{"message":"The product was Deleted"}]', status: :ok
     rescue  ActiveRecord::StatementInvalid
       render json: '[{"error":"The Product part of a transfer"}]', status: 422
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      begin
      @product = Product.find(params[:id])
     rescue ActiveRecord::RecordNotFound
       render json: '[{"error":"record not found"}]', status: 404
    rescue ActiveRecord::StatementInvalid
       render json: '[{"error":"record is in transfer table"}]', status: 404
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :active, :user_id)
    end
  end
end
