require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "Product attributes must not be Empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "Product price should be Positive" do
    product = Product.new(title:'My book',description:'yyy', image_url:'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join("; ")

    product.price = 0
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join("; ")
    product.price = 1
    assert product.valid?
  end

  def new_product(image = "fred.gif")
    Product.new(title:'My book',description:'yyy', image_url: image, price: 1)
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = new_product()
    product.title = products(:ruby).title
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ')
  end
end
