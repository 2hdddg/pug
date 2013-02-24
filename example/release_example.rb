#!/usr/bin/env ruby
require "pug"
require "date"
require "tempfile"
require "open3"
require "fileutils"

def generate_release_identifier
	now = DateTime.now
	"%04d%02d%02d_%02d.%02d.%02d" % [now.year, now.month, now.day, now.hour, now.minute, now.second]
end

pugspath_is = "./pugs_new_release"
pugspath_was = "./pugs_previous_release"

release_id = generate_release_identifier

reportfile_path = File.join("./release_reports", "#{release_id}.html")

puts "Generating report for release: #{release_id}"
puts "Will compare state of current release #{pugspath_was} with state of new release #{pugspath_is}"
puts "Report on the difference will be placed in #{reportfile_path}"
puts "New release will be copied to #{pugspath_was}"

path_to_pug = File.join("..", "pugdiff.rb")
template = File.join("./templates", 'diff_html_standard.erb')

report = `ruby #{path_to_pug} Bug #{pugspath_is} #{pugspath_was} #{template}`

reportfile = File.open(reportfile_path, "w")
reportfile.write report
reportfile.close


#FileUtils.rm_rf pugspath_was
#FileUtils.mv pugspath_is, pugspath_was

exit(0)