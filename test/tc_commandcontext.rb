require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require "models/bug"
require "commands/commandcontext"

class TestCommandContext < Test::Unit::TestCase
    
    def test_should_raise_error_if_headless
        commandcontext = Commands::CommandContext.new(['add', '--headless'], lambda {|o| }, lambda {|name, desc, default| default })

        assert_raise Commands::HeadLessCommandContextException do 
            commandcontext.prompt('name', 'desc', 'default')
        end
    end
    def test_should_not_raise_error_if_not_headless
        commandcontext = Commands::CommandContext.new(['add'], lambda {|o| }, lambda {|name, desc, default| default })

        assert_nothing_raised do
            commandcontext.prompt('name', 'desc', 'default')
        end
    end
end
