You should become comfortable with various graph representations—graphs crop up often in interviews and in computer science in general, and you could need to represent it in any of it's forms.

In this exercise you'll need to add functions to a `Graph` class to return various representations of the same graph. Your graph will have two different components: `Nodes` and `Edges`.

```ruby
class Node
  attr_reader :value
  attr_accessor :edges

  def initialize(value)
    @value = value
    @edges = []
  end
end
```

Nodes are pretty much the same as they were in trees. Instead of having a set number of children, each node has a list of `Edges`.

```ruby
class Edge
  attr_reader :value
  attr_accessor :node_from, :node_to

  def initialize(value, node_from, node_to)
    @value = value
    @node_from = node_from
    @node_to = node_to
  end
end
```

Here, we assume that edges have both a value and a direction. An edge points from one node to another—the node it starts at is the `node_from` and the node it ends at is the `node_to`. You can envision it as `node_from -> node_to`.

The base of the `Graph` class looks something like this:

```ruby
class Graph
  attr_accessor :nodes, :edges

  def initialize(nodes = [], edges = [])
    @nodes = nodes
    @edges = edges
  end
end
```
A `Graph` class contains a list of nodes and edges. You can sometimes get by with just a list of edges, since edges contain references to the nodes they connect to, or vice versa. However, our `Graph` class is built with both for the following reasons:

If you're storing a disconnected graph, not every node will be tied to an edge, so you should store a list of nodes.
We could probably leave it there, but storing an edge list will make our lives much easier when we're trying to print out different types of graph representations.
Unfortunately, having both makes insertion a bit complicated. We can assume that each value is unique, but we need to be careful about keeping both `nodes` and `edges` updated when either is inserted. You'll also be given these insertion functions to help you out:

```ruby
def insert_node(val)
  node = Node.new(val)
  @nodes << node
end

def insert_edge(edge_val, node_from_val, node_to_val)
  found_from = nil
  found_to = nil

  @nodes.each do |node|
    if node.value == node_from_val
      found_from = node
    elsif node.value == node_to_val
      found_to = node
    end
  end

  unless found_from
    found_from = Node.new(node_from_val)
    @nodes << found_from
  end

  unless found_to
    found_to = Node.new(node_to_val)
    @nodes << found_to
  end

  edge = Edge.new(edge_val, found_from, found_to)
  @edges << edge
  found_from.edges << edge
  found_to.edges << edge
end
```

Alright, time to code the rest!
