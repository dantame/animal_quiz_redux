require_relative "animal_quiz_redux/version"
require_relative 'animal_quiz_redux/main'
require_relative 'animal_quiz_redux/console'

module AnimalQuizRedux

	main = Main.new Console.new
	main.start

end
