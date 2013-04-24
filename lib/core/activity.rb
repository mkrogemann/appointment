module Core
  class Activity
    attr_reader :name, :duration

    def initialize(name, duration)
      @name = name
      @duration = duration
    end

    def ==(other)
      name == other.name
    end
  end
end