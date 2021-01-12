class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.select do |truck|
      truck.inventory[item] > 0
    end
  end

  def all_items_sold
    @food_trucks.map do |f|
      f.items_sold
    end.flatten.uniq
  end

  def total_quantity(item)
    @food_trucks.sum do |f|
      f.check_stock(item)
    end
  end

  def items_and_trucks(item)
    h = Hash.new
    h[:quantity] = total_quantity(item)
    h[:food_trucks] = food_trucks_that_sell(item)
    h
  end

  def total_inventory
    h = Hash.new({})
    all_items_sold.each do |item|
      h[item] = items_and_trucks(item)
    end
    h
  end

  def overstocked_items
    all_items_sold.select do |item|
      total_quantity(item) > 50 && food_trucks_that_sell(item).length > 1
    end
  end

  def in_stock(item)
    @food_trucks.any? do |f|
      f.check_stock(item) > 0
    end
  end

  def sorted_item_list
    names = []
    all_items_sold.each do |item|
      names << item.name if in_stock(item)
    end
    names.sort
  end
end
