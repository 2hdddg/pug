
require "models/diffs"

module Differences

	def self.get(filedifferences, repository, old_repository)
		differences = []

		# added models
		added = filedifferences[:only_in_first]
		added_models = added.map { |f| 
			added_model = repository.get(f) 
			added_model.get_diff_when_new
		}.keep_if {|d|
			d != nil
		}.each {|d|
			differences << d 
		}

		# maybe modified models
		modified = filedifferences[:in_both]
		modified_models = modified.map { |f| 
			first_model = repository.get(f)
			second_model = old_repository.get(f)
			first_model.get_diff(second_model) 
		}.keep_if { |d| 
			d != nil 
		}.each { |d| 
			differences << d 
		}

		# deleted models
		deleted = filedifferences[:only_in_second]
		deleted_models = deleted.map {|f| old_repository.get(f) }
		deleted_models.each {|m| differences << Models::Difference.new(:deleted, m) }

		differences
	end
end
