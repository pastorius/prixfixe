require 'test_helper'

describe StaticModel do
  it 'calculated price is always free' do
    StaticModel.new.calculate([0,1]).must_equal 0
  end
end