require 'spec_helper'

describe Advocate::Matchers::ValueMatchers do
  context 'included in class with #value and #halt_chain methods' do
    class AdvMatchValueTest
      attr_accessor :value

      include Advocate::Matchers::ValueMatchers

      def halt_chain(reason, value)
      end
    end

    context 'for instance of the target class' do
      subject { AdvMatchValueTest.new }

      it 'should mix all methods' do
        subject.methods.should include(:inclusion, :exclusion, :length, :numericality)
      end

      describe '#inclusion' do
        let(:set) { ['a', 'b', 'c'] }

        context 'when value is in required set' do
          before { subject.value = 'a' }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.inclusion(:in => set).should == subject
          end

          context 'with :within key instead of :in' do
            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.inclusion(:within => set).should == subject
            end
          end
        end

        context 'when value is not in required set' do
          before { subject.value = 'z' }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_be_included_in, set)
            subject.inclusion(:in => set)
          end
        end
      end

      describe '#exclusion' do
        let(:set) { ['a', 'b', 'c'] }

        context 'when value is in required set' do
          before { subject.value = 'a' }

          it 'should halt chain' do
            subject.should_receive(:halt_chain).with(:should_not_be_included_in, set)
            subject.exclusion(:in => set)
          end
        end

        context 'when value is not in required set' do
          before { subject.value = 'z' }

          it 'should continue chain' do
            subject.should_not_receive(:halt_chain)
            subject.exclusion(:in => set).should == subject
          end
        end
      end

      describe '#length' do
        context 'when option :is enabled' do
          let(:expected_value) { 2 }

          context 'when value length is the same as expected' do
            before { subject.value = [1, 2] }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.length(:is => expected_value).should == subject
            end
          end

          context 'when value length is not equals with expected length' do
            before { subject.value = [1, 2, 3] }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:should_have_exactly_length, expected_value)
              subject.length(:is => expected_value)
            end
          end
        end

        context 'when :min option is enabled' do
          let(:min_length) { 2 }

          context 'when value length > min length' do
            before { subject.value = 'abcd' }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.length(:min => min_length).should == subject
            end
          end

          context 'when value length == min length' do
            before { subject.value = 'ab' }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.length(:min => min_length).should == subject
            end
          end

          context 'when value length < min length' do
            before { subject.value = 'a' }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:should_have_greater_length, min_length)
              subject.length(:min => min_length)
            end
          end
        end

        context 'when :max option is enabled' do
          let(:max_length) { 3 }

          context 'when value length > max length' do
            before { subject.value = [1, 2, 3, 4] }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:should_have_lesser_length, max_length)
              subject.length(:max => max_length)
            end
          end

          context 'when value length == max length' do
            before { subject.value = [1, 2, 3] }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.length(:max => max_length).should == subject
            end
          end

          context 'when value length < max length' do
            before { subject.value = [1] }

            it 'should continue chain' do
              subject.should_not_receive(:halt_chain)
              subject.length(:max => max_length).should == subject
            end
          end
        end

        context 'when both :max and :min are enabled' do
          let(:min_length) { 2 }
          let(:max_length) { 3 }

          context 'when value length < min length' do
            before { subject.value = [1] }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:should_have_greater_length, min_length)
              subject.length(:min => min_length, :max => max_length)
            end
          end

          context 'when value length > max length' do
            before { subject.value = 'abcd' }

            it 'should halt chain' do
              subject.should_receive(:halt_chain).with(:should_have_lesser_length, max_length)
              subject.length(:min => min_length, :max => max_length)
            end
          end
        end

        context 'when value does not have #length method' do
          before { subject.value = nil }

          it 'should raise error' do
            expect { subject.length(:is => 1) }.to raise_error(NoMethodError)
          end
        end
      end
    end
  end
end