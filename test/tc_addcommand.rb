require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/commandcontext'
require 'commands/addcommand'

class TestAddCommand < Test::Unit::TestCase
	def setup
		@output_callback = lambda {|o| nil}
	end
	
	class FakeRepository
		attr_reader :added

		def initialize
			@added = []
		end

		def add(model)
			@added.push(model)
		end
	end

	def test_run_should_add_bug_to_repository
		fake = FakeRepository.new
		prompt_callback = lambda {|name, desc, default| default }
		command = Commands::AddCommand.new(fake, nil, nil)
		commandcontext = Commands::CommandContext.new(["Bug", "--title=\"A new bug\""], @output_callback, prompt_callback)

		command.run commandcontext

		assert_equal(1, fake.added.length)
		assert_equal('A new bug', fake.added[0].title)
	end

	def test_run_should_use_prompt_callback
		fake = FakeRepository.new
		command = Commands::AddCommand.new(fake, nil, nil)
		called = false
		commandcontext = Commands::CommandContext.new(["Bug"], @output_callback, lambda {|name, desc, default| called = true })

		# missing required field: title
		command.run commandcontext

		assert_equal(true, called)
	end
end

