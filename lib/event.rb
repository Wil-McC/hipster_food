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

  def total_inventory
    h = Hash.new({})
    all_items_sold.each do |item|
      h[item][:quantity] = item.total_quantity
      h[item][:food_trucks]  = food_trucks_that_sell(item)
    end
  end
end
