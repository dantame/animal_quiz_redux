require 'animal_quiz_redux/console'

module AnimalQuizRedux

	describe Console do

    subject { described_class.new }

    context 'Output' do
      it 'outputs a message to stdout' do
        msg = 'test'
        expect{ subject.write(msg) }.to output("#{msg}\n").to_stdout
      end
    end

	end

end
