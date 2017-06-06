require_relative "Chatbot"

class DepressedChatbot < Chatbot	
	
	def initialize
		super()		#inherits base class constructor
	end
	
	def read
		@file_data = open("chatter_sad.txt", "r")  #sets file_data to matching file and then uses base class method to read in and save file
		super()
	end
	
	def greet
		puts "Hello #{@user.name} :|" 	#prints greeting
	end

end