require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/helpcommand'

class TestHelpCommand < Test::Unit::TestCase
	def setup
		@output_callback = lambda {|o| nil}
	end
	
	def test_run_should_output_names_of_all_commands_when_no_additional_parameters
		outputted = []
		prompt_callback = lambda {|output| outputted.push output }
		command = Commands::HelpCommand.new(nil, nil, nil)
		invoke = {
			:argv   => [],
			:prompt => nil,
			:output => prompt_callback,
		}

		command.run invoke

		assert_operator outputted.length, :>, 0
	end

end

