
$:.unshift(File.dirname(__FILE__))

module Meta
	def Meta.model_from_classname(classname)
		Object.const_get(classname).new
	end
end