require_relative 'test_helper'

class ItemTest < Minitest::Test

  def setup
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists_with_attributes
    assert_instance_of Item, @item2
    assert_equal "Apple Pie (Slice)", @item2.name
    assert_equal 2.50, @item2.price
  end
end
