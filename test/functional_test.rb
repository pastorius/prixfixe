require 'test_helper'

class RealTest < MiniTest::Unit::TestCase
  
  def setup
    @statements = statements
  end
  
  # price(@items, at(0, and_at(2.7, after(10))))
  def test_berkeley_oil_and_gas  # first 10 stmts free/mo; $2.70/stmt after 10
    @statements = []
    @statements << statement until @statements.size == 10
    model = VolumePrice.new(StaticModel.new).add_tier(10, ListPrice.new(2.7))
    cc = Context.new(@statements, model)
    
    assert_equal 0, cc.total
    
    @statements << statement until @statements.size == 20
    assert_equal 27, cc.total
  end
  
  # price(phone, units_of(:recording_length, at(0.11)))
  # price(uploads, at(0.75))
  def test_aaa # .11 /min phone; .75 /upload
    @items = [
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 0, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10}),
      OpenStruct.new({:import_source => 1, :recording_length => 10})
    ]
    
    cc = CompositeContext.new

    phone = @items.select {|i| i.import_source == 1}
    phone_model = UnitPrice.new(:recording_length, ListPrice.new(0.11))
    cc.add_context(Context.new(phone, phone_model))
    
    uploads = @items.select {|i| i.import_source == 0}
    upload_model = ListPrice.new(0.75)
    cc.add_context(Context.new(uploads, upload_model))
    
    assert_equal 4.8, cc.total
    # p cc.to_hash
  end
  
  # price(@items, at(1, with_minimum(50)))
  def test_castle_point  # $50 min/mo; $5/stmt after 10
    cc = Context.new(@statements, MinimumPrice.new(50, ListPrice.new(1)))

    assert_equal 50, cc.total
    
    @statements << statement until @statements.size == 51
    assert_equal 51, cc.total
  end
  
  private
  
  def statements
    client.offices.collect {|o| o.users.collect {|u| u.statements}}.flatten
  end
  
  def r
    1 + rand(1)
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