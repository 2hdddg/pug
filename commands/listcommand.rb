
class ListCommand
	def initialize(repository)
		@repository = repository
	end

	def run(invoke)
		@repository.all do |f, m| 
			formatted = sprintf('%-30s %-30s', m.title[0, 30], File.basename(f)[0, 30])
			invoke[:output].call formatted 
		end
	end
end