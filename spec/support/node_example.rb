shared_examples 'it is a node' do

  let (:value) { 'test' }

  subject { described_class.new value }

  context 'Utility methods' do

    it 'overrides to_s to return the value of the node' do
      expect(subject.to_s).to eq(value)
    end

    it 'it is the last node' do
      expect(subject.last?).to be(true)
    end

    it 'isn\'t the last node' do
      subject.left = described_class.new 'left'
      subject.right = described_class.new 'right'

      expect(subject.last?).to be(false)
    end

  end

  context 'replace nodes' do

    let (:subject2) { described_class.new 'test2' }

    before :each do
      subject.left = described_class.new 'left'
      subject.right = described_class.new 'right'

    end

    it 'replaces a target node with a replacement node' do
      subject.replace(subject.left, subject2)
      expect(subject.left).to eq(subject2)
    end

    it 'sets the replacements parent to the target node' do
      subject.replace(subject.left, subject2)
      expect(subject2.parent).to eq(subject)
    end

  end
end