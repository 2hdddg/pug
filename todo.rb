
$:.unshift(File.dirname(__FILE__))
require "repository"
Dir["commands/*.rb"].each {|file| require file }

# todo add bug --title="A new bug"
# todo list
# todo get 1111_a_new_bug.yml
# todo set 1111_a_new_bug.yml --status="Started"
# todo report diff ../old/ > report.yml
# todo report full > report.yml

repository = Repository.new(File.join('.', 'bugs'))

commandname = ARGV.shift
command = Meta::command_from_name(commandname, repository)
command.run ARGV do |s|
	puts s
end
