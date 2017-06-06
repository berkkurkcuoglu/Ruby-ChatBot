Class Hierarchy ( Base and Subclasses)

	->User
	
	->Chatbot
		-HappyChatbot
		-DepressedChatbot
		-AngryChatbot
	
	-Response
		-MatchStrategy
		-QuestionStrategy
		-ChangeSubjectStrategy
		-EndConversationStrategy
		
		

Explanation

	User:
		-class which includes OBSERVABLE module from ruby library and serves as the subject
		-has a name which is initalized at creation
		-has chatbots as observers
		-has a converse method which gets user inputs and sends notification to chatbots
		
	Chatbot:
		-observer base class which has a TEMPLATE method enterChat to make sure every chatbot saves user,adds itself as observer, reads from file and prints a greeting message in given order
		-every chatbot has a user, all of the response strategies, a specified dict and it's frequency matrix, also a response variable to return with update method
		-saveUser, read, selectStrategy and update methods are implemented in this class to avoid code repetition in every class
		-greet method is abstract and gets implemeted by individual conrete classes as it has to be unique
		-read method also gets partially overriden to change the file to read from
		
	Response:
		-a class to implement STRATEGY pattern
		-it is just an interface including abstract createResponse method to secure that every concrete class has that method	


	SubChatbots:
			-override read method to change file name
			-implements greet method
			
	ResponseStrategies:
			-implements createRespond method which creates a possible response or returns 0 if there is no possible response available
			-MatchStrategy and ChangeSubjectStrategy overloads createRespond method with an additonal parameter to keep track of least frequent used response and use it 
					- this overload operation is not necessary for other strategies because they don't have multiple responses to keep track of
					