require 'test_helper'

class ListPriceTest < MiniTest::Unit::TestCase
  def test_calculate
    assert_equal 100, ListPrice.new(50).calculate([0,1])
  end
end