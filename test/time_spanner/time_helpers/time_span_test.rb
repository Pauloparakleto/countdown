require 'test_helper'
require 'date'

module TimeSpanner
  module TimeHelpers

    class TimeSpanTest < TestCase

      before do
        @now = DateTime.now
      end

      describe 'duration' do

        it 'should be rational' do
          assert TimeSpan.new(@now, @now+1).duration.is_a?(Rational)
        end

        it 'should calculate duration for 1 day in the future' do
          assert_equal 86400.to_r, TimeSpan.new(@now, @now+1).duration
        end

        it 'should calculate duration for 1 day in the past' do
          assert_equal -86400.to_r, TimeSpan.new(@now, @now-1).duration
        end

        it 'should calculate duration for same timestamp' do
          assert_equal 0, TimeSpan.new(@now, @now).duration
        end

        it 'should calculate same duration for last week' do
          assert_equal 86400.to_r, TimeSpan.new(@now-7, @now-6).duration
        end

      end

      describe "total nanos" do

        it 'should calculate 0 nanoseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0)

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_nanos
        end

        it 'should calculate 1 nanosecond' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0.001)

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_nanos
        end

        it 'should calculate 235 nanoseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0.235)

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_nanos
        end

      end

      describe "total micros" do

        it 'should calculate 0 microseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0.0)

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_micros
        end

        it 'should calculate 0 microseconds on 999 nanoseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0.999)

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_micros
        end

        it 'should calculate 1 microsecond' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 1.0)

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_micros
        end

        it 'should calculate 235 microseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 235.0)

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_micros
        end

      end

      describe "total millis" do

        it 'should calculate 0 milliseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 0.0)

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_millis
        end

        it 'should calculate 0 milliseconds on 999 microseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 999.0)

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_millis
        end

        it 'should calculate 1 millisecond' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 1000.0)

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_millis
        end

        it 'should calculate 235 milliseconds' do
          starting_time = Time.at @now.to_time.to_f
          target_time   = Time.at(starting_time.to_f, 235000.0)

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_millis
        end

      end

      describe "total seconds" do

        it 'should calculate 0 seconds' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:00")

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_seconds
        end

        it 'should calculate 0 seconds on 999 milliseconds' do
          starting_time = Time.at(@now.to_time.to_f)
          target_time   = Time.at(starting_time.to_time.to_r, 999000.0)

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_seconds
        end

        it 'should calculate 1 second' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:01")

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_seconds
        end

        it 'should calculate 235 seconds' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:03:55")

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_seconds
        end

      end

      describe "total minutes" do

        it 'should calculate 0 minutes' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:00")

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_minutes
        end

        it 'should calculate 0 minutes on 59 seconds' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:59")

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_minutes
        end

        it 'should calculate 1 minute' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:01:00")

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_minutes
        end

        it 'should calculate 235 minutes' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 03:55:00")

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_minutes
        end

      end

      describe "total hours" do

        it 'should calculate 0 hours' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:00")

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_hours
        end

        it 'should calculate 0 hours on 59 minutes' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:59:00")

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_hours
        end

        it 'should calculate 1 hour' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 01:00:00")

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_hours
        end

        it 'should calculate 235 hours' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-11 19:00:00")

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_hours
        end

      end

      describe "total days" do

        it 'should calculate 0 days' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:00")

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_days
        end

        it 'should calculate 0 days on 23 hours' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 23:00:00")

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_days
        end

        it 'should calculate 1 day' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-03 00:00:00")

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_days
        end

        it 'should calculate 365 days' do
          starting_time = DateTime.parse("2010-02-01 00:00:00")
          target_time   = DateTime.parse("2011-02-01 00:00:00")

          assert_equal 365, TimeSpan.new(starting_time, target_time).total_days
        end

        it 'should calculate 365 days on leap year' do
          starting_time = DateTime.parse("2012-02-01 00:00:00")
          target_time   = DateTime.parse("2013-02-01 00:00:00")

          assert_equal 365, TimeSpan.new(starting_time, target_time).total_days
        end
      end

      describe "total weeks" do

        it 'should calculate 0 weeks' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = DateTime.parse("2012-06-02 00:00:00")

          assert target_time == starting_time
          assert_equal 0, TimeSpan.new(starting_time, target_time).total_weeks
        end

        it 'should calculate 0 weeks on 6 days' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = starting_time + 6

          assert_equal 0, TimeSpan.new(starting_time, target_time).total_weeks
        end

        it 'should calculate 1 week' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = starting_time + 7

          refute target_time == starting_time
          assert_equal 1, TimeSpan.new(starting_time, target_time).total_weeks
        end

        it 'should calculate 2 weeks' do
          starting_time = DateTime.parse("2012-06-02 00:00:00")
          target_time   = starting_time + 7*235

          assert_equal 235, TimeSpan.new(starting_time, target_time).total_weeks
        end

      end

      describe 'days' do

        it 'sums up days by upcoming months' do
          from = DateTime.parse("2013-06-17 00:00:00")
          to   = DateTime.parse("2013-12-02 00:00:00")

          assert_equal 167, TimeSpan.days_in_timeframe(from, to)
        end

      end

      describe 'months and days' do

        it 'converts days to months and days by remaining_days given 0 days' do
          target_time    = DateTime.parse("2013-01-31 00:00:00")
          remaining_days = 0
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [0, 0], months_days
        end

        it 'converts days to months and days by remaining_days given 1 day' do
          target_time    = DateTime.parse("2013-02-01 00:00:00")
          remaining_days = 1
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [0, 1], months_days
        end

        it 'converts days to months and days by remaining_days given 29 days' do
          target_time    = DateTime.parse("2012-07-01 00:00:00")
          remaining_days = 29
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [0, 29], months_days
        end

        it 'converts days to months and days by remaining_days given 30 days' do
          target_time    = DateTime.parse("2012-07-02 00:00:00")
          remaining_days = 30
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [1, 0], months_days
        end

        # Should be equal in duration compared to 'converts days to months and days by remaining_days given 30 days'
        it 'converts days to months and days by remaining_days given 1 month' do
          target_time    = DateTime.parse("2012-07-01 00:00:00")
          remaining_days = 30
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [1, 0], months_days
        end

        it 'converts days to months and days by remaining_days given 1 month and 1 day' do
          target_time    = DateTime.parse("2012-07-02 00:00:00")
          remaining_days = 31
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [1, 1], months_days
        end

        it 'converts days to months and days by remaining_days given 1 month and 2 days' do
          target_time    = DateTime.parse("2012-07-03 00:00:00")
          remaining_days = 32
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [1, 2], months_days
        end

        it 'converts days to months and days by remaining_days given 94 days' do
          target_time    = DateTime.parse("2013-09-03 00:00:00")
          remaining_days = 94
          months_days    = TimeSpan.months_and_days(target_time, remaining_days)

          assert_equal [3, 2], months_days
        end

      end

    end

  end
end