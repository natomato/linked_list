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
      @head = node.next
      @head.prev = nil if @head
    end
    if node.next && node.prev
      node.prev.next = node.next 
      node.next.prev = node.prev
    end
  end

  private #-------------------
  def map
    results = []
    currentNode = head
    while currentNode
      results << yield(currentNode)
      currentNode = currentNode.next
    end
    results
  end

  def select
    results = []
    currentNode = head
    while currentNode
      results << currentNode if yield(currentNode)
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