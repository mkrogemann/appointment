require 'spec_helper'
require 'core'

module Core
  describe Activity do
    describe '#name' do
      it 'returns the name of the activity' do
        activity = Activity.new(:name, 10)
        activity.name.should eq(:name)
      end
    end

    describe '#duration' do
      it 'returns the duration of the activity' do
        activity = Activity.new(:actitivy, 45)
        activity.duration.should == 45
      end

      it 'returns the number of minutes required to complete the activity' do
        activity = Activity.new(:activity, 45)
        activity.duration.should == 45
      end
    end
  end
end