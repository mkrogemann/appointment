module Core
  class DateTimeSpan

    attr_reader :begin_dt, :end_dt

    DATE_TIME_REGEX = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}$/

    def initialize(dt_span_str)
      @begin_dt, @end_dt = parse(dt_span_str)
    end

    def ==(other)
      other.begin_dt == self.begin_dt &&
        other.end_dt == self.end_dt
    end

    def to_s
      "#{@begin_dt} -> #{@end_dt}"
    end

    # TODO: worry about the accuracy of Ruby Rational?
    def duration_minutes
      ((@end_dt - @begin_dt) * 24 * 60).to_i
    end

    def overlaps?(other)
      other == self ||
      begin_dt <= other.begin_dt && end_dt >= other.end_dt ||
      other.begin_dt <= begin_dt && other.end_dt >= end_dt ||
      begin_dt < other.begin_dt && end_dt > other.begin_dt && end_dt < other.end_dt ||
      begin_dt > other.begin_dt && end_dt > other.end_dt && begin_dt < other.end_dt
    end

    private
    def parse(dt_span_str)
      dts = dt_span_str.split(" -> ")
      [:begin_dt, :end_dt].each_with_index do |sym, i|
        raise ArgumentError, "Invalid date time string passed in for #{sym}, or separator (' -> ') broken in: #{dt_span_str}" \
          if DATE_TIME_REGEX.match(dts[i]).nil?
      end
      [DateTime.parse(dts[0]), DateTime.parse(dts[1])]
    end

  end
end