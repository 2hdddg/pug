require 'test/unit'

require "commands/commandcontext"

class TestCommandContext < Test::Unit::TestCase

    def test_number_of_commands_should_not_include_options
        commandcontext = Commands::CommandContext.new(['add', "--option1=1"], lambda {|e| }, lambda {|text| text }, lambda{|prompt| }, lambda{|exit| })

        assert_equal 1, commandcontext.number_of_commands
    end

    def test_options_should_include_options
        commandcontext = Commands::CommandContext.new(['add', "--option1=x"], lambda {|e| }, lambda {|text| text }, lambda{|prompt| }, lambda{|exit| })

        assert_equal 'x', commandcontext.options['option1']
    end
end
