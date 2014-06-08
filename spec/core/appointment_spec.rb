require 'spec_helper'

module Core
  describe Appointment do
    describe '#initialize' do
      it 'creates an Appointment (happy path)' do
        worker = double('worker')
        expect(worker).to receive(:appointments).and_return []
        activity = double('activity')
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T15:30:00+01:00')
          .until('2012-11-09T15:50:00+01:00')
          .build
        Appointment.new(activity, dts, worker).should be_a(Appointment)
      end

      it 'cannot create an appointment that collides with another worker appointment' do
        activity = double('activity')
        dts = DateTimeSpanBuilder.new
          .starting('2012-11-09T15:30:00+01:00')
          .until('2012-11-09T15:50:00+01:00')
          .build
        ## FIXME: Big smell (?) coming up
        appointment = Appointment.new(activity, dts)
        worker = Worker.new
        appointment.assign_worker(worker)
        expect {
          Appointment.new(activity, dts, worker)
        }.to raise_error(AppointmentError)
      end

      describe '#assign_worker' do
        it 'can have a worker assigned' do
          activity = double('activity')
          dts = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:30:00+01:00')
            .until('2012-11-09T15:50:00+01:00')
            .build
          appointment = Appointment.new(activity, dts)
          worker = Worker.new
          appointment.assign_worker(worker)

          appointment.worker.should == worker
        end

        it 'cannot have a worker assigned that has a colliding appointment' do
          activity = double('activity')
          dts = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:30:00+01:00')
            .until('2012-11-09T15:50:00+01:00')
            .build
          appointment = Appointment.new(activity, dts)
          worker = Worker.new
          worker.add_appointment(appointment)

          expect {
            appointment.assign_worker(worker)
          }.to raise_error(AppointmentError)
        end
      end
    end
  end
end
