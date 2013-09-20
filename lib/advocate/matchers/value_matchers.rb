module Advocate
  module Matchers
    module ValueMatchers

      def inclusion(opts)
        set = opts[:in] || opts[:within]

        halt_chain :should_be_included_in, set unless set.include? value
        self
      end

      def exclusion(opts)
        set = opts[:in] || opts[:within]

        halt_chain :should_not_be_included_in, set if set.include? value
        self
      end

      def length(opts)
        required_length, min_length, max_length = opts[:is], opts[:min], opts[:max]

        if required_length
          halt_chain :should_have_exactly_length, required_length if value.length != required_length
        else
          halt_chain :should_have_greater_length, min_length if min_length && value.length < min_length
          halt_chain :should_have_lesser_length,  max_length if max_length && value.length > max_length
        end

        self
      end

      def numericality
        raise NotImplementedError
      end
    end
  end
end