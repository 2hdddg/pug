$:.unshift(File.dirname(__FILE__))
require "model"

class Bug < Model
	# required fields
	attr_accessor :status

	def initialize
		super
		@status = ''
	end

	def get_summary_fields
		super <<
			{:name => "Status", :value => @status}
	end

	def get_prompt_fields
		super() << 
			PromptField.new('status', "Please enter initial status", 'Reported', [
				{ :long => 'Reported',  :short => 'R' },
				{ :long => 'Confirmed', :short => 'C' },
				{ :long => 'Assigned',  :short => 'A' },
				{ :long => 'Fixed', 	:short => 'F' },
				{ :long => 'Closed',	:short => 'O' },	
				{ :long => 'Rejected',  :short => 'X' }
			])
	end

	def get_diffs(oldmodel)
		diffs = super
		diffs << Modified.new('status', @status) if oldmodel.status != @status
		diffs	
	end
end
