module Prixfixe
  class CompositeContext < Context
    def initialize(model = nil)
      @model = model
    end
    
    def subtotal
      refs = contexts.collect {|c| c.to_hash[:ref]}.flatten
      @model ? @model.calculate(refs) : contexts.inject(0) {|sum, c| sum + c.total}
    end
    
    def total
      subtotal
    end
    
    def to_hash
      hash = {}
      hash[:model] = @model if @model
      hash[:contexts] = contexts.collect {|c| c.to_hash}
      hash
    end
  end
end