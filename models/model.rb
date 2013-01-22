$:.unshift(File.dirname(__FILE__))
require "abstractmodel"

module Models

	# Base class for tracking models like bugs
	class Model < AbstractModel
		attr_accessor :title, :comments

		def initialize
			@title = ''
			@comments = []
		end

		def get_prompt_fields
			[PromptField.new('title', 'Please enter title')]
		end

		# obsolete when ERB:ed
		def get_summary_fields
			[{:name => "Title", :value => @title}]
		end

		def add_comment(comment)
			@comments = [] if @comments == nil
			@comments << comment
		end	

		def add_diffs(oldmodel, difference)
			difference.modifications << Modification.new('title', @title) if oldmodel.title != @title

			# Only report new comments
			if @comments && oldmodel.comments && @comments.length > oldmodel.comments.length
				new_comments = @comments[oldmodel.comments.length..@comments.length]
				new_comments.each {|c| difference.comments << NewComment.new(c) }
			elsif @comments && !oldmodel.comments
				@comments.each {|c| difference.comments << NewComment.new(c)}
			end
		end

		def get_diff(oldmodel)
			difference = Difference.new(:modified, self, []) 
			add_diffs(oldmodel, difference)

			if difference.modifications.length > 0
				difference
			else
				nil
			end
		end
	end
end
