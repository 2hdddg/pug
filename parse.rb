module Parse
	def Parse.option_to_name_and_value(option)
		splitted = option.split('=')
		name = splitted[0]
		name = name.gsub(/[-]/, '')

		value = splitted[1]
		value = value.gsub(/^"/, '').gsub(/"$/, '')
		
		{ :name => name, :value => value }
	end
end