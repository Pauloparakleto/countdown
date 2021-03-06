require 'test_helper'

module TimeSpanner
  module TimeUnits

    class HourTest < TestCase

      it 'initializes' do
        hour = Hour.new

        assert hour.kind_of?(TimeUnit)
        assert_equal 8, hour.position
        assert_equal :hours, hour.plural_name
      end

      it 'calculates without rest' do
        from     = Time.parse('2013-04-03 00:00:00')
        to       = Time.parse('2013-04-03 02:00:00')
        duration = to.to_r - from.to_r
        hour     = Hour.new

        hour.calculate duration

        assert_equal 2, hour.amount
        assert_equal 0, hour.rest
      end

      it 'calculates with rest (999 Nanoseconds in seconds)' do
        from         = Time.parse('2013-04-03 00:00:00')
        target_hours = Time.parse('2013-04-03 02:00:00')
        to           = Time.at(target_hours.to_r, 0.999)
        duration     = to.to_r - from.to_r
        hour         = Hour.new

        hour.calculate duration

        assert_equal 2, hour.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), hour.rest
      end

    end
  end
end