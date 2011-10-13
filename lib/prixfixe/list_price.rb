module Prixfixe
  class ListPrice < StaticModel
    def initialize(unit_price)
      @unit_price = unit_price
    end
  
    def calculate(items)
      if items.kind_of?(Enumerable)
        items.size * @unit_price
      else
        items * @unit_price
      end
    end
    
    def to_s
      "#{"%.2f" % @unit_price} ea."
    end
  end
end