class LinkedList
  include Enumerable
  attr_reader :last, :first

  def initialize(node = nil)
    @first = node
    @last = node
  end

  def empty?
    @first.nil?
  end

  def add(value)
    node = Node.new(value, nil, @last) 

    if empty?
      initialize(node)
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
    if node.next.nil?
      @last = node.prev
      @last.next = nil if @last
    end
    if node.prev.nil?
      @first = node.next
      @first.prev = nil if @first
    end
    if node.next && node.prev
      node.prev.next = node.next 
      node.next.prev = node.prev
    end
  end

  private #-------------------

  def each
    currentNode = first
    while currentNode
      yield currentNode
      currentNode = currentNode.next
    end
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

end