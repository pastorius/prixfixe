require 'test_helper'

class PrixFixe::Context
  def contexts() @contexts ||= []; end
end

class ContextTest < MiniTest::Unit::TestCase  
  def setup
    @context = Context.new
    @model = model
    @items = items
  end
  
  def test_add_context
    subcontext = Context.new
    @context.add_context(subcontext)
    assert_equal subcontext, @context.contexts.first
  end
  
  def test_to_hash
    @context = context
    
    hash = @context.to_hash
    
    assert_equal @items, hash[:ref]
    assert_equal @model, hash[:model]
    assert_equal expected_subcontext, hash[:contexts].first
  end
  
  def test_subtotal
    @context = context
    assert_equal items.size, @context.subtotal
  end
  
  def test_total
    @context = Context.new(@items, @model)
    assert_equal items.size, @context.total
  end
  
  def test_total_includes_subcontexts
    @context = context
    assert_equal items.size * 2, @context.total
  end
  
  # def test_bill_includes_subtotal
  #   @context = context
  #   
  #   bill = @context.bill
  #   
  #   assert_equal(@context.to_hash.merge(
  #     :subtotal => @items.size,
  #     :total => @items.size
  #   ), bill)
  # end
  
  # def test_bill_includes_total_subcontexts
  #   @context = context
  #   @context.add_context(context)
  # 
  #   assert_equal
  # end

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