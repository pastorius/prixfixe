require 'test_helper'

class RealTest < MiniTest::Unit::TestCase
  def test_berkeley_oil_and_gas  # first 10 stmts free/mo; $2.70/stmt after 10
    @items = (0..19).to_a
    model = VolumePrice.new(StaticModel.new).add_tier(10, ListPrice.new(2.7))
    assert_equal 27, model.calculate(@items)
  end
  
  def test_aaa # .11 /min phone; .75 /upload
    @items = [
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10})
    ]
    phone_model = UnitPrice.new(:recording_length, ListPrice.new(0.11))
    upload_model = ListPrice.new(0.75)
    uploads = @items.select {|i| i.import_source == 0}
    phone = @items.select {|i| i.import_source == 1}
    assert_equal 2.2 + 1.5, phone_model.calculate(phone) + upload_model.calculate(uploads)
  end
  
  def test_castle_point  # $50 min/mo; $5/stmt after 10
    @items = (0..19).to_a
    model = MinimumPrice.new(50, ListPrice.new(1))
    assert_equal 50, model.calculate(@items)
  end
end