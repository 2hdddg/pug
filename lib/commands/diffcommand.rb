$:.unshift(File.expand_path('../../', __FILE__))

require "tracker"
require "deltatracker"

module Commands

	class DiffCommand
		def initialize(tracker)
			@tracker_is = tracker
		end

		def run(commandcontext)
			type = commandcontext.pop_argument! 'Missing type'
			pugspath_was = commandcontext.pop_argument! 'Missing path to pugs'
			tracker_was = Tracker.new(pugspath_was)
			DeltaTracker.new().get(type, tracker_is, tracker_was){|d| commandcontext.output(d) }
		end

		def help(commandcontext)
			commandcontext.output 'Use pug diff <path to pugs to compare to>'
		end
	end
end