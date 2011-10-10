module Prixfixe
  class MinimumPrice < StaticModel
    def initialize(min, model) 
      @min = min
      @model = model
    end
  
    def calculate(items)
      calculated = @model.calculate(items)
      calculated < @min ? @min : calculated
    end
  end
end