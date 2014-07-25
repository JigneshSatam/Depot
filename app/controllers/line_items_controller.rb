class LineItemsController < ApplicationController

  def new
    @line_item = LineItem.new
  end

  def create
    @cart = current_cart
    @product = Product.find(params[:product_id])
    @line_item = @cart.add_product(@product.id)
    @line_item.cart = @cart
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(@line_item.cart,:notice => 'Line item was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  private

  # def add_params
  #   params.require(:line_item).permit(:id, :product_id)
  # end
end
