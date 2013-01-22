require "erb"
require 'models/model'
require "filedifferences"
require "differences"

class DiffOutput
	def initialize(differences)
		@differences = differences
	end

	def get_binding
		binding
	end

	# functionality for group differences by name_of_difference and so on
	def differences_by_name
		@differences.group_by {|d| d.name_of_difference}
	end
end


module Commands
	class DiffCommand

		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
		end

		def _get_differences(path_to_old_repository)
			filedifferences = Filedifferences::get(@repository.path, path_to_old_repository)
			old_repository = Repository.new(path_to_old_repository)
			differences = Differences::get(filedifferences, @repository, old_repository)
			differences
		end

		def run(commandcontext)
			path_to_old_repository = commandcontext.pop_argument!
			differences = _get_differences(path_to_old_repository)

			filename = File.join('.', 'templates', 'diff_console_grouped.erb')
			templatetext = File.read(filename)
			template = ERB.new(templatetext)

			output = DiffOutput.new(differences)

			commandcontext.output(template.run(output.get_binding))
		end
	end
end