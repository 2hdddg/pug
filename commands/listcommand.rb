
module Commands

	class ListCommand
		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
		end

		def run(invoke)
			@repository.all do |f, m| 
				formatted = "#{File.basename(f)}\n=============================================================================="
				fields = m.get_summary_fields
				fields.each {|f| formatted = formatted + "\n#{f[:name]}:#{f[:value]}" }
				formatted = formatted + "\n\n"
				invoke[:output].call formatted 
			end
		end
	end
end