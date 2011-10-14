require 'test_helper'

class PrixFixe::CompositeContext
  def contexts() @contexts ||= []; end
end

describe CompositeContext do
  before do
    @model = ListPrice.new(2)
    @context = CompositeContext.new(@model).
      add_context(subcontext).
      add_context(subcontext)
  end
  
  describe 'subtotal' do
    it 'overrides composite part pricing' do
      @context.subtotal.must_equal 8
    end
  end
  
  describe 'total' do
    it 'equals the subtotal' do
      @context.total.must_equal 8
    end
  end
  
  describe 'to_hash' do
    it 'includes ref, model, and context info' do
      hash = @context.to_hash
      hash.wont_include :ref
      hash[:model].must_equal @model
      hash[:contexts].first.to_s.must_equal subcontext.to_hash.to_s
    end
  
    it 'only includes model if it exists' do
      @context = CompositeContext.new.add_context(subcontext)
      @context.to_hash.wont_include :model
    end
  end
  
  def subcontext
    Context.new([0,1], ListPrice.new(1))
  end
end