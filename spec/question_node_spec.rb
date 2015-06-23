require 'animal_quiz_redux/question_node'
require 'support/node_example'

module AnimalQuizRedux

	describe QuestionNode do

    it_behaves_like 'it is a node'

    subject { described_class.new 'test' }

    it 'adds nodes to the correct branch' do
      incorrect_node = described_class.new('left')
      correct_node = described_class.new('right')
      subject.add(incorrect_node, false)
      subject.add(correct_node, true)

      expect(subject.incorrect).to eq(incorrect_node)
      expect(subject.correct).to eq(correct_node)
    end

    it 'returns the requested node based on a correct / incorrect answer to a question' do
      subject.add(described_class.new('left'), false)
      subject.add(described_class.new('right'), true)
      expect(subject.next(true)).to eq(subject.correct)
      expect(subject.next(false)).to eq(subject.incorrect)
    end

	end

end