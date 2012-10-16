$:.unshift(File.expand_path('../../', __FILE__))

class InitCommand
	def initialize(configuration)
		@configuration = configuration
	end

	def run(invoke)
		userconfiguration = UserConfiguration.new
		userconfiguration.prompt invoke[:prompt]

		@configuration.set_userconfiguration(userconfiguration)
	end
end