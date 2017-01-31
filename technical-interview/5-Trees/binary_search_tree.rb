class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BST
  attr_accessor :root

  def initialize(root)
    @root = Node.new(root)
  end

  def insert(new_val)
  end

  def search(find_val)
    false
  end
end

# Set up tree
tree = BST.new(4)

# Insert elements
tree.insert(2)
tree.insert(1)
tree.insert(3)
tree.insert(5)

# Check search
# Should be True
p tree.search(4)
# Should be False
p tree.search(6)
