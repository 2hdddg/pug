$:.unshift(File.expand_path('../../', __FILE__))

class HelpCommand
	def initialize(first_repository, userconfiguration, globalgonfiguration)
	end

	def run(invoke)
		invoke[:output].call 'Use pug help <command>'
	end
end