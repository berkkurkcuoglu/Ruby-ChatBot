require_relative "Response"

class ChangeSubjectStrategy  < Response

	def createResponse(input,dict,findLeast)			#method to change subject as a response @Overloads createResponse abstract method in Response interface to get another variable which is proc that finds least frequent response
		dict.each_with_index { |d,index|			
			if(d[0].to_s.include? "change subject")		#find line with change subject string
				return findLeast.call(index)			#return least used response
			end
		}
	end
	
end