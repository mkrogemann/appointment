require 'date'

module Core
  class DateTimeSpanBuilder

    def initialize
      @starting = nil
      @until = nil
    end

    def starting(date_time)
      @starting = date_time.is_a?(DateTime) ? date_time.to_s : date_time
      self
    end

    def until(date_time)
      @until = date_time.is_a?(DateTime) ? date_time.to_s : date_time
      self
    end

    # TODO: do we have to think about daylight saving?
    def lasting(minutes_int)
      @until = (DateTime.parse(@starting) + (minutes_int / (24 * 60.0))).to_s
      self
    end

    def build
      DateTimeSpan.new("#{@starting} -> #{@until}")
    end

  end
end