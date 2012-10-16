$:.unshift(File.dirname(__FILE__))
require "model"

class Bug < Model
	# required fields
	attr_accessor :status

	def initialize
		super
		@status = ''
	end

	# obsolete when ERB:ed
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

	def closed?
		@status == 'Closed'
	end

	def rejected?
		@status == 'Rejected'
	end

	def open?
		!closed? && !rejected?
	end

	def get_diffs(oldmodel)
		diffs = super
		diffs << Modification.new('status', @status) if oldmodel.status != @status
		diffs	
	end

	def get_diff(oldmodel)
		# from open to closed
		if oldmodel.open? && closed?
			Closed.new(self)
		elsif oldmodel.open? && rejected?
			Rejected.new(self)	
		else
			super
		end
	end
end
