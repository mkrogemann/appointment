module Core
  class AppointmentMaker

    def request(activity, date_time_span, worker)
      begin
        Appointment.new(activity, date_time_span, worker)
      rescue AppointmentError => e
        alternatives(activity, date_time_span, worker)
      end
    end

    def alternatives(activity, date_time_span, worker)
      # TODO: implement worker based lookup
      Alternatives.new([])
    end
  end
end