module Advocate
  module Matchers
    module ExistenceMatchers

      def present
        halt_chain :should_be_present if value.nil?
        self
      end
      alias_method :nil, :present

      def absent
        halt_chain :should_be_absent unless value.nil?
        self
      end
      alias_method :not_present, :absent
      alias_method :not_nil, :absent

      def empty
        present

        halt_chain :should_be_empty unless value.empty?
        self
      end

      def filled
        present

        halt_chain :should_not_be_empty if value.empty?
        self
      end
      alias_method :not_empty, :filled
    end
  end
end