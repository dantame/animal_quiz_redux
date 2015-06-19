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
			ask default_question
		end

		def ask question
			interface.write question.to_s unless question.last?
			interface.write IS_IT_A % question.to_s if question.last?
			answer interface.read, question
		end

		def answer answer, question
			converted_answer = answer == 'y'
			return ask question.next(converted_answer) unless question.last?
			return update_knowledge question, answer if question.last? unless converted_answer
			return win_game question if question.last? && converted_answer
		end

		def update_knowledge question, answer
			interface.write WHICH_ANIMAL_DID_YOU_THINK_OF
			new_animal = interface.read
			interface.write WHAT_QUESTION_WOULD_YOU_ASK
			question_text = interface.read
			interface.write WHAT_IS_THE_ANSWER
			question_answer = interface.read == 'y'

			new_question = QuestionNode.new question_text
			animal_question = QuestionNode.new new_animal

			if question_answer
				new_question.correct = animal_question
				new_question.incorrect = question
			else
				new_question.correct = question
				new_question.incorrect = animal_question
			end

			@default_question = new_question
			
			play_again
		end

		def play_again
			interface.write PLAY_AGAIN
			answer = interface.read == 'y'

			start if answer
		end

		def win_game question
			interface.write WIN_GAME % question.to_s

			play_again
		end

	end
end
