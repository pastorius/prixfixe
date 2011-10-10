require 'test_helper'

class StaticModelTest < MiniTest::Unit::TestCase
  def test_calculate
    assert_equal 0, StaticModel.new.calculate([0,1])
  end
end