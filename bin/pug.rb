#!/usr/bin/env ruby
require "pug"
require "tracker"
require "commands/commandcontext"
require "commands/addcommand"
require "commands/helpcommand"
require "commands/diffcommand"
require "commands/listcommand"

onprompt = lambda do |text|
	puts text
	$stdin.gets.chomp
end
onoutput = lambda do |o|
	puts o.to_s
end
onerror = lambda do |e|
	puts e
end
onexit = lambda do |x|
	exit(x)
end
onedit = lambda do |f|
	editor = Editor.new
	if editor.is_configured
		editor.start f
	end
end

commandcontext = Commands::CommandContext.new(ARGV, onerror, onoutput, onprompt, onexit, onedit)
commandname = commandcontext.pop_command!("Missing command, try help ;-)")

if commandname == 'help'
	command = Meta::command_from_name('help', nil)
	command.run commandcontext 
	exit(0)
end

if commandcontext.options.has_key?'pugs'
	pugspath = commandcontext.options['pugs']
else
	pugspath = File.join('.', 'pugs')
end

tracker = Tracker.new(pugspath)

command = Meta::command_from_name(commandname, tracker)
if command != nil
	command.run commandcontext 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end
