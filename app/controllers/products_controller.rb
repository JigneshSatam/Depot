class ProductsController < ApplicationController
  before_action :get_product, except:[:index, :new, :create]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(add_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render template: "products/new"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(add_params)
      redirect_to product_path(@product)
    else
      render template: "products/edit"
    end
  end

  private
  def add_params
    params.require(:product).permit(:title, :description, :image_url, :price)
  end
  def get_product
    @product = Product.find(params[:id])
  end
end
