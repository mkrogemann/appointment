require 'spec_helper'

module Core
  describe ClockTime do
    describe '#initialize' do
      it 'should throw an ArgumentError for illegal hour' do
        expect {
          ClockTime.new(25,20)
        }.to raise_error(ArgumentError, 'illegal hour: 25')
      end

      it 'should throw an ArgumentError for illegal minutes' do
        expect {
          ClockTime.new(23,67)
        }.to raise_error(ArgumentError, 'illegal minutes: 67')
      end

      it 'should create with valid arguments' do
        ClockTime.new(23,40).should be_a(ClockTime)
      end
    end
  end
end