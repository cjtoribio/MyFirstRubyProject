class JsonFileToMapConverter
	def initialize(fileName)
		@fileName = fileName
	end

	def process()
		builder = JsonMapBuilder.new()
		File.open(@fileName , "r") do |file|
			file.each_byte{ |byte|
				builder.feed(byte.chr)
			}
		end
		return builder.getFinalObject();
	end

	class JsonMapBuilder
		#OUT, INP, INV, INA
		def initialize()
			@states = Array.new()
			@reading = false
			@finalObj = nil
		end

		def feed(c)
			if c == '"'
				if @reading
					if @states.size() >= 3 && @states[@states.size()-2].is_a?(String)
						val = @states.pop()
						key = @states.pop()
						@states[@states.size()-1][key] = val;
					end
					@reading = false
				else
					@reading = true
					@states.push("")
				end
			elsif c == '['
				@states.push(Array.new());
			elsif c == '{'
				@states.push({});
			elsif c == ']'
				val = @states.pop()
				key = @states.pop()
				@states[@states.size()-1][key] = val;
			elsif c == '}'
				val = @states.pop()
				if @states.size() == 0
					@finalObj = val;
				elsif @states[@states.size()-1].is_a?(Array)
					@states[@states.size()-1].push(val);
				else
					key = @states.pop()
					@states[@states.size()-1][key] = val;
				end
			else
				if @reading
					@states[@states.size()-1] += c;
				end
			end
		end

		def getFinalObject()
			return @finalObj
		end
	end
end