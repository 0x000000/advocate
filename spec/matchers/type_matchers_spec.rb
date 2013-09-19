require 'spec_helper'

describe Advocate::Matchers::TypeMatchers do
  context 'included in class with #value and #halt_chain methods' do
    class AdvMatchTypeTest
      attr_accessor :value

      include Advocate::Matchers::TypeMatchers

      def halt_chain(reason)
      end
    end

    context 'for instance of the target class' do
      subject { AdvMatchTypeTest.new }

      it 'should mix all methods' do
        subject.methods.should include(
                                 :number, :string, :symbol, :boolean, :range, :array, :hash, :regexp,
                                 :not_number, :not_string, :not_symbol, :not_boolean, :not_range, :not_array, :not_hash, :not_regexp
                               )
      end

      {
        :number  => {:positive => 10,         :negative => 'x'},
        :string  => {:positive => 'Hi!',      :negative => nil},
        :symbol  => {:positive => :hi,        :negative => 'hi'},
        :boolean => {:positive => true,       :negative => 10},
        :range   => {:positive => (1..2),     :negative => [1, 2]},
        :array   => {:positive => [1, 2],     :negative => {1 => 2}},
        :hash    => {:positive => {:a => :b}, :negative => [1, 2]},
        :regexp  => {:positive => /wow/,      :negative => 'hi'},
      }.each do |name, values|
        describe "#{name}" do
          context "for #{name} values" do
            before { subject.value = values[:positive] }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.public_send(name).should == subject
            end
          end

          context "for not #{name} values" do
            before { subject.value = values[:negative] }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:"should_be_#{name}")
              subject.public_send name
            end
          end
        end

        describe "not_#{name}" do
          context "for #{name} values" do
            before { subject.value = values[:positive] }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:"should_not_be_#{name}")
              subject.public_send :"not_#{name}"
            end
          end

          context "for not #{name} values" do
            before { subject.value = values[:negative] }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.public_send(:"not_#{name}").should == subject
            end
          end
        end
      end

    end
  end
end