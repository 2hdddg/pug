
class ListCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters, input_callback, output_callback)
		@repository.all do |f, m| 
			formatted = sprintf('%-30s %-30s', m.title[0, 30], File.basename(f)[0, 30])
			output_callback.call formatted 
		end
	end
end