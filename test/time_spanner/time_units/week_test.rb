require 'test_helper'
require 'date'

module TimeSpanner
  module TimeUnits
    include TimeHelpers

    class WeekTest < TestCase

      before do
        @week = Week.new
      end

      it 'initializes' do
        assert @week.kind_of?(TimeUnit)
        assert_equal 6, @week.position
        assert_equal 0, @week.amount
        assert_equal 0, @week.rest
      end

      it 'calculates without rest' do
        starting_time = DateTime.parse('2013-04-01 00:00:00')
        target_time   = DateTime.parse('2013-04-08 00:00:00')

        nanoseconds = TimeUnitCollection.new(starting_time, target_time, [:nanoseconds]).total_nanoseconds

        @week.calculate(nanoseconds)

        assert_equal 1, @week.amount
        assert_equal 0, @week.rest
      end

      it 'calculates with rest' do
        starting_time = DateTime.parse('2013-04-01 00:00:00')
        target_days   = DateTime.parse('2013-04-08 00:00:00')
        target_time   = Time.at(target_days.to_time.to_r, 0.999)

        nanoseconds = TimeUnitCollection.new(starting_time, target_time, [:nanoseconds]).total_nanoseconds
        @week.calculate(nanoseconds)

        assert_equal 1, @week.amount
        assert_equal 999, @week.rest
      end

    end
  end
end