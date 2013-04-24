module Core
  class AppointmentError < StandardError; end

  class Appointment
    attr_reader :date_time_span, :worker

    def initialize(activity, date_time_span, worker = nil)
      raise AppointmentError if worker && collides?(worker, date_time_span)
      @date_time_span = date_time_span
      @worker = worker
    end

    def assign_worker(worker)
      raise AppointmentError if collides?(worker, date_time_span)
      @worker = worker
      @worker.add_appointment(self)
    end

    private
    def collides?(worker, date_time_span)
      worker.appointments.select {|a| a.date_time_span.overlaps?(date_time_span)}.any?
    end
  end

end