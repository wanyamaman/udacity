class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinaryTree
  attr_accessor :root

  def initialize(root)
    @root = Node.new(root)
  end

  # Return true if the value is in the tree,
  # return false otherwise.
  def search(find_val)
    preorder_search(@root, find_val)
  end

  # Print out all tree nodes as they are visited in
  # a pre-order traversal.
  def print_tree
    preorder_print(@root, '')[1..-1]
  end

  # Helper method - use this to create a recursive
  # search solution.
  def preorder_search(start, find_val)
    if start
      if start.value == find_val
        return true
      else
        return preorder_search(start.left, find_val) ||
               preorder_search(start.right, find_val)
      end
    end
    return false
  end

  # Helper method - use this to create a recursive
  # print solution.
  def preorder_print(start, traversal)
    if start
      traversal += "-#{start.value.to_s}"
      traversal = preorder_print(start.left, traversal)
      traversal = preorder_print(start.right, traversal)
    end
    return traversal
  end
end


# Set up tree
tree = BinaryTree.new(1)
tree.root.left = Node.new(2)
tree.root.right = Node.new(3)
tree.root.left.left = Node.new(4)
tree.root.left.right = Node.new(5)

# Test search
# Should be true
p tree.search(4)
# Should be false
p tree.search(6)

# Test print_tree
# Should be 1-2-4-5-3
p tree.print_tree
