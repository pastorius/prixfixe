module Prixfixe
  class VolumePrice < StaticModel
    def initialize(base_model)
      @tiers = {0 => base_model}
    end
  
    def calculate(items)    
      sorted_keys.inject(0) do |sum, k| 
        current_tier = @tiers[k]
        current_items = items[k..last_index(k)]
        sum + current_tier.calculate(current_items)
      end
    end
  
    def add_tier(tier, model)
      @tiers[tier] = model
      self
    end
  
    private
    def sorted_keys
      @tiers.keys.sort {|x, y| x <=> y}
    end
  
    def last_index(key)
      min = sorted_keys.select {|k| k > key}.min 
      min.nil? ? -1 : min - 1
    end
  end
end