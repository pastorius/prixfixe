require 'test_helper'

describe ConditionalPrice do
  before do
    @items = [
      OpenStruct.new({:enabled? => true}),
      OpenStruct.new({:enabled? => false}),
      OpenStruct.new
    ]
  end

  describe 'calculate' do
    it 'calls back' do
      proc = Proc.new {|item| item.enabled?}
      model = ConditionalPrice.new(proc, ListPrice.new(25))
      model.calculate(@items).must_equal 25
    end
  end
end