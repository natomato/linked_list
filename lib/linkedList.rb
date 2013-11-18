class LinkedList
  attr_reader :last, :head

  def initialize(node = nil)
    @head = node
    @last = node
  end

  def empty?
    @head.nil?
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

  def remove(node)
    if node.next.nil?
      @last = node.prev
      @last.next = nil
    end
    if node.prev.nil?
      @head = node.next
      @head.prev = nil
    end
    if node.next && node.prev
      node.prev.next = node.next 
      node.next.prev = node.prev
    end
  end

  def find(value)
    results = []
    currentNode = @head
    while currentNode
      if currentNode.value == value
        results << currentNode
      end
      currentNode = currentNode.next
    end
    results
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