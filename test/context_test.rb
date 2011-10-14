require 'test_helper'

class PrixFixe::Context
  def contexts() @contexts ||= []; end
end

describe Context do
  before do
    @context = Context.new
    @model = model
    @items = items
  end
  
  describe 'adding a subcontext' do
    it 'saves internally' do
      subcontext = Context.new
      @context.add_context(subcontext)
      @context.contexts.first.must_equal subcontext
    end
  end
  
  it 'returns a hash' do
    @context = context
    
    hash = @context.to_hash
    
    hash[:ref].must_equal @items
    hash[:model].must_equal @model
    hash[:contexts].first.must_equal expected_subcontext
  end
  
  it 'calculates a subtotal' do
    @context = context
    @context.subtotal.must_equal items.size
  end
  
  describe 'when calculating a total' do
    it "includes its own refs" do
      @context = Context.new(@items, @model)
      @context.total.must_equal items.size
    end
  
    it 'includes subcontexts' do
      @context = context
      @context.total.must_equal items.size * 2
    end  
  end
  
  def context
    c = Context.new(@items, @model)
    c.add_context(Context.new(@items, @model))
  end

  def expected_subcontext
    { :ref => @items, :model => @model, :contexts => [] }
  end

  def items
    (0..4).to_a
  end

  def model
    ListPrice.new(1)
  end
end