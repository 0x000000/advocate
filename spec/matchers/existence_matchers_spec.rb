require 'spec_helper'

describe Advocate::Matchers::ExistenceMatchers do
  context 'included in class with #value and #halt_chain methods' do
    class AdvMatchExstTest
      attr_accessor :value

      include Advocate::Matchers::ExistenceMatchers

      def halt_chain(reason)
      end
    end

    context 'for instance of the target class' do
      subject { AdvMatchExstTest.new }

      it 'should mix all methods' do
        subject.methods.should include(:present, :not_nil, :absent, :not_present, :nil,
                                       :empty, :filled, :not_empty)
      end

      describe '#present' do
        context 'for not nil objects' do
          before { subject.value = 'Hi!' }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.present.should == subject
          end
        end

        context 'for nil objects' do
          before { subject.value = nil }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_be_present)
            subject.present
          end
        end
      end

      describe '#absent' do
        context 'for not nil objects' do
          before { subject.value = 'Hi!' }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_be_absent)
            subject.absent
          end
        end

        context 'for nil objects' do
          before { subject.value = nil }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.absent.should == subject
          end
        end
      end

      describe '#empty' do
        context 'for empty objects' do
          before { subject.value = [] }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.empty.should == subject
          end
        end

        context 'for not empty objects' do
          before { subject.value = {:a => 1} }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_be_empty)
            subject.empty
          end
        end

        context 'for objects without #empty? method' do
          before { subject.value = nil }

          it { expect { subject.empty }.to raise_error(NoMethodError) }
        end
      end

      describe '#filled' do
        context 'for empty objects' do
          before { subject.value = [] }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_not_be_empty)
            subject.filled
          end
        end

        context 'for not empty objects' do
          before { subject.value = {:a => 1} }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.filled.should == subject
          end
        end

        context 'for objects without #empty? method' do
          before { subject.value = nil }

          it { expect { subject.filled }.to raise_error(NoMethodError) }
        end
      end
    end
  end
end