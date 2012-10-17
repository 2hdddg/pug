$:.unshift(File.dirname(__FILE__))
require "abstractmodel"

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

	def get_diffs(oldmodel)
		modifications = []
		modifications << Modification.new('title', @title) if oldmodel.title != @title

		# Only report new comments
		if @comments && oldmodel.comments && @comments.length > oldmodel.comments.length
			new_comments = @comments[oldmodel.comments.length..@comments.length]
			new_comments.each {|c| modifications << NewComment.new(c) }
		elsif @comments && !oldmodel.comments
			@comments.each {|c| modifications << NewComment.new(c)}
		end

		modifications
	end

	def get_diff(oldmodel)
		modifications = get_diffs(oldmodel)

		if modifications.length > 0
			Difference.new(:modified, self, modifications)
		else
			nil
		end
	end
end

