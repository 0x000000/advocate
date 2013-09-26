require 'spec_helper'

describe Advocate::ContractViolation do
  context 'when constructed' do
    context 'for messages without additional data' do
      let(:error) { Advocate::ContractViolation.new :should_be_present, :result, nil, nil }
      let(:expected_reason) { /Result should be present./ }
      let(:expected_value) { /Actual value is nil/ }
      let(:expected_class) { /(NilClass)/ }

      describe '#message' do
        it "should contain information about reason, value's name and value" do
          error.message.should match expected_reason
          error.message.should match expected_value
          error.message.should match expected_class
        end
      end
    end

    context 'for messages requires additional data' do
      let(:error) { Advocate::ContractViolation.new :should_be_included_in, :argument, 4, [1, 2, 3] }
      let(:expected_reason) { /Argument should be included in set: \[1, 2, 3]/ }
      let(:expected_value) { /Actual value is 4/ }
      let(:expected_class) { /(Fixnum)/ }

      describe '#message' do
        it "should contain information about reason, value's name, value and metadata" do
          error.message.should match expected_reason
          error.message.should match expected_value
          error.message.should match expected_class
        end
      end
    end

    describe 'private method #beautify' do
      let(:error) { Advocate::ContractViolation.new :should_be_present, :result, nil, nil }

      context 'with nil value' do
        it 'should return string value (instead of default empty string)' do
          error.send(:beautify, nil).should == 'nil'
        end
      end

      context 'with string value' do
        it 'should return string with quotes' do
          error.send(:beautify, 'foo').should == '"foo"'
        end
      end

      context 'when value.to_s is readable by default' do
        it 'should return value.to_s as is' do
          error.send(:beautify, [1, 2, 3]).should == [1, 2, 3]
        end
      end
    end
  end
end