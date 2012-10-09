require "test/unit"

File.expand_path('../', __FILE__)
require 'models/model'

class TestModel < Test::Unit::TestCase

	def test_set_should_set_properties
		model = Model.new
		model.set 'title', 'a title'

		assert_equal('a title', model.title)
	end

	def test_validate_should_call_func_with_name_of_missing_field
		called_for_field = nil
		missing_callback = lambda do |field, description, default| 
			called_for_field = field if !called_for_field
		end 
		model = Model.new
		model.validate missing_callback

		assert_equal('title', called_for_field)
	end

	def test_validate_should_use_return_value_of_func_for_missing_field
		missing_callback = lambda {|field, description, default| 'a new value' }
		model = Model.new
		model.validate missing_callback

		assert_equal('a new value', model.title)
	end
end

class TestBug < Test::Unit::TestCase
	def test_validate_should_require_status_field
		required_status = false
		missing_callback = lambda do |field, description, default|
			required_status = true if field == 'status'
			'abc'
		end 
		model = Bug.new
		model.validate missing_callback

		assert_equal(true, required_status)
	end
end

