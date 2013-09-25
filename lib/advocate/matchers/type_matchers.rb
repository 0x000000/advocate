module Advocate
  module Matchers
    module TypeMatchers

      def number?
        value.kind_of? Numeric
      end

      def string?
        value.kind_of? String
      end

      def symbol?
        value.kind_of? Symbol
      end

      def boolean?
        value == true || value == false
      end

      def range?
        value.kind_of? Range
      end

      def array?
        value.kind_of? Array
      end

      def hash?
        value.kind_of? Hash
      end

      def regexp?
        value.kind_of? Regexp
      end

      def proc?
        value.kind_of? Proc
      end

      def number
        halt_chain :should_be_number unless number?
        self
      end

      def not_number
        halt_chain :should_not_be_number if number?
        self
      end

      def string
        halt_chain :should_be_string unless string?
        self
      end

      def not_string
        halt_chain :should_not_be_string if string?
        self
      end

      def symbol
        halt_chain :should_be_symbol unless symbol?
        self
      end

      def not_symbol
        halt_chain :should_not_be_symbol if symbol?
        self
      end

      def boolean
        halt_chain :should_be_boolean unless boolean?
        self
      end

      def not_boolean
        halt_chain :should_not_be_boolean if boolean?
        self
      end

      def range
        halt_chain :should_be_range unless range?
        self
      end

      def not_range
        halt_chain :should_not_be_range if range?
        self
      end

      def array
        halt_chain :should_be_array unless array?
        self
      end

      def not_array
        halt_chain :should_not_be_array if array?
        self
      end

      def hash
        halt_chain :should_be_hash unless hash?
        self
      end

      def not_hash
        halt_chain :should_not_be_hash if hash?
        self
      end

      def regexp
        halt_chain :should_be_regexp unless regexp?
        self
      end

      def not_regexp
        halt_chain :should_not_be_regexp if regexp?
        self
      end

      def proc
        halt_chain :should_be_proc unless proc?
        self
      end

      def not_proc
        halt_chain :should_not_be_proc if proc?
        self
      end
    end
  end
end