$:.unshift(File.expand_path('../../', __FILE__))

module Commands
	class InitCommand
		def initialize(configuration)
			@configuration = configuration
		end

		def run(commandcontext)
			userconfiguration = UserConfiguration.new
			userconfiguration.prompt commandcontext.prompt_as_lambda
			@configuration.set_userconfiguration(userconfiguration)

			globalconfiguration = GlobalConfiguration.new
			globalconfiguration.prompt commandcontext.prompt_as_lambda
			@configuration.set_globalconfiguration(globalconfiguration)
		end
	end
end