require 'test_helper'

class PrixFixe::CompositeContext
  def contexts() @contexts ||= []; end
end

class CompositeContextTest < MiniTest::Unit::TestCase  
  def setup
    @model = ListPrice.new(2)
    @context = CompositeContext.new(@model).
      add_context(subcontext).
      add_context(subcontext)
  end
  
  def test_subtotal_overrides_composite_parts
    assert_equal 8, @context.subtotal
  end
  
  def test_total_is_subtotal
    assert_equal 8, @context.total
  end
  
  def test_to_hash
    hash = @context.to_hash
    assert !hash.include?(:ref)
    assert_equal @model, hash[:model]
    assert_equal subcontext.to_hash.to_s, hash[:contexts].first.to_s
  end
  
  def test_to_hash_includes_no_model_if_nil
    @context = CompositeContext.new.add_context(subcontext)
    assert !@context.to_hash.include?(:model)
  end
  
  def subcontext
    Context.new([0,1], ListPrice.new(1))
  end
end