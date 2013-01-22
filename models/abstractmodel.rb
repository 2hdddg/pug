$:.unshift(File.dirname(__FILE__))

module Models
	class AbstractModel
		def set(name, value)
			instance_variable_set '@' + name, value
		end

		def get(name)
			instance_variable_get '@' + name
		end

		def get_prompt_fields
			[]
		end

		def prompt(prompt_callback)
			fields = get_prompt_fields()
			fields.each do |f|
				value = get(f.name)
				if value == ''
					prompted = prompt_callback.call(f.name, f.prompt, f.default)
					expanded = f.expand(prompted)
					set(f.name, expanded)
				end
			end
		end
	end
end