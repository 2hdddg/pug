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

	def test_run_should_invoke_help_function_on_command_when_one_parameter
		outputted = []
		prompt_callback = lambda {|output| outputted.push output }
		helpcommand = Commands::HelpCommand.new(nil, nil, nil)
		invoke = {
			:argv   => ['add'],
			:prompt => nil,
			:output => prompt_callback,
		}

		helpcommand.run invoke

		known_to_be_outputted = []
		invoke = {
			:argv   => ['add'],
			:prompt => nil,
			:output => lambda {|output| known_to_be_outputted.push output },
		}
		Commands::AddCommand.new(nil, nil, nil).help invoke

		assert_equal known_to_be_outputted, outputted		
	end
end

