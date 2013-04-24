module Core
  class Alternatives

    def initialize(date_time_spans)
      @date_time_spans = date_time_spans
    end

    def for_date(date)
      d = date.is_a?(Date) ? date : Date.parse(date)
      _for { |dts| dts.begin_dt.to_date === d }
    end

    def for_date_and_duration(date, duration)
      d = date.is_a?(Date) ? date : Date.parse(date)
      _for { |dts| dts.begin_dt.to_date === d && dts.duration_minutes === duration }
    end

    private
    def _for(&block)
      @date_time_spans.select { block }
    end

  end
end