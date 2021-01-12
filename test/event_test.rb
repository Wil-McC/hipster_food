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
    @item5 = Item.new({name: "Mango Smoothie", price: "6.00"})


    @f.stock(@item1, 35)
    @f.stock(@item2, 7)
    @f2.stock(@item4, 50)
    @f2.stock(@item3, 25)
    @f3.stock(@item1, 65)

    @expected = {
      @item1 => {quantity: 100, food_trucks: [@f, @f3]},
      @item2 => {quantity: 7, food_trucks: [@f]},
      @item3 => {quantity: 35, food_trucks: [@f2, @f3]},
      @item4 => {quantity: 50, food_trucks: [@f2]}
    }
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

  def test_it_returns_truck_names
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)

    assert_equal ["Sunfisher", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @e.food_truck_names
  end

  def test_it_gets_trucks_that_sell
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal [@f, @f3], @e.food_trucks_that_sell(@item1)
    assert_equal [@f2], @e.food_trucks_that_sell(@item4)
  end

  def test_potential_truck_revenue
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)

    assert_equal 148.75, @f.potential_revenue
    assert_equal 345.00, @f2.potential_revenue
    assert_equal 243.75, @f3.potential_revenue
  end

  def test_in_stock
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal false, @e.in_stock(@item5)
    assert_equal true, @e.in_stock(@item4)
  end

  def test_all_items_sold
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal [@item1, @item2, @item4, @item3], @e.all_items_sold
  end

  def test_total_inventory
    @f3.stock(@item3, 10)
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal @expected, @e.total_inventory
  end

  def test_overstocked_items
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal [@item1], @e.overstocked_items
  end

  def test_sorted_item_list
    expected_arr = ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]
    @e.add_food_truck(@f)
    @e.add_food_truck(@f2)
    @e.add_food_truck(@f3)
    assert_equal expected_arr, @e.sorted_item_list
  end
end
