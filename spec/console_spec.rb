require 'animal_quiz_redux/console'

module AnimalQuizRedux

	describe Console do

    subject { described_class.new }

    context 'Input' do
      it 'receives input and removes the last character' do
        # allow(STDIN).to receive(:gets) {"test\n"}

        # expect(subject.read).to eq('test')
      end
    end

    context 'Output' do
      it 'outputs a message to stdout' do
        msg = 'test'
        expect{ subject.write(msg) }.to output("#{msg}\n").to_stdout
      end
    end

	end

end
