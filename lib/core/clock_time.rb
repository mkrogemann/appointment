module Core
  class ClockTime
    def initialize(hour, minutes)
      raise ArgumentError, "illegal hour: #{hour}" unless (1..23).include? hour
      raise ArgumentError, "illegal minutes: #{minutes}" unless (0..59).include? minutes
      @hour = hour
      @minutes = minutes
    end
  end
end