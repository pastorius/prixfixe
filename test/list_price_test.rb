require 'test_helper'

describe ListPrice do
  it 'calculates using fixed pricing' do
    ListPrice.new(50).calculate([0,1]).must_equal 100
  end
end