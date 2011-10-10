module Prixfixe
  class UnitPrice < StaticModel
    def initialize(attr, model)
      @attr = attr
      @model = model
    end
  
    def calculate(items)
      total = items.inject(0) {|sum, item| sum + item.send(@attr.to_sym)}
      @model.calculate(total)
    end
  end
end