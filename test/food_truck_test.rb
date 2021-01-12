require_relative 'test_helper'

class FoodTruckTest < Minitest::Test

  def setup
    @f = FoodTruck.new("Sunfisher")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists_with_attributes
    assert_instance_of FoodTruck, @f
    assert_equal "Sunfisher", @f.name
    assert_equal Hash.new, @f.inventory
  end

  def test_it_check_stock
    assert_equal 0, @f.check_stock(@item1)
  end

  def test_it_can_stock_inventory
    assert_equal 0, @f.check_stock(@item1)
    @f.stock(@item1, 30)
    assert_equal 30, @f.check_stock(@item1)
    @f.stock(@item1, 25)
    assert_equal 55, @f.check_stock(@item1)
    @f.stock(@item2, 12)
    assert_equal 55, @f.check_stock(@item1)
    assert_equal 12, @f.check_stock(@item2)
    require "pry"; binding.pry
  end
end
