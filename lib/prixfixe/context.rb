module Prixfixe
    class Context
  
    def add_billable(items, model)
      billables << {:ref => items, :model => model}
      self
    end
  
    def add_context(context)
      contexts << context
      self
    end
  
    def to_hash
      { :contexts => contexts.collect {|c| c.to_hash},
        :billables => billables.dup }
    end
  
    private 
    def contexts
      @contexts ||= []
    end

    def billables
      @billables ||= []
    end
  end
end