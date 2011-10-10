require 'test_helper'

class VolumePriceTest < MiniTest::Unit::TestCase
  def setup
    @items = (0..49).to_a
  end

  def test_calculate_one_tier
    model = VolumePrice.new(ListPrice.new(2))
    assert_equal 100, model.calculate(@items)
  end
  
  def test_calculate_two_tiers
    model = VolumePrice.new(ListPrice.new(2)).add_tier(25, ListPrice.new(1))
    assert_equal 75, model.calculate(@items)
  end
    
  def test_calculate_three_tiers
    model = VolumePrice.new(ListPrice.new(2)).
      add_tier(20, ListPrice.new(1)).
      add_tier(40, ListPrice.new(0))
    assert_equal 60, model.calculate(@items)
  end
end