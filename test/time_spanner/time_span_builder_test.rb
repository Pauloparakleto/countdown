require 'test_helper'

module TimeSpanner
  class TimeSpanBuilderTest < TestCase

    before do
      @now = Time.now
    end

    it 'should use default units when if no units are given (no parameter given)' do
      time_span_builder = TimeSpanBuilder.new(@now, @now)

      assert_equal TimeSpanBuilder::DEFAULT_UNITS, time_span_builder.unit_names
    end

    it 'should use default units when if no units are given (nil given)' do
      time_span_builder = TimeSpanBuilder.new(@now, @now, nil)

      assert_equal TimeSpanBuilder::DEFAULT_UNITS, time_span_builder.unit_names
    end

    it 'should use default units when if no units are given (empty Array given)' do
      time_span_builder = TimeSpanBuilder.new(@now, @now, [])

      assert_equal TimeSpanBuilder::DEFAULT_UNITS, time_span_builder.unit_names
    end

    describe 'output all time units' do

      it 'should output all time units (in the future)' do
        from              = Time.at(DateTime.parse('2013-06-17 12:34:56').to_time, 2216234.383)
        to                = Time.at(DateTime.parse('5447-12-12 23:11:12').to_time, 3153476.737)
        time_span_builder = TimeSpanBuilder.new(from, to)

        expected = {millenniums: 3, centuries: 4, decades: 3, years: 4, months: 5, weeks: 3, days: 4, hours: 10, minutes: 36, seconds: 16, milliseconds: 937, microseconds: 242, nanoseconds: 354}
        assert_equal expected.sort, time_span_builder.time_span.sort
      end

      it 'should minusify time units when target time is smaller than start time' do
        from              = Time.at(DateTime.parse('5447-12-12 23:11:12').to_time, 3153476.737)
        to                = Time.at(DateTime.parse('2013-06-17 12:34:56').to_time, 2216234.383)
        time_span_builder = TimeSpanBuilder.new(from, to)

        expected = {millenniums: -3, centuries: -4, decades: -3, years: -4, months: -5, weeks: -3, days: -4, hours: -10, minutes: -36, seconds: -16, milliseconds: -937, microseconds: -242, nanoseconds: -354}
        assert_equal expected.sort, time_span_builder.time_span.sort
      end

    end

  end
end