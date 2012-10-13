
$:.unshift(File.dirname(__FILE__))
require "repository"
Dir["commands/*.rb"].each {|file| require file }

# todo add bug --title="A new bug"
# todo list
# todo comment 1111_a_new_bug.yml 
# todo get 1111_a_new_bug.yml
# todo set 1111_a_new_bug.yml --status="Started"
# todo report diff ../old/ > report.yml
# todo report full > report.yml

repository = Repository.new(File.join('.', 'bugs'))
prompt_callback = lambda do |field, description, default|
	puts description
	input = gets.chomp
	input = default if input == ''
	input
end
output_callback = lambda do |o|
	puts o.to_s
end

commandname = ARGV.shift
command = Meta::command_from_name(commandname, repository)
if command != nil
	command.run ARGV, prompt_callback, output_callback 
	exit 0
else
	puts "Unknown command #{commandname}"
	exit 1
end
