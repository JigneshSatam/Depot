class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  def new
    @product = Product.new
  end
  def create
    @product = Product.new(add_params)
    @product.save
    redirect_to product_path(@product)
  end
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
  def show
    @product = Product.find(params[:id])
  end
  def edit
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    @product.update(add_params)
    redirect_to product_path(@product)
  end
  private
  def add_params
    params.require(:product).permit(:title, :description, :image_url, :price)
  end
end
