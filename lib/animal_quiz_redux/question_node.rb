require_relative 'node'

module AnimalQuizRedux

	class QuestionNode < Node

		alias_method :incorrect, :left
		alias_method :incorrect=, :left=
		alias_method :correct, :right
		alias_method :correct=, :right=

		def initialize value
			super value
		end

		def next answer
			return correct if answer
			return incorrect unless answer
		end

	end
end
