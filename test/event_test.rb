require_relative 'test_helper'

class EventTest < Minitest::Test

  def setup
    @e = Event.new("Moondog")
    @f = FoodTruck.new("Sunfisher")
    @f2 = FoodTruck.new("Ba-Nom-a-Nom")
    @f3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @f.stock(@item1, 35)
    @f.stock(@item2, 7)
    @f2.stock(@item4, 50)
    @f2.stock(@item3, 25)
    @f3.stock(@item1, 65)
  end

  def test_it_exists_with_attributes
    assert_instance_of Event, @e
    assert_equal "Moondog", @e.name
    assert_equal [], @e.food_trucks
  end

  def test_it_adds_food_trucks
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)

    assert_equal [@f, @f2, @f3], @e.food_trucks
  end
end
