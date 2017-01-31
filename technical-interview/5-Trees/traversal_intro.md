Let's cement tree traversals by coding them up. Let's start with our basic building blocks:

```ruby
class Node
  attr_reader :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @children = nil
  end
end
```

Now we can begin to build our tree:

```ruby
class Tree
  def initialize(root=nil)
    @root = root
  end
end
```
Your task will be to write functions that traverse the tree in a specific order.
