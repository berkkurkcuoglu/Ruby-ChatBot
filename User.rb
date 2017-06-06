require "observer"

class User

	include Observable
	
	attr_reader :name
	
	def initialize(name) #initializes user name,creates observer array, and creates input variables for user input
		@name = name			
	end
	
	def converse  
		@input = gets().chomp()		#gets user input
		changed()
		notify_observers(@input)			#notifies observers			
	end
	
end