require 'models/model'
require "filedifferences"
require "differences"

class DiffCommand

	def initialize(first_repository)
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

		# report diffs for differences
		differences.each {|d| invoke[:output].call(d)}
	end
end