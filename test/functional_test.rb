require 'test_helper'

class RealTest < MiniTest::Unit::TestCase
  # price(@items, at(0, and_at(2.7, after(10))))
  def test_berkeley_oil_and_gas  # first 10 stmts free/mo; $2.70/stmt after 10
    @items = (0..19).to_a
    model = VolumePrice.new(StaticModel.new).add_tier(10, ListPrice.new(2.7))
    assert_equal 27, model.calculate(@items)
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
    
    uploads = @items.select {|i| i.import_source == 0}
    upload_model = ListPrice.new(0.75)
    
    assert_equal 3.7, phone_model.calculate(phone) + upload_model.calculate(uploads)
  end
  
  # price(@items, at(1, with_minimum(50)))
  def test_castle_point  # $50 min/mo; $5/stmt after 10
    cl = client
    co = Context.new
    model = MinimumPrice.new(50, ListPrice.new(1))
    
    
    co.add_context(Context.new.add_)
    
    assert_equal 50, model.calculate((0..19).to_a)
  end
  
  private
  
  def r
    1 + rand(5)
  end
  
  def gather(proc)
    (0..r).to_a.collect { proc.call }
  end
  
  def statement
    OpenStruct.new(
      :claim_number => "1000-#{r}",
      :recording_length => 1
    )
  end
  
  def user
    OpenStruct.new(
      :name => "User #{r}",
      :statements => gather(Proc.new{statement})
    )
  end
  
  def office
    OpenStruct.new(
      :name => "Office #{r}",
      :users => gather(Proc.new{user})
    )
  end
  
  def client
    OpenStruct.new(
      :name => "Client #{r}",
      :offices => gather(Proc.new{office})
    )
  end
  
end

  
  # def test_fur_reals
  #   client = OpenStruct.new(
  #     :name => 'Test Client',
  #     :offices => [
  #         OpenStruct.new(
  #           :name => 'Office 1',
  #           :statements => [
  #             OpenStruct.new(:recording_length => 1),
  #             OpenStruct.new(:recording_length => 1)
  #           ]
  #         ),
  #         OpenStruct.new(
  #           :name => 'Office 2',
  #           :statements => [
  #             OpenStruct.new(:recording_length => 1),
  #             OpenStruct.new(:recording_length => 1),
  #             OpenStruct.new(:recording_length => 1)
  #           ]
  #         )
  #       ]
  #   )
  #   
  #   client_context = Context.new(client)
  #   client.offices.each do |o|
  #     office_context = Context.new(o)
  #     office_context.add_billable(o.statements, UnitPrice.new(1, :recording_length))
  #     client_context.add_context(office_context)
  #   end
  #   bill_data = client_context.bill
  #   {
  #     :context => client,
  #     :billables => [],
  #     :contexts => [{
  #       :context => o1,
  #       :billables => [{
  #         :context => s1
  #       }]
  #     }, {
  #       :context => o2
  #     }]
  #   }
  # end