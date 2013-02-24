$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

module Commands

	class AddCommand
		def initialize(tracker)
			@tracker = tracker
		end

		def run(commandcontext)
			type = commandcontext.pop_argument! 'Missing type'
			status = commandcontext.pop_argument! 'Missing status'

			title = commandcontext.prompt "Enter a title"

			@tracker.add(type, status, title)
		end

		def help(commandcontext)
			commandcontext.output 'Use pug add <type of report> <initial status>'
		end
	end
end