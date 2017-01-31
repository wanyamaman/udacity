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
    insert_helper(@root, new_val)
  end

  def insert_helper(current, new_val)
    if current.value < new_val
      if current.right
        insert_helper(current.right, new_val)
      else
        current.right = Node.new(new_val)
      end
    else
      if current.left
        insert_helper(current.left, new_val)
      else
        current.left = Node.new(new_val)
      end
    end
  end

  def search(find_val)
    search_helper(@root, find_val)
  end

  def search_helper(current, find_val)
    if current
      if current.value == find_val
        return true
      else
        if current.value < find_val
          search_helper(current.right, find_val)
        else
          search_helper(current.left, find_val)
        end
      end
    else
      return false
    end
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
