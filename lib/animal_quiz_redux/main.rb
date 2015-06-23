require_relative 'question_node'

module AnimalQuizRedux

	class Main

		WHICH_ANIMAL_DID_YOU_THINK_OF = 'Which animal were you thinking of?'
		WHAT_QUESTION_WOULD_YOU_ASK = 'What question would you ask someone to find out the difference between these two animals?'
		WHAT_IS_THE_ANSWER = 'What would be the answer to this question (y or n)?'
		IS_IT_A = "Is it a %s?"
		PLAY_AGAIN = 'Do you want to play again?'
		WIN_GAME = "I guessed it! The animal you were thinking of is %s"

		attr_reader :interface
		attr_reader :default_question

		def initialize interface, default_question = QuestionNode.new('elephant')
			@interface = interface
			@default_question = default_question
		end

		def start
			play @default_question
			start if play_again
		end

		def play question = @default_question
			ask question
			answer = interface.read == 'y'

			if question.last?
				if answer
					win_game question
				else
					update_knowledge question
				end
			else
				play question.next(answer)
			end
		end

		def ask question
			if question.last?
				interface.write IS_IT_A % question.to_s
			else
				interface.write question.to_s
			end
		end

		def update_knowledge question
			interface.write WHICH_ANIMAL_DID_YOU_THINK_OF
			new_animal = interface.read

			interface.write WHAT_QUESTION_WOULD_YOU_ASK
			question_text = interface.read
			
			interface.write WHAT_IS_THE_ANSWER
			question_answer = interface.read == 'y'

			new_question = QuestionNode.new question_text
			animal_question = QuestionNode.new new_animal

			new_question.add question, !question_answer
			new_question.add animal_question, question_answer

			@default_question = new_question if question == @default_question
		end

		def play_again
			interface.write PLAY_AGAIN
			answer = interface.read == 'y'
		end

		def win_game question
			interface.write WIN_GAME % question.to_s
		end

	end
end
