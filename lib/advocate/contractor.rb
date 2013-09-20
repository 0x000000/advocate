module Advocate
  module Contractor
    def contract_for(method_name, &block)
      contracted_method = instance_method(method_name)
      contract          = Advocate::Contract.new self, contracted_method, &block

      define_method method_name do |*args|
        contract.execute *args
      end
    end
  end
end