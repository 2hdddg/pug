require 'models/model'
require "filedifferences"
require "differences"

class DiffCommand

	def initialize(first_repository)
		@first_repository = first_repository
	end

	def run(invoke)
		second_path = invoke[:argv].shift
		filedifferences = Filedifferences::get(@first_repository.path, second_path)
		second_repository = Repository.new(second_path)
		differences = Differences::get(filedifferences, @first_repository, second_repository)

		# report diffs for differences
		differences.each {|d| invoke[:output].call(d)}
	end
end