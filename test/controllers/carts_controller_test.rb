require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      session[:cart_id] = @cart.id
      delete :destroy, :id => @cart.to_param
    end
    assert_redirected_to stores_path
  end
end
