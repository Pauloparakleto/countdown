require 'test_helper'
require 'date'

module TimeSpanner
  module TimeUnits
    include TimeHelpers

    class MillisecondTest < TestCase

      before do
        @millisecond = Millisecond.new
      end

      it 'initializes' do
        assert @millisecond.kind_of?(TimeUnit)
        assert_equal 11, @millisecond.position
        assert_equal 0, @millisecond.amount
        assert_equal 0, @millisecond.rest
      end

      it 'calculates' do
        starting_time = Time.at Time.now.to_f
        target_time   = Time.at(starting_time.to_f, 2000.0)

        nanoseconds = TimeUnitCollection.new(starting_time, target_time, [:nanoseconds]).total_nanoseconds

        @millisecond.calculate(nanoseconds)

        assert_equal 2, @millisecond.amount
        assert_equal 0, @millisecond.rest
      end

      it 'calculates with rest' do
        starting_time = Time.at Time.now.to_r
        target_millis = Time.at(starting_time.to_r, 2000.0)
        target_time   = Time.at(target_millis.to_time.to_r, 0.999)

        nanoseconds = TimeUnitCollection.new(starting_time, target_time, [:nanoseconds]).total_nanoseconds
        @millisecond.calculate(nanoseconds)

        assert_equal 2, @millisecond.amount
        assert_equal 999, @millisecond.rest
      end

    end
  end
end