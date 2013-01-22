#!/usr/bin/env ruby

require "date"
require "tempfile"
require "open3"
require "fileutils"

def generate_release_identifier
	now = DateTime.now
	"%04d%02d%02d%02d%02d%02d" % [now.year, now.month, now.day, now.hour, now.minute, now.second]
end

def show_help()
	puts "Usage: <path to repository for current release> <path to repository for new release> <path to where report should be> <path to old release repositories>"
end

def validate_path(path)
	if !File.directory?(path)
		puts "Invalid path #{path}"
		show_help
		exit(1)
	end
end

path_to_current_repository = ARGV.shift
path_to_new_repository = ARGV.shift
path_to_reports = ARGV.shift
path_to_old_repositories = ARGV.shift

validate_path path_to_current_repository
validate_path path_to_new_repository
validate_path path_to_reports
validate_path path_to_old_repositories

release_id = generate_release_identifier

path_to_moved_repository = "#{path_to_old_repositories}/#{release_id}"

puts "Generating report for release: #{release_id}"
puts "Will compare state of current release #{path_to_current_repository} with state of new release #{path_to_new_repository}"
puts "Report on the difference will be placed in #{path_to_reports}"
puts "Current release #{path_to_current_repository} will be moved to #{path_to_moved_repository}"
puts "New release will be copied to #{path_to_current_repository}"

path_to_pug = File.dirname(__FILE__) + "/pug.rb"
reportname = 'diff_html_standard.erb'
command = "ruby #{path_to_pug} diff #{path_to_current_repository} #{path_to_new_repository} #{reportname}"

stdin, stdout, stderr = Open3.popen3(command)

error = ''
stderr.each {|line| error += line} 
if error != ''
	puts 'Failed!'
	puts error
	exit(1)
end

# write report
reportfile_path = "#{path_to_reports}/#{release_id}.html"
reportfile = File.new(reportfile_path, "w")
stdout.each {|line| reportfile.puts line }

FileUtils.mv path_to_current_repository, path_to_moved_repository
FileUtils.mkdir path_to_current_repository
files = Dir.entries(path_to_new_repository).select {|f| !File.directory?(f) }.map {|f| File.join(path_to_new_repository, f)}
FileUtils.cp files, path_to_current_repository

exit(0)