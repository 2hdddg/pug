$:.unshift(File.expand_path('../../', __FILE__))

module Commands

	class HelpCommand
		def initialize(first_repository, userconfiguration, globalgonfiguration)
			@repository = first_repository
			@userconfiguration = userconfiguration
			@globalgonfiguration = globalgonfiguration
		end

		def run(invoke)
			args = invoke[:argv]
			if args.length == 0
				help(invoke[:output])
			elsif args.length == 1
				command = Meta::command_from_name(args[0], @repository, @userconfiguration, @globalgonfiguration)
				if command != nil
					command.help(invoke[:output])
				end
			end

		end

		def help(output)
			output.call 'Use pug help <command>'
			Meta::list_of_commands.each {|command| output.call command}
		end
	end
end