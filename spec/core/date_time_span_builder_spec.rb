require 'spec_helper'
require 'core'

module Core

  describe DateTimeSpanBuilder do

    context "#build" do

      it "should construct an instance of DateTimeSpan spanning from 'starting' to 'until'" do
        DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until('2012-11-09T15:10:00+01:00')
          .build
          .should == DateTimeSpan.new('2012-11-09T14:20:00+01:00 -> 2012-11-09T15:10:00+01:00')

      end

      it "allows adding a duration in minutes to a given start time" do
        DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .lasting(45)
          .build
          .should == DateTimeSpan.new('2012-11-09T14:20:00+01:00 -> 2012-11-09T15:05:00+01:00')
      end

      it 'accepts DateTime arguments for starting' do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .lasting(45)
          .build
        DateTimeSpanBuilder.new
          .starting(DateTime.parse('2012-11-09T14:20:00+01:00'))
          .lasting(45)
          .build
          .should == dts
      end

      it 'accepts DateTime arguments for until' do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until('2012-11-09T15:10:00+01:00')
          .build
        DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until(DateTime.parse('2012-11-09T15:10:00+01:00'))
          .build
          .should == dts
      end
    end
  end
end