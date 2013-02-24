require 'test/unit'

#$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/commandcontext'
require 'commands/addcommand'

class TestAddCommand < Test::Unit::TestCase
	def setup
		@errors = []
		@onerror = lambda {|e| @errors.push(e)}
		exited = false
		@onexit = lambda {|c| exited = true }
		@prompts = []
		@onprompt = lambda {|text| 
			@prompts.push(text)
			'A title'
		}
		@tracker = FakeTracker.new
	end
	
	class FakeTracker
		attr_reader :added

		def initialize
			@added = []
		end

		def add(type, status, title)
			@added.push({:type => type, :status => status, :title => title})
		end
	end

	def test_should_report_error_when_too_few_argument
		command = Commands::AddCommand.new(@tracker)
		commandcontext = Commands::CommandContext.new([], @onerror, nil, @onprompt, @onexit)

		command.run 	commandcontext

		assert_equal(true, @errors.count == 2)
	end

	def test_should_prompt_for_title_when_no_title_provided
		command = Commands::AddCommand.new(@tracker)
		commandcontext = Commands::CommandContext.new(['Bug', 'Open'], @onerror, nil, @onprompt, @onexit)

		command.run commandcontext

		assert_equal(1, @prompts.count)
	end

	def test_should_add_to_tracker_with_type_status_and_title_properly_set
		command = Commands::AddCommand.new(@tracker)
		commandcontext = Commands::CommandContext.new(['Bug', 'Open'], @onerror, nil, @onprompt, @onexit)

		command.run commandcontext

		added = @tracker.added[0]
		assert_equal 'Bug', added[:type]
		assert_equal 'Open', added[:status]
		assert_equal 'A title', added[:title]
	end
end