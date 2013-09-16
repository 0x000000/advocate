module Advocate
  module Contractor
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def contract_for(method_name, &block)
        #contract = Advocate::Contract.new method_name, &block
      end
    end
  end
end