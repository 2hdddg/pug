require "test/unit"

File.expand_path('../', __FILE__)
require 'models/bug'

class TestBug < Test::Unit::TestCase
	def test_prompt_should_prompt_for_status_field
		prompted_for_status = false
		prompt_callback = lambda do |field, description, default|
			prompted_for_status = true if field == 'status'
			'abc'
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal(true, prompted_for_status)
	end

	def test_prompt_should_support_shortcut_for_status_field
		prompt_callback = lambda do |field, description, default|
			if field == 'status'
				return 'C'
			end
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal 'Confirmed', model.status
	end

	def test_prompt_should_support_none_case_sensitive_shortcut
		prompt_callback = lambda do |field, description, default|
			if field == 'status'
				return 'c'
			end
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal 'Confirmed', model.status
	end

	def test_prompt_should_support_none_case_sensitive_option
		prompt_callback = lambda do |field, description, default|
			if field == 'status'
				return 'confirmed'
			end
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal 'Confirmed', model.status
	end

	def test_prompt_should_use_default_when_prompt_returns_empty_string
		prompt_callback = lambda do |field, description, default|
			if field == 'status'
				return ''
			end
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal 'Reported', model.status
	end

	def test_get_diff_when_going_from_open_to_closed_should_return_closed_diff
		open = Bug.new
		open.status = 'Reported'
		closed = Bug.new
		closed.status = 'Closed'

		diff = closed.get_diff(open)

		assert_equal('Closed', diff.class.to_s)
	end

	def test_get_diff_when_going_from_open_to_rejected_should_return_rejected_diff
		open = Bug.new
		open.status = 'Reported'
		rejected = Bug.new
		rejected.status = 'Rejected'

		diff = rejected.get_diff(open)

		assert_equal('Rejected', diff.class.to_s)
	end
end
	