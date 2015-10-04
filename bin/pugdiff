#!/usr/bin/env ruby
require "pug"
require "erb"

#$:.unshift(File.dirname(__FILE__))

require "tracker"
require "deltatracker"

class DeltasModel
	def initialize(deltas)
		@deltas = deltas
	end

	def get_binding
		binding
	end
end

type = ARGV.shift
pugspath_is = ARGV.shift
pugspath_was = ARGV.shift
templatepath = ARGV.shift

tracker_is = Tracker.new(pugspath_is)
tracker_was = Tracker.new(pugspath_was)

deltatracker = DeltaTracker.new
diffs = []
deltatracker.get(type, tracker_is, tracker_was){|d| diffs.push(d)}

model = DeltasModel.new(diffs)
templatecontent = File.read(templatepath)
template = ERB.new(templatecontent)

report = template.result(model.get_binding)
puts report
