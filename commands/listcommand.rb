require "erb"

module Commands
	class ListOutput
		def initialize(repository)
			@all = repository.all {|filename, model| model }
		end

		def get_binding
			binding()
		end

	end


	class ListCommand
		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
		end

		def run(commandcontext)
			templatename = 'list_console_standard.erb'
			templatefilename = File.join('.', 'templates', templatename)
			templatetext = File.read(templatefilename)
			template = ERB.new(templatetext)

			output = ListOutput.new(@repository)

			result = template.result(output.get_binding)
			commandcontext.output(result)
		end
	end
end