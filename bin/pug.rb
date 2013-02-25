#!/usr/bin/env ruby
require "pug"
require "tracker"
require "configuration"
require "commands/commandcontext"
require "commands/initcommand"
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

commandcontext = Commands::CommandContext.new(ARGV, onerror, onoutput, onprompt, onexit)
commandname = commandcontext.pop_argument!("Missing command, try help ;-)")

configuration = Configuration.new('.')

# make sure that we are configured
if commandname == 'init' || !configuration.has_globalconfiguration?
	puts "There is no configuration available, please provide me with some info..." if commandname != "init"
	Commands::InitCommand.new(configuration).run commandcontext
	exit 0 if commandname == 'init'
end

if commandname == nil
	commandname = 'help'
end

globalconfiguration = configuration.get_globalconfiguration()

# path to directory should be read from .pug_global
pugspath = globalconfiguration.pugspath
tracker = Tracker.new(pugspath)

command = Meta::command_from_name(commandname, tracker)
if command != nil
	command.run commandcontext 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end
