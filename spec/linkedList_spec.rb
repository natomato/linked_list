require 'rspec'
require 'linkedList'

describe LinkedList do

  describe '#initialize' do
    it 'can be initialized with a list of values' do
      pending "print"
      list = LinkedList.new(1,2,3)
      list.print.should == [1,2,3]
    end
  end

  context "an empty list" do
    subject(:list) { LinkedList.new() }

    it { should be_empty }

    it 'head is nil' do
      list.head.should == nil
    end

    it 'last is nil' do
      list.head.should == nil
    end

    it 'should display []' do
      list.display.should == []
    end

    it 'can add a node to an empty list' do
      node1 = list.add(1)
      list.should_not be_empty
      list.head.should == node1
      list.last.should == node1
    end
  end

  context "a list with one node" do
    let(:node1) { Node.new(1) }
    subject(:list) { LinkedList.new(node1) }
    

    it { should_not be_empty }

    it 'has the same head and last node' do
      list.last.should == list.head
    end 

    it 'removes the only node' do
      list.remove(node1)
      list.should be_empty
    end
  end

  context "a list with many nodes" do
    before(:each) do
      @long_list = LinkedList.new()
      (1..3).each { |n| @long_list.add n }
    end
    let(:node1) { @long_list.head }
    let(:node2) { node1.next }
    let(:node3) { node2.next }

    describe "the test list" do
      it 'was built in order' do
        @long_list.head.should == node1
        node1.next.should == node2
        node2.next.should == node3
      end
    end

    describe '#display' do
      it 'will return an array of node values in order' do
        @long_list.display.should == [1, 2, 3]
      end
    end

    describe '#add' do
      before(:each) do
        @long_list.add(4)
      end

      it 'adds it to the end of the list' do
        @long_list.last.value.should == 4
      end

      it 'the first node doesnt change' do
        @long_list.head.should == node1
      end

      it "the last node's next attribute is nil" do
        @long_list.last.next.should == nil
      end

      it 'the new node points back to the last node' do
        @long_list.last.prev.should == node3
      end

      it 'the last node points to the new node' do
        old_last = @long_list.last
        node = @long_list.add(99)
        old_last.next.should == node
      end
    end

    describe '#remove' do
      it 'can remove a node from the end of a list' do
        expect{@long_list.remove(node3)}.to change{@long_list.last}.from(node3).to(node2)
        @long_list.last.next.should == nil
      end

      it 'removes a middle node' do
        @long_list.remove(node2)
        @long_list.head.next.should == node3
        @long_list.last.prev.should == node1
      end

      it 'removes the first node' do
        expect {@long_list.remove(node1)}.to change{@long_list.head}.from(node1).to(node2)
        @long_list.head.prev.should == nil
      end
    end

    describe '#find' do
      context 'where the value no exist' do
        it 'returns an empty array' do
          @long_list.find(4).should == [] 
        end
      end

      context 'where a single value exist' do
        it 'returns an array with one element' do
          @long_list.find(2).should == [node2] 
        end
      end

      context 'where many values exist' do
        it 'returns an array with those nodes' do
          new2 = @long_list.add(2)
          @long_list.find(2).should == [node2, new2]
        end
      end
    end
  end

  describe "#adding a node" do
    subject(:list) { LinkedList.new() }
    let(:node1) { list.add(1) } 
    
    it 'returns self to allow chained messages' do
      pending
      ll = LinkedList.new()
      ll = list.add(node1).add(node2)
      ll.last.should == node2
    end
  end
end

describe Node do
  subject(:node) { Node.new(1) }
  let(:node2) { Node.new(2)}

  describe '#value' do
    it "returns the value" do
      node.value.should == 1
    end
  end

  describe '#value=' do
    it "can change value" do
      node.value = 5
      node.value.should == 5
    end
  end

  describe '#next' do
    it 'returns the next node' do
      node.next.should == nil
    end
  end

  describe '#next=' do
    it 'can set the next attribute of the node' do
      node.next = node2
      node.next.should be_equal(node2)
    end
  end

  describe '#prev' do
    it 'returns the previous node' do
      node.prev.should == nil
      node.prev = node2
      node.prev.should == node2
    end
  end

end