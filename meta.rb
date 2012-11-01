
$:.unshift(File.dirname(__FILE__))

module Meta
	def Meta.model_from_classname(classname)
		Object.const_get(classname.capitalize).new
	end

	def Meta.command_from_name(commandname, repository, userconfiguration, globalconfiguration)
		begin
			klass = Object.const_get(commandname.capitalize + 'Command')
			klass.new repository, userconfiguration, globalconfiguration
		rescue NameError
			nil
		end
	end
end