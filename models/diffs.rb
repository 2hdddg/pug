$:.unshift(File.dirname(__FILE__))

class Modification
	attr_accessor :field, :newvalue

	def initialize(field, newvalue)
		@field = field
		@newvalue = newvalue
	end
end

class Added
	attr_accessor :className, :instance

	def initialize(instance)
		@className = instance.class.to_s
		@instance = instance
	end

	def to_s
		"Added #{@className} #{@instance.title}"
	end
end

class Modified
	attr_accessor :className, :instance, :modifications

	def initialize(instance, modifications)
		@className = instance.class.to_s
		@instance = instance
		@modifications = modifications
	end

	def to_s
		"Modified #{@className} #{@instance.title}"
	end
end

class Deleted
	attr_accessor :instance

	def initialize(instance)
		@instance = instance
	end

	def className
		@instance.class.to_s
	end

	def to_s
		"Deleted #{@className} #{@instance.title}"
	end
end 
