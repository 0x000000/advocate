module Advocate
  class Contract
    def initialize(method_name, &block)
      @method_name = method_name
      @block = block
    end

    def execute

    end
  end
end