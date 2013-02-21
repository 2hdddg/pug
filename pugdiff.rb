#!/usr/bin/env ruby

require "erb"

$:.unshift(File.dirname(__FILE__))

require "tracker"
require "differences"

class DifferencesModel
	def initialize(differences)
		@differences = differences
	end

	def get_binding
		binding
	end
end

type = ARGV.shift
pugspath_is = ARGV.shift
pugspath_was = ARGV.shift
./templatecontenttemplatepath = ARGV.shift

tracker_is = Tracker.new(pugspath_is)
tracker_was = Tracker.new(pugspath_was)

differences = Differences.new
diffs = differences.get type, tracker_is, tracker_was

model = DifferencesModel.new(diffs)
templatecontent = File.read(templatepath)
template = ERB.new(templatecontent)

report = template.result(model.get_binding)
puts report
