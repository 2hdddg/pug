#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__))
require "repository"
require "configuration"
require "filedifferences"
Dir["commands/*.rb"].each {|file| require file }

# todo add bug --title="A new bug"
# todo list --where=status:Open,class:Bug --groupby=status --select=title,filename --format=pretty
# todo comment 1111_a_new_bug.yml 
# todo get 1111_a_new_bug.yml
# todo set 1111_a_new_bug.yml --status="Started"
# todo diff ../old/

prompt_callback = lambda do |field, prompt, default|
	puts prompt
	input = $stdin.gets.chomp
	input = default if input == ''
	input
end
output_callback = lambda do |o|
	puts o.to_s
end

commandname = ARGV.shift
invoke = {
	:argv   => ARGV,
	:prompt => prompt_callback,
	:output => output_callback,
}

# make sure that we are configured
configuration = Configuration.new('.')
if commandname == 'init' || !configuration.has_userconfiguration?
	puts "There is no configuration available, please provide me with some info..." if commandname != "init"
	InitCommand.new(configuration).run invoke
	exit 0 if commandname == 'init'
end

# path to directory should be read from .todo_global
repository = Repository.new(File.join('.', 'bugs'))

command = Meta::command_from_name(commandname, repository)
if command != nil
	command.run invoke 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end
