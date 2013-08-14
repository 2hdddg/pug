$:.unshift(File.expand_path('../../', __FILE__))
require 'time'
require "commands/headlesscommandcontext"

module Commands
	class CommandContext
		attr_accessor :options, :commands

		def initialize(arguments, onerror, onoutput, onprompt, onexit, onedit = nil)
			@commands = arguments.select { |a| !a.start_with?'-' }
			@options = Hash[arguments
				.select { |a| a.start_with?'-' }
				.map {|o| 
					parsed = Parse::option_to_name_and_value(o) 
					[parsed[:name], parsed[:value]]
				}]
			@onerror = onerror
			@onexit = onexit
			@onoutput = onoutput
			@onprompt = onprompt
			@onedit = onedit
		end

		def pop_command!(text_when_missing = nil)
			if @commands.length == 0
				@onerror.call(text_when_missing)
				@onexit.call(1)
			end
			@commands.shift
		end

		def number_of_commands
			@commands.length
		end

		def output(s)
			@onoutput.call(s)
		end

		def error(s)
			@onerror.call(s)
		end

		def prompt(text)
			if @headless
				raise HeadLessCommandContextException.new()
			end
			@onprompt.call(text)
		end

		def get_now
			DateTime.now
		end

		def start_editor(filepath)			
			@onedit.call(filepath) if @onedit != nil
		end
	end
end