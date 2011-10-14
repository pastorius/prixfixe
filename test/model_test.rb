require 'test_helper'

describe Model do
  it 'calculated price is always free' do
    Model.new.calculate([0,1]).must_equal 0
  end
end