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
<<<<<<< HEAD
=======
    
    def to_s
      "#{@model.to_s}; #{"%.2f" % @min} minimum"
    end
>>>>>>> develop
  end
end