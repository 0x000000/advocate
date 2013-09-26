module Advocate
  module Matchers
    class Chain
      attr_accessor :name, :value

      include ExistenceMatchers
      include TypeMatchers
      include ValueMatchers

      def initialize(name, value)
        @name, @value = name, value
      end

      def halt_chain(reason, metadata = nil)
        raise Advocate::ContractViolation.new reason, @name, @value, metadata
      end
    end
  end
end