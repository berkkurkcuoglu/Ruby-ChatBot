require_relative "Response"

class EndConversationStrategy < Response

	def createResponse(input,dict)
		input_split = input.split()
		if (input_split.size <= 1)		#if user entered only a single word 
			dict.each do |d|
				if(d[0].include?("goodbye"))		#return goodbye phrase in dictionary
					return d[1]
				end
			end
		else
			return 0		#return 0 if user entered more than a word
		end
	end

end