require 'spec_helper'

module AnimalQuizRedux

	describe Main do

		subject { described_class.new Console.new }

	  context '#start' do

	  	it 'begins the game' do
	  		expect(subject).to receive(:play).at_least(:once)
	  	end

	  end

	  context '#play' do

	  	it 'asks you to think of an animal' do
	  		expect(subject.console).to receive(:write).with('Think of an animal')
	  	end

	  	context 'user is asked a question' do

	  		before :each do
	  			allow(subject.console).to receive(:write)
	  			allow(subject.console).to receive(:read)
	  			default_question = 'Is it an elephant?'
	  		end

  			it 'is a question' do
		  		

		  		expect(subject).to receive(:ask).with(default_question)
		  	end

		  	context 'it is the default quesiton' do
		  		it 'user answers yes' do
		  			expect(subject).to receive(:ask).with(default_question).and_return('y')
			  	end

			  	it 'user answers no' do
			  		expect(subject).to receive(:ask).with(default_question).and_return('n')
			  	end
		  	end

		  	context 'it is not the default question' do
		  		context 'user answers yes' do
		  		end

		  		context 'user answers no' do
		  		end
		  	end

	  	end

	  	

	  	context 'user wants to play again' do

	  		it 'restarts the game' do
	  			expect(subject).to receive(:restart).at_least(:once)
	  			expect(subject).to receive(:play).at_least(:once)
	  		end

	  	end

	  	context 'information database needs updating' do

	  		it 'adds another question to the database' do

	  		end

	  	end

	  end

	end
end
