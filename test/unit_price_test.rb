require 'test_helper'

class UnitPriceTestTest < MiniTest::Unit::TestCase
  def setup
    @items = [
      OpenStruct.new({:recording_length => 10}),
      OpenStruct.new({:recording_length => 10}),
      OpenStruct.new({:recording_length => 0}),
    ]
  end
  
  def test_calculate
    model = UnitPrice.new(:recording_length, ListPrice.new(1))
    assert_equal 20, model.calculate(@items)
  end
end