require "erb"
require 'models/model'
require "filedifferences"
require "differences"


module Commands
	class DiffCommand

		def initialize(repository, userconfiguration, globalgonfiguration)
			@globalconfiguration = globalgonfiguration
		end

		def run(commandcontext)
			path_to_old_repository = commandcontext.pop_argument!
			path_to_new_repository = commandcontext.pop_argument!
			templatename = 'diff_console_standard.erb'
			
			if commandcontext.number_of_arguments > 0
				templatename = commandcontext.pop_argument!
			end
			templatefilename = File.join(@globalconfiguration.template_dir, templatename)

			commandcontext.output(Differences::report(path_to_old_repository, path_to_new_repository, templatefilename))
		end
	end
end