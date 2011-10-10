require 'test_helper'

class MinimumPriceTest < MiniTest::Unit::TestCase
  def setup
    @items = (0..19).to_a
  end
  
  def test_calculate_with_exact_match
    model = MinimumPrice.new(20, ListPrice.new(1))
    assert_equal 20, model.calculate(@items)
  end
  
  def test_calculate_under_min
    model = MinimumPrice.new(21, ListPrice.new(1))
    assert_equal 21, model.calculate(@items)    
  end
  
  def test_calculate_over_min
    model = MinimumPrice.new(10, ListPrice.new(1))
    assert_equal 20, model.calculate(@items)    
  end
end  