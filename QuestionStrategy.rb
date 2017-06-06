require_relative "Response"

class QuestionStrategy < Response

		def createResponse(input,dict)
			response = ""
			if(input.include? "?")	#if there is ? in user input
				input_args = input.split(" ")		#split user input into words
				input_args.shift()		#remove first part of the question, which will probably be how,what etc.
				input_args.each do |arg|	
					response.concat(arg)	#append words to form a complete string
					response.concat(' ')
				end
				response.chomp!('?')		#remove ? from response string
				random = Random.new()
				random_num = random.rand(1..3)		#return a deflector according to random seed
				if(random_num == 1)
					return ("Actually, I was wondering about #{response}" )
				elsif(random_num == 2)
					return ("Who knows about #{response}")
				else
					return ("#{response}? Must remain secret")
				end
			else
				return 0		#return 0 if user didn't ask a question
			end
		end
		
end