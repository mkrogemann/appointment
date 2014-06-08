require 'spec_helper'

module Core
  describe DateTimeSpan do
    describe '#initialize' do
  	  context "parse from input string" do
        it "expects the separator ' -> ' between two date-times" do
          expect {
            DateTimeSpan.new('2012-11-09T14:20:00+01:00 ->2012-11-09T15:10:00+01:00')
          }.to raise_error ArgumentError
        end

        it "expects an input format of '2012-11-09T14:20:00+01:00 -> 2012-11-09T15:10:00+01:00'" do
          date_time_span = DateTimeSpan.new('2012-11-09T14:20:00+01:00 -> 2012-11-09T15:10:00+01:00')
          date_time_span.begin_dt.should eq DateTime.parse('2012-11-09T14:20:00+01:00')
          date_time_span.end_dt.should eq DateTime.parse('2012-11-09T15:10:00+01:00')
        end

        # one more for invalid begin, end
        it "invalid begin- or end-date should not parse" do
          expect {
            DateTimeSpan.new('2012-11-0914:20:00+01:00 -> 2012-11-09T15:10:00+01:00')
          }.to raise_error ArgumentError

          expect {
            DateTimeSpan.new('2012-11-09T14:20:00+01:00 -> 202-11-09T15:10:00+01:00')
          }.to raise_error ArgumentError
        end
      end
    end

    describe '#to_s' do
      it "concatenates to 'begin_date_time -> end_date_time'" do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until('2012-11-09T15:10:00+01:00')
          .build
        dts.to_s.should == '2012-11-09T14:20:00+01:00 -> 2012-11-09T15:10:00+01:00'
      end
    end

    describe '#duration_minutes' do
      it 'returns the duration in minutes' do
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until('2012-11-09T15:10:00+01:00')
          .build
        dts.duration_minutes.should == 50
      end
    end

    describe '#overlaps?' do
      let(:dts1) do
        DateTimeSpanBuilder.new
          .starting('2012-11-09T14:20:00+01:00')
          .until('2012-11-09T15:10:00+01:00')
          .build
      end

      context 'first contains second' do
        # ----  ----
        # |  |  |  |
        # ----  ----
        it 'overlaps when both are equal' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:20:00+01:00')
            .until('2012-11-09T15:10:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        # ----  ----
        # |  |  ----
        # ----
        it 'overlaps when first and second start at the same time' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:20:00+01:00')
            .until('2012-11-09T15:00:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        # ----
        # |  |  ----
        # ----  ----
        it 'overlaps when first and second end at the same time' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:30:00+01:00')
            .until('2012-11-09T15:10:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        # ----
        # |  |  ----
        # |  |  ----
        # ----
        it 'overlaps when first fully contains second' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:30:00+01:00')
            .until('2012-11-09T15:00:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end
      end

      context 'second contains first' do
        # ----  ----
        # ----  |  |
        #       ----
        it 'overlaps when first and second begin at the same time' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:20:00+01:00')
            .until('2012-11-09T15:20:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        #       ----
        # ----  |  |
        # ----  ----
        it 'overlaps when first and second end at the same time' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:00:00+01:00')
            .until('2012-11-09T15:10:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        #       ----
        # ----  |  |
        # ----  |  |
        #       ----
        it 'overlaps when second fully contains first' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:10:00+01:00')
            .until('2012-11-09T15:20:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end
      end

      context 'they intersect' do
        # ----
        # |  |  ----
        # ----  |  |
        #       ----
        it 'overlaps when first begins before second and ends after first begins but before second ends' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:30:00+01:00')
            .until('2012-11-09T15:20:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end

        #       ----
        # ----  |  |
        # |  |  ----
        # ----
        it 'overlaps when second begins before first and ends before first ends but after first starts' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:10:00+01:00')
            .until('2012-11-09T15:00:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_truthy
        end
      end

      context 'they do not intersect' do
        # ----
        # ----  ----
        #       ----
        it 'second begins when first ends' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:10:00+01:00')
            .until('2012-11-09T15:30:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_falsey
        end

        #       ----
        # ----  ----
        # ----
        it 'second ends when first starts' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T13:50:00+01:00')
            .until('2012-11-09T14:20:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_falsey
        end

        # ----
        # ----
        #       ----
        #       ----
        it 'second begins after first ends' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:30:00+01:00')
            .until('2012-11-09T15:50:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_falsey
        end

        #       ----
        #       ----
        # ----
        # ----
        it 'second ends before first starts' do
          dts2 = DateTimeSpanBuilder.new
            .starting('2012-11-09T14:00:00+01:00')
            .until('2012-11-09T14:10:00+01:00')
            .build
          dts1.overlaps?(dts2).should be_falsey
        end
      end
    end
  end
end
