class Editor
	def initialize(settings = nil)
		@settings = settings == nil ? ENV : settings 
	end

	def get_command
		@settings['PUG_EDITOR']
	end

	def is_configured
		get_command() != nil
	end

	def start(file)
		command = get_command()
		exec "#{command} #{file}"
	end
end