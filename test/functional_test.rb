require 'test_helper'

class BillingPlan
  def initialize
    @models = []
  end
  
  def add_model(items, model)
    @models << {:items => items, :model => model}
  end
  
  def calculate
    @models.inject(0) {|sum, model| sum + model[:model].calculate(model[:items])}
  end
end

class RealTest < MiniTest::Unit::TestCase
  def setup
    @bp = BillingPlan.new
  end
  
  # price(@items, at(0, and_at(2.7, after(10))))
  def test_berkeley_oil_and_gas  # first 10 stmts free/mo; $2.70/stmt after 10
    @items = (0..19).to_a
    model = VolumePrice.new(StaticModel.new).add_tier(10, ListPrice.new(2.7))
    p model.to_s
    @bp.add_model(@items, model)
    assert_equal 27, @bp.calculate
  end
  
  # price(phone, units_of(:recording_length, at(0.11)))
  # price(uploads, at(0.75))
  def test_aaa # .11 /min phone; .75 /upload
    @items = [
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10})
    ]

    phone = @items.select {|i| i.import_source == 1}
    phone_model = UnitPrice.new(:recording_length, ListPrice.new(0.11))
    @bp.add_model(phone, phone_model)
    p phone_model.to_s
    
    uploads = @items.select {|i| i.import_source == 0}
    upload_model = ListPrice.new(0.75)
    @bp.add_model(uploads, upload_model)
    p upload_model.to_s
    
    assert_equal 3.7, @bp.calculate
  end
  
  # price(@items, at(1, with_minimum(50)))
  def test_castle_point  # $50 min/mo; $5/stmt after 10
    @items = (0..19).to_a
    @bp.add_model(@items, MinimumPrice.new(50, ListPrice.new(1)))
    assert_equal 50, @bp.calculate
  end
end