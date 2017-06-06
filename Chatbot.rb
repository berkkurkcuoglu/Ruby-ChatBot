require_relative "MatchStrategy"
require_relative "QuestionStrategy"
require_relative "ChangeSubjectStrategy"
require_relative "EndConversationStrategy"
require_relative "User"

class Chatbot

	def initialize
		@user			#variable to save user
		@file_data		#variable to save file_data
		@dict = []		#variable to save response dictionary
		@frequency_matrix = []	#array of arrays to store frequencies
		@response		#response to return user
		@match = MatchStrategy.new()		#creating different strategies to use in selectStrategy method
		@question = QuestionStrategy.new()
		@change_subject = ChangeSubjectStrategy.new()
		@end_conversation = EndConversationStrategy.new()
	end
	
	def enterChat(user)		#template method that saves user, adds chatbot as an observer, reads and saves bot responses and prints greeting message
		saveUser(user)
		@user.add_observer(self)
		read
		greet
	end
	
	def saveUser(user)	#saves user
		@user = user
	end
	
	def read		#reads file_data, file_data variable will be initialized at each bots concrete class
		@file_data.each do |f|			#loop through file
			f.each_line do |line|		#loop through lines
				if(line.chomp.empty?)
					next
				end
				line_array = []			#array to store line values
				first_split = line.split(":")	#split partial match string and possible responses
				line_array << first_split[0].to_s	#add partial match string to line array
				values = first_split[1].to_s	#convert responses to string
				seperate_values = values.split(";") #split responses from ;
				seperate_values.each do |val|	#loop through responses
					line_array << val	#add each different response to line_array
				end
				@dict << line_array #add line array to dictionary array
				@frequency_matrix <<  Array.new(line_array.size-1,0)
			end
		end
	end
	
	def greet		#abstract method to be implemented in concrete classes
		raise NoMethodError
	end
	

	
	def selectStrategy(input)			#method to choose best strategy and set the response 
		@findLeast = Proc.new { |index|	#proc to find least frequent item in the response array
			min = @frequency_matrix[index][1]	# set first item as least used			
			min_index = 1
			@frequency_matrix[index].each_with_index do |mat,index|		#mat = frequency value  index = index value corresponding to it
					if(mat < min && index > 0)		#if there is a less used one set it as min
						min = mat					
						min_index = index			#also keep track of index of least used response to reach it easier
					end				
			end
			@frequency_matrix[index][min_index] += 1		#increment frequency						
			next @dict[index][min_index]			#return least used response to the method where proc is called
		}
		end_con = @end_conversation.createResponse(input,@dict)		
		if(end_con != 0)		#check if input is only one word 
			@response = end_con	#end conversation if it is
			@user.delete_observer(self)
			return
			#@user.remove_observer(self)
		end
		match_res = @match.createResponse(input,@dict,@findLeast)
		if (match_res != 0)	#check if there is a match in dictionary
			@response = match_res #return response if there was a match			
			return
		end
		question_res = @question.createResponse(input,@dict)
		if(question_res != 0)	#check for ? in user input
			@response = question_res	#set response to deflection
			return
		else
			@response = @change_subject.createResponse(input,@dict,@findLeast) #change subject if there was no match
			return
		end		
	end
	
	
	
	def update(input)	#update method invoked by user notify
		selectStrategy(input)	#adjusts best response with selectStrategy
		puts @response #prints response
	end

end