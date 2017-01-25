require 'minitest/autorun'
require 'pp'

class Node
  attr_accessor :edges, :visited
  attr_reader :value

  def initialize(value)
    @value = value
    @edges = []
    @visited = false
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

# You only need to change code with comments that have TODO.
# Specifically: Graph.dfs_helper and Graph.bfs
# New methods have been added to associate node numbers with names
# Specifically: Graph.set_node_names
# and the methods ending in "_names" which will print names instead
# of node numbers.
# Uncomment corresponding lines in the printer method to see the output
# from your DFS & BFS solutions.
class Graph
  attr_accessor :nodes, :edges, :node_names

  def initialize(nodes = nil, edges = nil)
    @nodes = nodes || []
    @edges = edges || []
    @node_names = []
    @_node_map = {}
  end

  def set_node_names(names)
    # The Nth name in names should correspond to node number N.
    # Node numbers are 0 based (starting at 0).
    @node_names = names
  end

  def insert_node(new_node_val)
    # Insert a new node with value new_node_val
    new_node = Node.new(new_node_val)
    @nodes << new_node
    @_node_map[new_node_val] = new_node
    new_node
  end

  def insert_edge(new_edge_val, node_from_val, node_to_val)
    # Insert a new edge, creating new nodes if necessary
    nodes = { node_from_val => nil, node_to_val => nil }
    @nodes.each do |node|
      next unless nodes.include?(node.value)
      nodes[node.value] = node
      break if nodes.all? { |_node_val, node_obj| node_obj }
    end
    nodes.each do |node_val, _node_obj|
      nodes[node_val] = nodes[node_val] || insert_node(node_val)
    end
    node_from = nodes[node_from_val]
    node_to = nodes[node_to_val]
    new_edge = Edge.new(new_edge_val, node_from, node_to)
    node_from.edges << new_edge
    node_to.edges << new_edge
    @edges << new_edge
    new_edge
  end

  def get_edge_list
    # Return a list of triples that looks like this:
    # [Edge Value, From Node, To Node]
    e_list = []

    @edges.each do |e|
      e_list << [e.value, e.node_from.value, e.node_to.value]
    end

    e_list
  end

  def get_edge_list_names
    # Return a list of triples that looks like this:
    # [Edge Value, From Node Name, To Node Name]
    e_list = []

    @edges.each do |edge|
      e_list << [edge.value,
                 @node_names[edge.node_from.value],
                 @node_names[edge.node_to.value]]
    end

    e_list
  end

  def get_adjacency_list
    # Return a list of lists.
    # The indecies of the outer list represent "from" nodes.
    # Each section in the list will store a list
    # of tuples that looks like this:
    # [To Node, Edge Value]
    max_index = find_max_index
    adjacency_list = [nil] * max_index
    @edges.each do |edg|
      from_value = edg.node_from.value
      to_value = edg.node_to.value
      if adjacency_list[from_value]
        adjacency_list[from_value] << [to_value, edg.value]
      else
        adjacency_list[from_value] = [[to_value, edg.value]]
      end
    end
    adjacency_list
  end

  def get_adjacency_list_names
    # Each section in the list will store a list
    # of tuples that looks like this:
    # [To Node Name, Edge Value].
    # Node names should come from the names set
    # with set_node_names.
    adjacency_list = get_adjacency_list

    adjacency_list_with_names = adjacency_list.map do |adjacency_list_for_node|
      next unless adjacency_list_for_node
      adjacency_list_for_node.map! do |node_number, e_value|
        [@node_names[node_number], e_value]
      end
    end
    adjacency_list_with_names
  end

  def get_adjacency_matrix
    # Return a matrix, or 2D list.
    # Row numbers represent from nodes,
    # column numbers represent to nodes.
    # Store the edge values in each spot,
    # and a 0 if no edge exists."""
    max_index = find_max_index
    adjacency_matrix = [nil] * max_index
    adjacency_matrix.map! { [0] * max_index }
    @edges.each do |edg|
      from_index = edg.node_from.value
      to_index = edg.node_to.value
      adjacency_matrix[from_index][to_index] = edg.value
    end
    adjacency_matrix
  end

  def find_max_index
    # Return the highest found node number
    # Or the length of the node names if set with set_node_names().
    return @node_names.length unless @node_names.empty?

    max_index = -1
    unless @nodes.empty?
      @nodes.each do |node|
        max_index = node.value if node.value > max_index
      end
    end
    max_index >= 0 ? (return max_index + 1) : (return - 1)
  end

  def find_node(node_number)
    # Return the node with value node_number or nil
    @_node_map[node_number]
  end

  def _clear_visited
    @nodes.each { |node| node.visited = false }
  end

  def dfs_helper(start_node)
    # TODO: Write the helper function for a recursive implementation
    # of Depth First Search iterating through a node's edges. The
    # output should be a list of numbers corresponding to the
    # values of the traversed nodes.
    # ARGUMENTS: start_node is the starting Node
    # MODIFIES: the value of the visited property of nodes in self.nodes
    # RETURN: a list of the traversed node values (integers).

    ret_list = [start_node.value]
    # Your code here
    return ret_list
  end

  def dfs(start_node_num)
    # Outputs a list of numbers corresponding to the traversed nodes
    # in a Depth First Search.
    # ARGUMENTS: start_node_num is the starting node number (integer)
    # MODIFIES: the value of the visited property of nodes in self.nodes
    # RETURN: a list of the node values (integers).
    _clear_visited
    start_node = find_node(start_node_num)
    dfs_helper(start_node)
  end

  def dfs_names(start_node_num)
    # Return the results of dfs with numbers converted to names.
    dfs(start_node_num).map do |num|
      @node_names[num]
    end
  end

  def bfs(start_node_num)
    # TODO: Create an iterative implementation of Breadth First Search
    # iterating through a node's edges. The output should be a list of
    # numbers corresponding to the traversed nodes.
    # ARGUMENTS: start_node_num is the node number (integer)
    # MODIFIES: the value of the visited property of nodes in self.nodes
    # RETURN: a list of the node values (integers).
    node = find_node(start_node_num)
    _clear_visited
    ret_list = [node.value]
    # Your code here
    return ret_list
  end

  def bfs_names(start_node_num)
    # Return the results of bfs with numbers converted to names.
    bfs(start_node_num).map do |num|
      @node_names[num]
    end
  end
