$:.unshift(File.expand_path('../../', __FILE__))

module Commands

	class HelpCommand
		def initialize(first_repository, userconfiguration, globalgonfiguration)
		end

		def run(invoke)
			invoke[:output].call 'Use pug help <command>'
			Meta::list_of_commands.each {|command| invoke[:output].call command}
		end
	end
end