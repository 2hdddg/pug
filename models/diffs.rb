$:.unshift(File.dirname(__FILE__))

class Modification
	attr_accessor :field, :newvalue

	def initialize(field, newvalue)
		@field = field
		@newvalue = newvalue
	end
end

class NewComment
	attr_accessor :instance

	def initialize(instance)
		@instance = instance
	end
end

class Difference
	attr_accessor :name_of_difference, :instance, :modifications, :comments

	def initialize(name_of_difference, instance, modifications = nil)
		@name_of_difference = name_of_difference
		@instance = instance
		@modifications = modifications
		@comments = []
	end
end
