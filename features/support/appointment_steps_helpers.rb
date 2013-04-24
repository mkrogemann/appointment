class AppointmentStepsHelpers
  def build_date_time_span( date,hour, minutes, duration)
    DateTimeSpanBuilder.new
      .starting("#{Date.send(date).to_s}T#{hour}:#{minutes}:00+00:00")
      .lasting(duration)
      .build
  end
end
World do
  AppointmentStepsHelpers.new
end