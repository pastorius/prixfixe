module PrixFixe
  class UnitPrice < Model
    def initialize(attr, model)
      @attr = attr
      @model = model
    end
  
    def calculate(items)
      total = items.inject(0) {|sum, item| sum + item.send(@attr.to_sym)}
      @model.calculate(total)
    end
    
    def to_s
      "#{@model.to_s} per unit of #{@attr.to_s}"
    end
  end
end