module PrixFixe
  class ConditionalPrice < Model
    def initialize(proc, model)
      @proc = proc
      @model = model
    end
  
    def calculate(items) 
      @model.calculate(items.select {|item| @proc.call(item)})
    end
  end
end