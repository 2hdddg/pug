require "erb"
require "filedifferences"

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

	def self.report(path_to_old_repository, path_to_new_repository, path_to_template)
		filedifferences = Filedifferences::get(path_to_new_repository, path_to_old_repository)
		new_repository = Repository.new(path_to_new_repository)
		old_repository = Repository.new(path_to_old_repository)
		differences = Differences::get(filedifferences, new_repository, old_repository)

		templatetext = File.read(path_to_template)
		template = ERB.new(templatetext)

		output = DiffOutput.new(differences)

		template.result(output.get_binding)
	end
end
