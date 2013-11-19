require 'spec_helper'
require 'linkedList'

describe LinkedList do

  describe '#initialize' do
    it 'can not take a node'

    it 'can take an integer' do
      list = LinkedList.new(1)
      expect(list.first.value).to eq(1)
    end

    it 'can take a list of integers' do
      list = LinkedList.new(1,2,3)
      expect(list.display).to eq([1,2,3])
    end
  end

  context "an empty list" do
    subject(:list) { LinkedList.new() }

    it { should be_empty }

    it 'first is nil' do
      expect(list.first).to be_nil
    end

    it 'last is nil' do
      expect(list.last).to be_nil
    end

    it 'should display []' do
      expect(list.display).to eq([])
    end

    it 'can add a node to an empty list' do
      node1 = list.add(1)
      expect(list).not_to be_empty
      expect(list.first).to eq(node1)
      expect(list.last).to eq(node1)
    end
  end

  context "a list with one node" do
    subject(:list) { LinkedList.new(1) }
    let(:node1) { list.first }
    

    it { should_not be_empty }

    it 'has the same first and last node' do
      expect(list.last).to eq(list.first)
    end 

    it 'removes the only node' do
      list.remove(node1)
      expect(list).to be_empty
    end

    it 'displays an array of one item' do
      expect(list.display).to eq([1])
    end
  end

  context "a list with many nodes" do
    before(:each) do
      @long_list = LinkedList.new()
      (1..3).each { |n| @long_list.add n }
    end
    let(:node1) { @long_list.first }
    let(:node2) { node1.next }
    let(:node3) { node2.next }

    describe "the test list" do
      it 'was built in order' do
        expect(@long_list.first).to eq(node1)
        expect(node1.next).to eq(node2)
        expect(node2.next).to eq(node3)
      end
    end

    describe '#display' do
      it 'will return an array of node values in order' do
        expect(@long_list.display).to eq([1, 2, 3])
      end
    end

    describe '#add' do
      before(:each) do
        @long_list.add(4)
      end

      it 'adds it to the end of the list' do
        expect(@long_list.last.value).to eq(4)
      end

      it 'the first node doesnt change' do
        expect(@long_list.first).to eq(node1)
      end

      it "the last node's next attribute is nil" do
        expect(@long_list.last.next).to be_nil
      end

      it 'the new node points back to the last node' do
        expect(@long_list.last.prev).to eq(node3)
      end

      it 'the last node points to the new node' do
        old_last = @long_list.last
        node = @long_list.add(99)
        expect(old_last.next).to eq(node)
      end
    end

    describe '#remove' do
      it 'can remove a node from the end of a list' do
        @long_list.remove(node3)
        expect(@long_list.display).to eq([1, 2])
        expect(@long_list.last.next).to be_nil
      end

      it 'removes a middle node' do
        @long_list.remove(node2)
        expect(@long_list.first.next).to eq(node3)
        expect(@long_list.last.prev).to eq(node1)
      end

      it 'removes the first node' do
        @long_list.remove(node1)
        expect(@long_list.display).to eq([2, 3])
        expect(@long_list.first.prev).to be_nil
      end
    end

    describe '#find' do
      context 'where the value does not exist' do
        it 'returns an empty array' do
          expect(@long_list.find(4)).to eq([])
        end
      end

      context 'where a single value exist' do
        it 'returns an array with one element' do
          expect(@long_list.find(2)).to eq([node2])
        end
      end

      context 'where many values exist' do
        it 'returns an array with those nodes' do
          new2 = @long_list.add(2)
          expect(@long_list.find(2)).to eq([node2, new2])
        end
      end
    end
  end
end