require 'spec_helper'

module Core
  describe Worker do
    describe '#can_do?' do
      it 'returns true if it can do given activity' do
        worker = Worker.new([Activity.new(:activity_1, 60)])
        activity = Activity.new(:activity_1, 60)
        worker.can_do?(activity).should be_true
      end

      it 'returns false if it cannot do given activity' do
        worker = Worker.new([Activity.new(:activity_1, 60)])
        activity = Activity.new(:activity_2, 60)
        worker.can_do?(activity).should be_false
      end
    end

    describe '#available?' do
      it 'returns true if it is available for given date time span' do
        worker = Worker.new # TODO working hours
        tomorrow = DateTime.now + 1
        date_time_span = DateTimeSpanBuilder.new
          .starting(tomorrow)
          .lasting(60)
          .build()
        worker.available?(date_time_span).should be_true
      end
    end

    describe '#appointments' do
      it 'returns worker appointments' do
        appointment = double("appointment")
        worker = Worker.new
        worker.add_appointment(appointment)
        worker.appointments.should == [appointment]
      end
    end
  end
end
