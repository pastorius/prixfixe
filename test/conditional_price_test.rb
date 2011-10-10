require 'test_helper'

class ConditionalPriceTest < MiniTest::Unit::TestCase
  def setup
    @items = [
      OpenStruct.new({:enabled? => true}),
      OpenStruct.new({:enabled? => false}),
      OpenStruct.new,
    ]
  end

  def test_calculate_with_attribute
    proc = Proc.new {|item| item.enabled?}
    model = ConditionalPrice.new(proc, ListPrice.new(25))
    assert_equal 25, model.calculate(@items)
  end
end