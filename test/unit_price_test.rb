require 'test_helper'

describe UnitPrice do
  before do
    @items = [
      OpenStruct.new({:recording_length => 10}),
      OpenStruct.new({:recording_length => 10}),
      OpenStruct.new({:recording_length => 0}),
    ]
  end
  
  it 'calculates based on an attribute' do
    model = UnitPrice.new(:recording_length, ListPrice.new(1))
    model.calculate(@items).must_equal 20
  end
end