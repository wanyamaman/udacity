# Directed graph implementation based on Udacity Technical Interview course.
# Assumes Nodes and vertices are unqiue.

class Node
  attr_reader :value
  attr_accessor :edges

  def initialize(value)
    @value = value
    @edges = []
  end
end

class Edge
  attr_reader :value
  attr_accessor :node_from, :node_to

  def initialize(value, node_from, node_to)
    @value = value
    @node_from = node_from
    @node_to = node_to
  end
end

class Graph
  attr_accessor :nodes, :edges

  def initialize(nodes = [], edges = [])
    @nodes = nodes
    @edges = edges
  end

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

  def get_edge_list
    # Don't return a list of edge objects!
    # Return a list of triples that looks like this:
    # (Edge Value, From Node Value, To Node Value)
    e_list = []

    @edges.each do |edge|
      e_list << [edge.value, edge.node_from.value, edge.node_to.value]
    end

    return e_list
  end

  def get_adjacency_list
    # Don't return any Node or Edge objects!
    # You'll return a list of lists.
    # The indecies of the outer list represent "from" nodes.
    # Each section in the list will store a list of array tuples
    # that looks like this: [To Node, Edge Value]
    list_size = @nodes.length + 1
    adj_list = [nil] * list_size

    @edges.each do |edge|
      if adj_list[edge.node_from.value]
        adj_list[edge.node_from.value] << [edge.node_to.value, edge.value]
      else
        adj_list[edge.node_from.value] = [[edge.node_to.value, edge.value]]
      end
    end

    return adj_list
  end

  def get_adjacency_matrix
    # Return a matrix, or 2D list.
    # Row numbers represent from nodes,
    # column numbers represent to nodes.
    # Store the edge values in each spot, and a 0 if no edge exists.
    mx_size = @nodes.length + 1
    adj_mx = [nil] * mx_size

    adj_mx.map! { [0] * mx_size }

    @edges.each do |edge|
      adj_mx[edge.node_from.value][edge.node_to.value] = edge.value
    end

    return adj_mx
  end
end

graph = Graph.new
graph.insert_edge(100, 1, 2)
graph.insert_edge(101, 1, 3)
graph.insert_edge(102, 1, 4)
graph.insert_edge(103, 3, 4)
# Should be [[100, 1, 2], [101, 1, 3], [102, 1, 4], [103, 3, 4]]
p graph.get_edge_list
# Should be [nil, [[2, 100], [3, 101], [4, 102]], nil, [[4, 103]], nil]
p graph.get_adjacency_list
# Should be [[0, 0, 0, 0, 0], [0, 0, 100, 101, 102],
# [0, 0, 0, 0, 0], [0, 0, 0, 0, 103], [0, 0, 0, 0, 0]]
p graph.get_adjacency_matrix
