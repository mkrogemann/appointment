require 'spec_helper'

module Core
  describe Alternatives do
    describe '#for_date' do
      it 'has alternatives for given date' do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:30:00+01:00')
          .until('2012-11-09T15:00:00+01:00')
          .build
        alternatives = Alternatives.new([dts])

        alternatives.for_date('2012-11-09').size.should eq(1)
        alternatives.for_date(Date.parse('2012-11-09')).size.should eq(1)
      end

      it 'has alternatives for given date and duration' do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:30:00+01:00')
          .until('2012-11-09T15:00:00+01:00')
          .build
        alternatives = Alternatives.new([dts])

        alternatives.for_date_and_duration('2012-11-09', 30).size.should eq(1)
        alternatives.for_date_and_duration(Date.parse('2012-11-09'), 30).size.should eq(1)
      end
    end
  end
end
