module Advocate
  class ContractViolation < StandardError
    def initialize(reason, name, value, metadata)
      super explain_message_for(reason, name, value, metadata)
    end

    private

    def explain_message_for(reason, name, value, metadata)
      message = "#{name.capitalize} "
      message << case reason
                 when :should_be_present
                   'should be present'
                 when :should_be_absent
                   'should be absent'
                 when :should_be_empty
                   'should be empty'
                 when :should_not_be_empty
                   'should not be empty'
                 when :should_be_included_in
                   "should be included in set: #{metadata}"
                 when :should_not_be_included_in
                   "should not be included in set: #{metadata}"
                 when :should_have_exactly_length
                   "should have exactly #{metadata} elements"
                 when :should_have_greater_length
                   "should have greater than #{metadata} length"
                 when :should_have_lesser_length
                   "should have lesser than #{metadata} length"
                 when :should_be_number
                   'should be a number'
                 when :should_not_be_number
                   'should not be a number'
                 when :should_be_string
                   'should be a string'
                 when :should_not_be_string
                   'should not be a string'
                 when :should_be_symbol
                   'should be a symbol'
                 when :should_not_be_symbol
                   'should not be a symbol'
                 when :should_be_boolean
                   'should be a boolean'
                 when :should_not_be_boolean
                   'should not be a boolean'
                 when :should_be_range
                   'should be a range'
                 when :should_not_be_range
                   'should not be a range'
                 when :should_be_array
                   'should be an array'
                 when :should_not_be_array
                   'should not be an array'
                 when :should_be_hash
                   'should be a hash'
                 when :should_not_be_hash
                   'should not be a hash'
                 when :should_be_regexp
                   'should be a regexp'
                 when :should_not_be_regexp
                   'should not be a regexp'
                 when :should_be_proc
                   'should be a proc'
                 when :should_noy_be_proc
                   'should not be a proc'
                 else
                   "Unknown reason: #{reason}"
                 end

      message << ".\nActual value is #{beautify(value)} (#{value.class})"
    end

    def beautify(value)
      case value
      when NilClass
        'nil'
      when String
        "\"#{value}\""
      else
        value
      end
    end

  end
end