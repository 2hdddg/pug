
class ListCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters, input_callback, output_callback)
		@repository.all do |f, m| 
			output_callback.call "#{m.title} [#{f}]" 
		end
	end
end