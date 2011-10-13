require 'ostruct'

module PrixFixe
  class Context
    def initialize(ref = OpenStruct.new, model = StaticModel.new)
      @ref = ref
      @model = model
    end
    
    def add_context(context)
      contexts << context
      self
    end
  
    def subtotal
      @model.calculate(@ref)
    end
    
    def total
      contexts.inject(subtotal) {|sum, c| sum + c.subtotal}
    end
    
    def bill
      to_hash.merge(:subtotal => subtotal)
    end
    
    def to_hash
      { 
        :ref => @ref,
        :model => @model,
        :contexts => contexts.collect {|c| c.to_hash} 
      }
    end
  
    private 
    def contexts
      @contexts ||= []
    end
  end
end