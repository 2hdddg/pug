$:.unshift(File.expand_path('../../', __FILE__))

module Commands

	class HelpCommand
		def initialize(first_repository, userconfiguration, globalgonfiguration)
			@repository = first_repository
			@userconfiguration = userconfiguration
			@globalgonfiguration = globalgonfiguration
		end

		def run(commandcontext)
			if commandcontext.number_of_arguments == 0
				help(commandcontext)
			else
				commandname = commandcontext.pop_argument!
				command = Meta::command_from_name(commandname, @repository, @userconfiguration, @globalgonfiguration)
				if command != nil
					command.help(commandcontext)
				end
			end
		end

		def help(commandcontext)
			commandcontext.output 'Use pug help <command>'
			Meta::list_of_commands.each {|command| commandcontext.output command}
		end
	end
end