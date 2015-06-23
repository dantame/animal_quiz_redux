require 'animal_quiz_redux/console'
require 'animal_quiz_redux/main'

module AnimalQuizRedux

	describe Main do

    let(:console) { Console.new }

    subject { described_class.new console }

    context '#ask' do 
      it 'asks a question as if it was the last' do
        expect(console).to receive(:write)
          .with(described_class::IS_IT_A % subject.default_question.to_s)

        subject.ask(subject.default_question)
      end

      it 'asks a question as if it was in the middle of the tree' do
        q1_text = 'Does it live underwater?'
        question1 = QuestionNode.new q1_text

        q2_text = 'Whale'
        question2 = QuestionNode.new q2_text

        q3_text = 'Does it live in the air?'
        question3 = QuestionNode.new q3_text

        question1.add(question2, true)
        question1.add(question3, false)

        expect(console).to receive(:write)
          .with(question1.to_s)

        subject.ask(question1)
      end
    end

    context '#win_game' do
      it 'outputs the winning message' do
        expect(console).to receive(:write)
          .with(described_class::WIN_GAME % subject.default_question.to_s)

          subject.win_game subject.default_question
      end
    end

    context '#update_knowledge' do
      let(:animal) { 'whale' }
      let(:question) { 'does it live under the sea?' }
      let(:answer) { 'y' }

      it 'updates the default question' do
        allow(console).to receive(:write)
        allow(console).to receive(:read).and_return(animal, question, answer)
        subject.update_knowledge(subject.default_question)
        expect(subject.default_question.to_s).to eq(question)
      end

      it 'adds a question to the tree after the default question' do
        mock_question = QuestionNode.new 'Must it continue swimming to survive?'
        mock_parent_question = QuestionNode.new question
        mock_parent_question.add(QuestionNode.new(animal), true)
        mock_parent_question.add(QuestionNode.new(mock_question), false)
        allow(console).to receive(:read).and_return(animal, question, answer)
        allow(console).to receive(:write)
        subject.update_knowledge(mock_question)
        expect(mock_question.parent).to eq(mock_parent_question)
      end

      it 'asks the user questions to get information' do
        allow(console).to receive(:read).and_return(animal, question, answer)
        expect(console).to receive(:write).with(described_class::WHICH_ANIMAL_DID_YOU_THINK_OF).ordered
        expect(console).to receive(:write).with(described_class::WHAT_QUESTION_WOULD_YOU_ASK).ordered
        expect(console).to receive(:write).with(described_class::WHAT_IS_THE_ANSWER).ordered
        subject.update_knowledge(subject.default_question)
      end
    end

    context '#play_again' do
      it 'restarts with the default question if the user wants to play again' do
        allow(console).to receive(:read).and_return('y')
        allow(console).to receive(:write)
        expect(subject).to receive(:start).once
        subject.play_again
      end

      it 'asks the user if they want to play again' do
        allow(console).to receive(:read).and_return('n')
        expect(console).to receive(:write).with(described_class::PLAY_AGAIN)
        subject.play_again
      end

      it 'doesn\'t restart the game if the user doesn\'t want to play again' do
        allow(console).to receive(:read).and_return('n')
        allow(console).to receive(:write)
        expect(subject).to_not receive(:start)
        subject.play_again
      end
    end

	end

end
