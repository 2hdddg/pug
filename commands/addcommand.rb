$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

class AddCommand
	def initialize(repository, userconfiguration, globalgonfiguration)
		@repository = repository
	end

	def run(invoke)
		classname = invoke[:argv].shift
		model = Meta::model_from_classname(classname)

		# set fields on model from parameters
		while invoke[:argv].length > 0
			option = invoke[:argv].shift
			nv =  Parse.option_to_name_and_value(option)
			model.set nv[:name], nv[:value]
		end

		# let the model prompt for additional fields 
		model.prompt invoke[:prompt]

		@repository.add(model)
	end
end
