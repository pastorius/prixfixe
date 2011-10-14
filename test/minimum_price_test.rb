require 'test_helper'

describe MinimumPrice do
  before do
    @items = (0..19).to_a
  end
  
  describe 'calculate' do 
    it 'returns the minimum price when it matches the calculated price' do
      model = MinimumPrice.new(20, ListPrice.new(1))
      model.calculate(@items).must_equal 20
    end
  
    it 'returns the minimum price when the calculated price is lower' do
      model = MinimumPrice.new(21, ListPrice.new(1))
      model.calculate(@items).must_equal 21
    end
  
    it 'returns the calculated price when the calculated price is higher' do
      model = MinimumPrice.new(10, ListPrice.new(1))
      model.calculate(@items).must_equal 20
    end
  end  
end