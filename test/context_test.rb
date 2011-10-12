require 'test_helper'

class Prixfixe::Context
  def billables() @billables ||= []; end
  def contexts() @contexts ||= []; end
end

class ContextTest < MiniTest::Unit::TestCase  
  def setup
    @context = Context.new
    @model = model
    @items = items
  end
  
  def test_add_billable
    @context.add_billable(items, @model)

    assert_equal @items, @context.billables.first[:ref]
    assert_equal @model, @context.billables.first[:model]
  end
  
  def test_add_context
    subcontext = Context.new
    @context.add_context(subcontext)
    assert_equal subcontext, @context.contexts.first
  end
  
  def test_to_hash
    @context = context
    @context.add_context(context)
    
    hash = @context.to_hash
    
    assert_equal({ 
      :contexts => [expected_context], 
      :billables => [expected_billable] 
    }, hash)
  end

  def context
    subcontext = Context.new
    subcontext.add_billable(@items, @model)
    subcontext
  end
  
  def expected_context
    {
      :contexts => [],
      :billables => [expected_billable]
    }
  end
  
  def expected_billable
    {
      :ref => @items,
      :model => @model
    }
  end
  
  def items
    (0..4).to_a
  end
  
  def model
    ListPrice.new(1)
  end
end