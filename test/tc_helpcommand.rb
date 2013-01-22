require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/helpcommand'

class TestHelpCommand < Test::Unit::TestCase
	
	def test_run_should_output_names_of_all_commands_when_no_additional_parameters
		outputted = []
		command = Commands::HelpCommand.new(nil, nil, nil)
		commandcontext = Commands::CommandContext.new([], lambda {|output| outputted.push output }, nil)

		command.run commandcontext

		assert_operator outputted.length, :>, 0
	end

	def test_run_should_invoke_help_function_on_command_when_one_parameter
		outputted = []
		helpcommand = Commands::HelpCommand.new(nil, nil, nil)
		commandcontext = Commands::CommandContext.new(['add'], lambda {|output| outputted.push output }, nil)
		helpcommand.run commandcontext

		known_to_be_outputted = []
		commandcontext = Commands::CommandContext.new([], lambda {|output| known_to_be_outputted.push output }, nil)
		Commands::AddCommand.new(nil, nil, nil).help commandcontext

		assert_equal known_to_be_outputted, outputted
	end
end

