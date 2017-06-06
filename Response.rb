class Response #interface for response strategies
	
	def createResponse(input,dict)	#method to create a response using user input and bot dictionary, returns 0 if there is no possible response, returns a string if there is a response available
		raise NoMethodError
	end

end