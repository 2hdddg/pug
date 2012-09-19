$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

class AddCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters, input_callback)
		classname = parameters.shift
		model = Meta::model_from_classname(classname)

		# set fields on model from parameters
		while parameters.length > 0
			option = parameters.shift
			nv =  Parse.option_to_name_and_value(option)
			model.set nv[:name], nv[:value]
		end

		model.validate input_callback

		@repository.add(model)
	end
end