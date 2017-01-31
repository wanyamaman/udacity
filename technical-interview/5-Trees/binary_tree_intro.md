Now, it's your turn! Your goal is to create your own binary tree. You should start with the most basic building block:

```ruby
class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = None
    @right = None
  end
end
```
Every node has some value, and pointers to left and right children.

You'll need to implement two methods: `search()`, which searches for the presence of a node in the tree, and `print_tree()`, which prints out the values of tree nodes in a pre-order traversal. You should attempt to use the helper methods provided to create recursive solutions to these functions.

Let's get started!
