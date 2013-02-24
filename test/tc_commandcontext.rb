require 'test/unit'

#$:.unshift(File.expand_path('../../', __FILE__))
require "commands/commandcontext"

class TestCommandContext < Test::Unit::TestCase
    
    def test_should_raise_error_if_headless
        commandcontext = Commands::CommandContext.new(['add', '--headless'], lambda {|e| }, lambda {|text| text }, lambda{|prompt| }, lambda{|exit| })

        assert_raise Commands::HeadLessCommandContextException do 
            commandcontext.prompt('prompt text')
        end
    end
    
    def test_should_not_raise_error_if_not_headless
        commandcontext = Commands::CommandContext.new(['add'], lambda {|e| }, lambda {|text| text }, lambda{|prompt| }, lambda{|exit| })

        assert_nothing_raised do
            commandcontext.prompt('prompt text')
        end
    end
end
