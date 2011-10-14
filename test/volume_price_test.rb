require 'test_helper'

describe VolumePrice do
  before do
    @items = (0..49).to_a
  end

  describe 'calculate' do
    it 'applies one-tiered pricing' do
      model = VolumePrice.new(ListPrice.new(2))
      model.calculate(@items).must_equal 100
    end
  
    it 'applies two-tiered pricing' do
      model = VolumePrice.new(ListPrice.new(2)).add_tier(25, ListPrice.new(1))
      model.calculate(@items).must_equal 75
    end
    
    it 'applies three-tiered pricing' do
      model = VolumePrice.new(ListPrice.new(2)).
        add_tier(20, ListPrice.new(1)).
        add_tier(40, ListPrice.new(0))
      model.calculate(@items).must_equal 60
    end
  end
end