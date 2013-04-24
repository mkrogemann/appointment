include Core

Given /^'Appointment' has a worker available for the activity "(.*?)" at "(.*?)":"(.*?)" "(.*?)"$/ do |activity, hour, minutes, date|
  @activity = Activity.new(activity.to_sym, 60)
  @worker = Worker.new([@activity])
  date_time_span = build_date_time_span(date, hour, minutes, @activity.duration)
  @worker.available?(date_time_span)
end

Given(/^a worker with an appointment at "(.*?)":"(.*?)" "(.*?)"$/) do |hour, minutes, date|
  activity = Activity.new("any_activity".to_sym, 60)
  @worker = Worker.new
  date_time_span = build_date_time_span(date, hour, minutes, activity.duration)
  appointment = Appointment.new(activity, date_time_span, @worker)
  appointment.assign_worker(@worker)
end

When /^I request an appointment for this activity at "(.*?)":"(.*?)" "(.*?)"$/ do |hour, minutes, date|
  date_time_span = build_date_time_span(date, hour, minutes, @activity.duration)
  @appointment = Appointment.new(@activity, date_time_span, @worker)
end

Then /^an appointment is created$/ do
  @appointment.should_not be_nil
end

Then(/^'Appointment' denies an attempt to create an appointment at "(.*?)":"(.*?)" "(.*?)"$/) do |hour, minutes, date|
  activity = Activity.new("some_arbitrary_activity".to_sym, 30)
  date_time_span = build_date_time_span(date, hour, minutes, activity.duration)
  expect {
    requested_appointment = Appointment.new(activity, date_time_span, @worker)
  }.to raise_error(AppointmentError)
end

Then(/^'Appointment' offers alternative times for the desired appointment$/) do
  pending # express the regexp above with the code you wish you had
end
