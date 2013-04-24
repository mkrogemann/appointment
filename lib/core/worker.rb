module Core
  class Worker

    attr_reader :appointments

    def initialize(activities = nil)
      @activities = activities
      @appointments = [] # is this the kind of TODO you had in mind?
    end

    def can_do?(activity)
      @activities.include? activity
    end

    def available?(date_time_span)
      # TODO
      working(date_time_span) && !appointed(date_time_span)
    end

    def add_appointment(appointment)
      @appointments << appointment
    end

    def working(date_time_span)
      true
    end

    def appointed(date_time_span)
      false
    end
  end
end