end

# ----------------------------------TESTS--------------------------------------

# Remove the word 'skip' from a test to have it run.
# Tests are run from the command line.
# From the command line, navigate to the folder of the file to be tested.
# Type: ruby traversal.rb
# Don't forget to uncomment printing lines in the printer method below.
class TestGraphTraversal < MiniTest::Test
  def setup
    @graph = Graph.new
    node_names_helper(@graph)
    edge_insert_helper(@graph)
  end

  def test_dfs
    skip
    dfs = ['London', 'Shanghai', 'Mountain View', 'San Francisco', 'Berlin',
           'Sao Paolo']
    assert_equal(dfs, @graph.dfs_names(2))
  end

  def test_bfs
    skip
    bfs = ['London', 'Shanghai', 'Berlin', 'Sao Paolo', 'Mountain View',
           'San Francisco']
    assert_equal(bfs, @graph.bfs_names(2))
  end
end

# ----------------------------------PRINT-GRAPH--------------------------------
def printer
  graph = Graph.new

  node_names_helper(graph)
  edge_insert_helper(graph)

  p 'Edge List'
  pp graph.get_edge_list_names
  puts

  p 'Adjacency List'
  pp graph.get_adjacency_list_names
  puts

  p 'Adjacency Matrix'
  pp graph.get_adjacency_matrix
  puts

  # Uncomment the next 3 lines when you have a solution
  # p 'Depth First Search'
  # pp graph.dfs_names(2)
  # puts

  # Should print:
  # Depth First Search
  # ['London', 'Shanghai', 'Mountain View', 'San Francisco', 'Berlin',
  #  'Sao Paolo']

  # Uncomment the next 3 lines when you have a solution
  # p 'Breadth First Search'
  # pp graph.bfs_names(2)
  # puts

  # Should print:
  # Breadth First Search
  # ['London', 'Shanghai', 'Berlin', 'Sao Paolo', 'Mountain View',
  #  'San Francisco']

  puts '--- TESTS ---'
end

# -------------------------------------HELPERS---------------------------------

def node_names_helper(graph)
  graph.node_names = []
  graph.set_node_names(['Mountain View',    # 0
                        'San Francisco',    # 1
                        'London',           # 2
                        'Shanghai',         # 3
                        'Berlin',           # 4
                        'Sao Paolo',        # 5
                        'Bangalore'])       # 6
end

def edge_insert_helper(graph)
  graph.insert_edge(51, 0, 1)     # MV <-> SF
  graph.insert_edge(51, 1, 0)     # SF <-> MV
  graph.insert_edge(9950, 0, 3)   # MV <-> Shanghai
  graph.insert_edge(9950, 3, 0)   # Shanghai <-> MV
  graph.insert_edge(10_375, 0, 5) # MV <-> Sao Paolo
  graph.insert_edge(10_375, 5, 0) # Sao Paolo <-> MV
  graph.insert_edge(9900, 1, 3)   # SF <-> Shanghai
  graph.insert_edge(9900, 3, 1)   # Shanghai <-> SF
  graph.insert_edge(9130, 1, 4)   # SF <-> Berlin
  graph.insert_edge(9130, 4, 1)   # Berlin <-> SF
  graph.insert_edge(9217, 2, 3)   # London <-> Shanghai
  graph.insert_edge(9217, 3, 2)   # Shanghai <-> London
  graph.insert_edge(932, 2, 4)    # London <-> Berlin
  graph.insert_edge(932, 4, 2)    # Berlin <-> London
  graph.insert_edge(9471, 2, 5)   # London <-> Sao Paolo
  graph.insert_edge(9471, 5, 2)   # Sao Paolo <-> London
  # (6) 'Bangalore' is intentionally disconnected (no edges)
  # for this problem and should produce None in the
  # Adjacency List, etc.
end

# print graph lists
printer
