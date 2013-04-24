require 'spec_helper'
require 'core'

module Core
  describe AppointmentMaker do
    describe '#request' do

      context 'perfect match' do
        it 'should return an Appointment' do
          worker = double('worker')
          worker.stub(:appointments).and_return []
          activity = double('activity')
          dts = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:30:00+01:00')
            .until('2012-11-09T15:50:00+01:00')
            .build
          AppointmentMaker.new.request(activity, dts, worker).should be_a(Appointment)
        end
      end

      context 'alternatives' do
        it 'should return alternatives if worker is appointed at desired time', :type => 'integration' do
          worker = double('worker')
          worker.stub(:appointments).and_return []
          activity = double('activity')
          dts = DateTimeSpanBuilder.new
            .starting('2012-11-09T15:30:00+01:00')
            .until('2012-11-09T15:50:00+01:00')
            .build
          fixed_appointment = AppointmentMaker.new.request(activity, dts, worker)
          worker.stub(:appointments).and_return [fixed_appointment]
          alternatives = AppointmentMaker.new.request(activity, dts, worker)
          alternatives.should be_a(Alternatives)
        end
      end

    end
  end
end