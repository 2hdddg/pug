#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__))
require "repository"
require "configuration"
require "filedifferences"
require "commands/commandcontext"
# include all commands
Dir[File.dirname(__FILE__) + "/commands/*.rb"].each {|file| require file }

# feature prio:
# - 
# - save date and time of when a bug was created
# - help on diff command
# - help on comment command
# - add using a temp template file and starting a texteditor
# - comment using a temp template file and starting a texteditor

# pug add bug --title="A new bug"
# pug list --where=status:Open,class:Bug --groupby=status --select=title,filename --format=pretty
# pug comment 1111_a_new_bug.yml 
# pug get 1111_a_new_bug.yml
# pug set 1111_a_new_bug.yml --status="Started"
# pug diff ../old/ --groupby=difftype

prompt_callback = lambda do |field, prompt, default|
	puts prompt
	input = $stdin.gets.chomp
	input = default if input == ''
	input
end
output_callback = lambda do |o|
	puts o.to_s
end

commandcontext = Commands::CommandContext.new(ARGV, output_callback, prompt_callback)
commandname = commandcontext.pop_argument!

# make sure that we are configured
configuration = Configuration.new('.')
if commandname == 'init' || !configuration.has_userconfiguration? || !configuration.has_globalconfiguration?
	puts "There is no configuration available, please provide me with some info..." if commandname != "init"
	Commands::InitCommand.new(configuration).run commandcontext
	exit 0 if commandname == 'init'
end

if commandname == nil
	commandname = 'help'
end

userconfiguration = configuration.get_userconfiguration()
globalconfiguration = configuration.get_globalconfiguration()

# path to directory should be read from .pug_global
repository = Repository.new(File.join(globalconfiguration.repository_dir))

command = Meta::command_from_name(commandname, repository, userconfiguration, globalconfiguration)
if command != nil
	command.run commandcontext 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end






