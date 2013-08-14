$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

module Commands

	class AddCommand
		def initialize(tracker)
			@tracker = tracker
		end

		def run(commandcontext)
			type = commandcontext.pop_command! 'Missing type'
			status = commandcontext.pop_command! 'Missing status'

			title = commandcontext.prompt "Enter a title"

			tracked = @tracker.add(type, status, title)
			commandcontext.start_editor tracked.filepath
		end

		def help(commandcontext)
			commandcontext.output 'Use pug add <type of report> <initial status>'
		end
	end
end