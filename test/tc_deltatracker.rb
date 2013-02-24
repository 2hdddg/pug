require 'test/unit'

#$:.unshift(File.expand_path('../../', __FILE__))

require "deltatracker"

class TestDeltaTracker < Test::Unit::TestCase
	def setup
		@tracker = FakeTracker.new
	end
	
	class FakeTracker
		attr_accessor :to_find, :to_all

		def initialize
			@added = []
		end

		def find(type, filename)
			to_find
		end

		def all(type)
			to_all.each {|x| yield x}
		end
	end

	def test_should_find_status_changed
		deltatracker = DeltaTracker.new()
		tracker_is = FakeTracker.new
		tracked_is = Tracked.new()
		tracked_is.status = 'Closed'
		tracker_is.to_all = [tracked_is] 
		tracker_was = FakeTracker.new
		tracked_was = Tracked.new()
		tracked_was.status = 'Reported'
		tracker_was.to_find = tracked_was
		tracker_was.to_all = [] 

		diffs = []
		deltatracker.get('Bugs', tracker_is, tracker_was) { |d|
			diffs.push d
		}
		
		assert_equal(1, diffs.count)
		assert_equal('Closed', diffs[0].is.status)
		assert_equal('Reported', diffs[0].was.status)
	end

	def test_should_not_report_when_status_is_same
		deltatracker = DeltaTracker.new()
		tracker_is = FakeTracker.new
		tracked_is = Tracked.new()
		tracked_is.status = 'Reported'
		tracker_is.to_all = [tracked_is] 
		tracker_was = FakeTracker.new
		tracked_was = Tracked.new()
		tracked_was.status = 'Reported'
		tracker_was.to_find = tracked_was
		tracker_was.to_all = [] 

		diffs = []
		deltatracker.get('Bugs', tracker_is, tracker_was) { |d|
			diffs.push d
		}
		
		assert_equal(0, diffs.count)
	end

	def test_should_report_when_not_find_in_was
		deltatracker = DeltaTracker.new()
		tracker_is = FakeTracker.new
		tracked_is = Tracked.new()
		tracked_is.status = 'Reported'
		tracker_is.to_all = [tracked_is] 
		tracker_was = FakeTracker.new
		tracker_was.to_find = nil
		tracker_was.to_all = [] 

		diffs = []
		deltatracker.get('Bugs', tracker_is, tracker_was) { |d|
			diffs.push d
		}
		
		assert_equal(1, diffs.count)
		assert_equal(nil, diffs[0].was)
	end

	def test_should_report_when_not_find_in_is_but_was
		deltatracker = DeltaTracker.new()
		tracker_was = FakeTracker.new
		tracked_was = Tracked.new()
		tracked_was.status = 'Reported'
		tracker_was.to_all = [tracked_was] 
		tracker_is = FakeTracker.new
		tracker_is.to_find = nil
		tracker_is.to_all = [] 

		diffs = []
		deltatracker.get('Bugs', tracker_is, tracker_was) { |d|
			diffs.push d
		}
		
		assert_equal(1, diffs.count)
		assert_equal(nil, diffs[0].is)
	end
end

