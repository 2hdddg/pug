#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__))
require "repository"
require "differences"

path_to_old_repository = ARGV.shift
path_to_new_repository = ARGV.shift
template_filename = ARGV.shift
report_filename = ARGV.shift

report = Differences::report(path_to_old_repository, path_to_new_repository, template_filename)

File.open(report_filename, 'w') { |file| file.write(report) }