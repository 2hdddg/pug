#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__))
require "repository"
require "dircompare"
Dir["commands/*.rb"].each {|file| require file }

# todo add bug --title="A new bug"
# todo list --where=status:Open,class:Bug --groupby=status --select=title,filename --format=pretty
# todo comment 1111_a_new_bug.yml 
# todo get 1111_a_new_bug.yml
# todo set 1111_a_new_bug.yml --status="Started"
# todo diff ../old/

# path to directory should be read from .todo_global.yml
repository = Repository.new(File.join('.', 'bugs'))

prompt_callback = lambda do |field, prompt, default|
	puts prompt
	input = gets.chomp
	input = default if input == ''
	input
end
output_callback = lambda do |o|
	puts o.to_s
end
dircompare_callback = lambda do |newer, older|
	DirCompare::compare(newer, older)
end

commandname = ARGV.shift
invoke = {
	:argv   => ARGV,
	:prompt => prompt_callback,
	:output => output_callback,
	:dircompare => dircompare_callback
}


command = Meta::command_from_name(commandname, repository)
if command != nil
	command.run invoke 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end
