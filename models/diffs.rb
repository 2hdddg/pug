$:.unshift(File.dirname(__FILE__))

class Modification
	attr_accessor :field, :newvalue

	def initialize(field, newvalue)
		@field = field
		@newvalue = newvalue
	end

	def to_s
		field = @field.capitalize
		"#{field} set to #{@newvalue}"
	end
end

class Added
	attr_accessor :instance

	def initialize(instance)
		@instance = instance
	end

	def to_s
		classname = @instance.class.to_s.downcase 
		"New #{classname} '#{@instance.title}' reported"
	end
end

class NewComment
	attr_accessor :instance

	def initialize(instance)
		@instance = instance
	end

	def to_s
		"New comment with text '#{instance.text}'"
	end
end

class Modified
	attr_accessor :instance, :modifications

	def initialize(instance, modifications)
		@instance = instance
		@modifications = modifications
	end

	def to_s
		classname = @instance.class.to_s
		modifications = @modifications.join("\n\t") 
		"#{classname} '#{@instance.title}' was modified\n\t#{modifications}"
	end
end

class Deleted
	attr_accessor :instance

	def initialize(instance)
		@instance = instance
	end

	def to_s
		classname = @instance.class.to_s 
		"#{classname} '#{@instance.title}' has been deleted"
	end
end 
