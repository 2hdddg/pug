
class ListCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters, input_callback)
		@repository.all do |f, m| 
			yield "#{m.title} [#{f}]" 
		end
	end
end