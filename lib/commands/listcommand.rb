$:.unshift(File.expand_path('../../', __FILE__))

require "tracker"
require "deltatracker"

module Commands

	class ListCommand
		def initialize(tracker)
			@tracker = tracker
		end

		def run(commandcontext)
			type = commandcontext.options['type']
			status =  commandcontext.options['status']

			@tracker.all {|x|
				if (x.type.downcase == type || type == nil) && (x.status.downcase == status || status == nil)
					commandcontext.output(x)
				end
			}
		end

		def help(commandcontext)
			commandcontext.output 'Use pug list [type [status]]'
		end
	end
end