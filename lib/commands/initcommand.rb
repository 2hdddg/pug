$:.unshift(File.expand_path('../../', __FILE__))

require "configuration"

module Commands
	class InitCommand
		def initialize(configuration)
			@configuration = configuration
		end

		def run(commandcontext)
			globalconfiguration = GlobalConfiguration.new
			globalconfiguration.pugspath = commandcontext.prompt "Enter full path to where pugs will be placed"
			@configuration.set_globalconfiguration(globalconfiguration)
		end
	end
end