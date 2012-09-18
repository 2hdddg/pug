$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

class AddCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters)
		classname = parameters.shift
		model = Meta::model_from_classname(classname)

		while parameters.length > 0
			option = parameters.shift
			nv =  Parse.option_to_name_and_value(option)
			model.set nv[:name], nv[:value]
		end

		@repository.add(model)
	end
end