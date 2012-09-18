
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

command = ARGV.shift
case command
	when 'add'
		AddCommand.new(repository).run ARGV do |s|
			puts s
		end
	when 'list'
		ListCommand.new(repository).run ARGV do |s|
			puts s
		end
	else
		puts "Unknown command #{command}"
		exit 1
	end

exit 0
