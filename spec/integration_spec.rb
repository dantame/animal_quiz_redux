require 'animal_quiz_redux/console'
require 'animal_quiz_redux/main'

module AnimalQuizRedux

	describe Main do

    let(:console) { Console.new }

    subject { described_class.new console }

    context 'Integration test' do 
      it 'tests the game end to end vs the initial spec given' do
        allow(console).to receive(:read).and_return('n', 
          'a rabbit', 
          'Is it a small animal?',
          'y',
          'y',
          'y',
          'n',
          'a Shih Tzu',
          'Is it a kind of dog?',
          'y',
          'y',
          'y',
          'y',
          'y',
          'n')

        intended_output = ['Is it a elephant?',
                  'Which animal were you thinking of?',
                  'What question would you ask someone to find out the difference between these two animals?',
                  'What would be the answer to this question (y or n)?',
                  'Do you want to play again?',
                  'Is it a small animal?',
                  'Is it a a rabbit?',
                  'Which animal were you thinking of?',
                  'What question would you ask someone to find out the difference between these two animals?',
                  'What would be the answer to this question (y or n)?',
                  'Do you want to play again?',
                  'Is it a small animal?',
                  'Is it a kind of dog?',
                  'Is it a a Shih Tzu?',
                  'I guessed it! The animal you were thinking of is a Shih Tzu',
                  'Do you want to play again?']

        for msg in intended_output do
          expect(console).to receive(:write).with(msg).ordered
        end

        subject.start
      end
    end

	end

end
