module PrixFixe
  class ConditionalPrice < StaticModel
    def initialize(proc, model)
      @proc = proc
      @model = model
    end
  
    def calculate(items) 
      @model.calculate(items.select {|item| @proc.call(item)})
    end
  end
end