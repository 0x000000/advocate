require 'spec_helper'

describe Advocate::Matchers::Chain do
  it 'should have #halt_chain method' do
    Advocate::Matchers::Chain.public_instance_methods(false).should include(:halt_chain)
  end

  context 'created for string value' do
    let(:chain) { Advocate::Matchers::Chain.new :result, 'hi' }

    it 'should provide chain of methods until error' do
      chain.present.string.present.length(:min => 1).string.length(:max => 10).should == chain
    end

    it 'should return boolean value for methods with "?"' do
      chain.number?.should == false
      chain.should be_string
    end

    it 'should raise error when one of statements is false' do
      expect { chain.boolean }.to raise_error Advocate::ContractViolation, /Result should be a boolean/
    end
  end
end