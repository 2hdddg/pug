$:.unshift(File.dirname(__FILE__))
require "model"

module Models
	class Bug < Model
		# required fields
		attr_accessor :status

		def initialize
			super
			@status = ''
		end

		def get_prompt_fields
			super() << 
				PromptField.new('status', "Please enter initial status", 'Reported', [
					{ :long => 'Reported',  :short => 'R' },
					{ :long => 'Taken',  	:short => 'T' },
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

		def add_diffs(oldmodel, difference)
			super
			difference.modifications << Modification.new('status', @status) if oldmodel.status != @status
		end

		def get_diff(oldmodel)
			difference = super

			# from open to closed
			if oldmodel.open? && closed?
				difference.name_of_difference = :closed
			elsif oldmodel.open? && rejected?
				difference.name_of_difference = :rejected
			end

			difference
		end
	end
end