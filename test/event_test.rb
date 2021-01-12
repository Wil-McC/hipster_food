require_relative 'test_helper'

class EventTest < Minitest::Test

  def setup
    @e = Event.new("Moondog")
  end

  def test_it_exists_with_attributes
    assert_instance_of Event, @e
    assert_equal "Moondog", @e.name
    assert_equal [], @e.food_trucks
  end
end
