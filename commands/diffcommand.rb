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


class DiffCommand

	def initialize(first_repository, userconfiguration, globalgonfiguration)
		@first_repository = first_repository
	end

	def _get_differences(second_path)
		filedifferences = Filedifferences::get(@first_repository.path, second_path)
		second_repository = Repository.new(second_path)
		differences = Differences::get(filedifferences, @first_repository, second_repository)
		differences
	end

	def run(invoke)
		second_path = invoke[:argv].shift
		differences = _get_differences(second_path)

		filename = File.join('.', 'templates', 'diff_console_grouped.erb')
		templatetext = File.read(filename)
		template = ERB.new(templatetext)

		output = DiffOutput.new(differences)

		invoke[:output].call(template.run(output.get_binding))
	end
end