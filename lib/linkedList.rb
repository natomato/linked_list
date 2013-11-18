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
    value.prev = @last
    if empty?
      @head = value
    else
      @last.next = value
    end
    @last = value
    self
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