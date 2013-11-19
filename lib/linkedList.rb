class LinkedList
  include Enumerable
  attr_reader :last, :first

  def initialize(*values)
    values.map { |num| self.add(num) }
  end

  def empty?
    @first.nil?
  end

  def add(value)
    node = Node.new(value, nil, @last) 

    if empty?
      create_first_node(node)
    else
      @last.next = node
      @last = node
    end
    node
  end

  def find(value)
    select { |node| node.value == value } 
  end

  def display 
    map { |node| node.value }
  end

  def remove(node)
    if node == last
      @last = node.prev
    end

    if node == first
      @first = node.next
    end

    prev_node = node.prev
    next_node = node.next
    prev_node.next = next_node if prev_node 
    next_node.prev = prev_node if next_node
  end

  private #-------------------

  def each
    currentNode = first
    while currentNode
      yield currentNode
      currentNode = currentNode.next
    end
  end

  def create_first_node(node)
    @first = node
    @last = node
  end

end

class Node
  attr_accessor :value, :prev

  def initialize(value, nextNode = nil, prev = nil)
    @value = value
    @prev = prev
    @nextNode = nextNode
  end

  def next
    @nextNode
  end

  def next=(node)
    @nextNode = node
  end

  # def ==(other)
  #   self.value == other.value &&
  #   self.next.object_id == other.next.object_id &&
  #   self.prev.object_id == other.prev.object_id 
  # end

end