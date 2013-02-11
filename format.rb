module Format
	def Format.compact_datetime(dt)
		"%04d%02d%02d%02d%02d" % [dt.year, dt.month, dt.day, dt.hour, dt.minute]
	end

	def Format.safe_for_filename(s)
		s.gsub(/[ ]/, '_')
			.gsub(/[(){}:]/, '')
	end
end
