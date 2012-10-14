require 'models/model'

class DiffCommand

	def initialize(repository)
		@repository = repository
	end

	def run(invoke)
		second_path = invoke[:argv].shift

		# get differences in files
		dir_diff = invoke[:dircompare].call(@repository.path, second_path)

		added = dir_diff[:only_in_first]
		added_models = added.map {|f| @repository.get(f) }

		# report diffs for added models
		added_models.each {|m| invoke[:output].call( Added.new(m) )}
	end
end