require 'spec_helper'

describe Advocate::Contractor do
  context 'when included to some class' do
    class AdvContractorTestClass
      include Advocate::Contractor
    end

    it 'should add contract_for class method' do
      AdvContractorTestClass.methods.should include(:contract_for)
    end
  end
end