require_relative "Response"

class MatchStrategy  < Response
	
	def createResponse(input,dict,findLeast)		#method to find user input a matching response @Overloads createResponse abstract method in Response interface to get another variable which is proc that finds least frequent response
		done = false
		if (!done)
			dict.each_with_index do |d,index| 		#loop through dictionary
				if(input.include?(d[0]))	#if input includes any of the partial strings select that line array
					done = true								#set flag to true
					if(d.size <= 2)				#check if there is more than a single response
						return d[1]				# if there is not return the only response
					else
						return findLeast.call(index) #find and return least freqeunt response
					end
				end
			end		
		end
		if(!done)
			input_split = input.split()		#split input to array of words
			input_split.each { |inp|		#for every word in input
				dict.each_with_index do |d,index|			#loop through dictionary
					if(d[0].include?(inp))	#if any partial match strings include a word from user input_split
						done = true			#set flag to true
						if(d.size <= 2)			#check if there is more than a single response
							return d[1]			# if there is not return the only response
						else
							return findLeast.call(index) #find and return least freqeunt response
						end
					end
				end
			}	
		end			
		return 0		#if there is no match return 0		
	end	
	
end