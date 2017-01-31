Now try implementing a BST on your own. You'll use the same `Node` class as before:
```ruby
class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    value = value
    @left = None
    @right = None
  end
end
```

This time, you'll implement `search()` and `insert()`. You should rewrite `search()` and not use your code from the last exercise so it takes advantage of BST properties. Feel free to make any helper functions you feel like you need, including the `print_tree()` function from earlier for debugging. You can assume that two nodes with the same value won't be inserted into the tree.

Beware of all the complications discussed in the videos!
