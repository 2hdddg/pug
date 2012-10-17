require "test/unit"

File.expand_path('../', __FILE__)
require 'models/model'

class TestModel < Test::Unit::TestCase

	def test_set_should_set_properties
		model = Model.new
		model.set 'title', 'a title'

		assert_equal('a title', model.title)
	end

	def test_prompt_should_call_prompt_callback
		called_for_field = nil
		prompt_callback = lambda do |field, description, default| 
			called_for_field = field if !called_for_field
		end 
		model = Model.new
		model.prompt prompt_callback

		assert_equal('title', called_for_field)
	end

	def test_prompt_should_use_return_value_of_callback_for_the_field
		prompt_callback = lambda {|field, description, default| 'a new value' }
		model = Model.new
		model.prompt prompt_callback

		assert_equal('a new value', model.title)
	end

	def test_get_diffs_should_return_difference_between_two_models
		model1 = Model.new
		model1.title = "First model"
		model2 = Model.new
		model2.title = "Second model"
		difference = Difference.new(:something, model2)

		model2.add_diffs(model1, difference)

		assert_equal('title', difference.modifications[0].field)
		assert_equal('Second model', difference.modifications[0].newvalue)
	end

	def test_get_diffs_when_identical_should_return_empty_array
		model1 = Model.new
		model1.title = "First model"
		model2 = Model.new
		model2.title = "First model"
		difference = Difference.new(:something, model2)

		diffs = model2.add_diffs(model1, difference)

		assert_equal(0, difference.modifications.length)
	end

	def test_add_diffs_should_report_new_comment
		model1 = Model.new
		model2 = Model.new
		model2.add_comment(Comment.new)
		difference = Difference.new(:something, model2)

		model2.add_diffs(model1, difference)

		assert_equal(1, difference.comments.length)	
	end

	def test_get_diffs_should_report_new_comment_when_comments_is_null_in_second_model
		model1 = Model.new
		model2 = Model.new
		model2.add_comment(Comment.new)
		model1.comments = nil
		difference = Difference.new(:something, model2)

		diffs = model2.add_diffs(model1, difference)

		assert_equal(1, difference.comments.length)	
	end
end


