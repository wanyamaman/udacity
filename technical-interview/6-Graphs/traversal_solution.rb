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

# You only needed to change code with comments that have DONE.
# Specifically: Graph.dfs_helper and Graph.bfs
# New methods have been added to associate node numbers with names
# Specifically: Graph.set_node_names
# and the methods ending in "_names" which will print names instead
# of node numbers
class Graph
  attr_accessor :nodes, :edges, :node_names

  def initialize(nodes = nil, edges = nil)
    @nodes = nodes || []
    @edges = edges || []
    @node_names = []
    @_node_map = {}
  end

  # The Nth name in names should correspond to node number N.
  # Node numbers are 0 based (starting at 0).
  def set_node_names(names)
    @node_names = names
  end

  # Insert a new node with value new_node_val
  def insert_node(new_node_val)
    new_node = Node.new(new_node_val)
    @nodes << new_node
    @_node_map[new_node_val] = new_node
    new_node
  end

  # Insert a new edge, creating new nodes if necessary
  def insert_edge(new_edge_val, node_from_val, node_to_val)
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

  # Return a list of triples that looks like this:
  # [Edge Value, From Node, To Node]
  def get_edge_list
    e_list = []

    @edges.each do |e|
      e_list << [e.value, e.node_from.value, e.node_to.value]
    end

    e_list
  end

  # Return a list of triples that looks like this:
  # [Edge Value, From Node Name, To Node Name]
  def get_edge_list_names
    e_list = []

    @edges.each do |edge|
      e_list << [edge.value,
                 @node_names[edge.node_from.value],
                 @node_names[edge.node_to.value]]
    end

    e_list
  end

  # Return a list of lists.
  # The indecies of the outer list represent "from" nodes.
  # Each section in the list will store a list
  # of tuples that looks like this:
  # [To Node, Edge Value]
  def get_adjacency_list
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

  # Each section in the list will store a list
  # of tuples that looks like this:
  # [To Node Name, Edge Value].
  # Node names should come from the names set
  # with set_node_names.
  def get_adjacency_list_names
    adjacency_list = get_adjacency_list

    adjacency_list_with_names = adjacency_list.map do |adjacency_list_for_node|
      next unless adjacency_list_for_node
      adjacency_list_for_node.map! do |node_number, e_value|
        [@node_names[node_number], e_value]
      end
    end
    adjacency_list_with_names
  end

  # Return a matrix, or 2D list.
  # Row numbers represent from nodes,
  # column numbers represent to nodes.
  # Store the edge values in each spot,
  # and a 0 if no edge exists.
  def get_adjacency_matrix
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

  # Return the highest found node number
  # Or the length of the node names if set with set_node_names().
  def find_max_index
    return @node_names.length unless @node_names.empty?

    max_index = -1
    unless @nodes.empty?
      @nodes.each do |node|
        max_index = node.value if node.value > max_index
      end
    end
    max_index >= 0 ? (return max_index + 1) : (return -1)
  end

  # Return the node with value node_number or nil
  def find_node(node_number)
    @_node_map[node_number]
  end

  def _clear_visited
    @nodes.each { |node| node.visited = false }
  end

  # DONE: Write the helper function for a recursive implementation
  # of Depth First Search iterating through a node's edges. The
  # output should be a list of numbers corresponding to the
  # values of the traversed nodes.
  # ARGUMENTS: start_node is the starting Node
  # MODIFIES: the value of the visited property of nodes in self.nodes
  # RETURN: a list of the traversed node values (integers).
  def dfs_helper(start_node)

    ret_list = [start_node.value]
    # Your code here
    start_node.visited = true
    start_node.edges.each do |edge|
      unless edge.node_to.visited
        ret_list += dfs_helper(edge.node_to)
      end
    end
    return ret_list
  end

  # Outputs a list of numbers corresponding to the traversed nodes
  # in a Depth First Search.
  # ARGUMENTS: start_node_num is the starting node number (integer)
  # MODIFIES: the value of the visited property of nodes in self.nodes
  # RETURN: a list of the node values (integers).
  def dfs(start_node_num)
    _clear_visited
    start_node = find_node(start_node_num)
    dfs_helper(start_node)
  end

  # Return the results of dfs with numbers converted to names.
  def dfs_names(start_node_num)
    dfs(start_node_num).map do |num|
      @node_names[num]
    end
  end

  # DONE: Create an iterative implementation of Breadth First Search
  # iterating through a node's edges. The output should be a list of
  # numbers corresponding to the traversed nodes.
  # ARGUMENTS: start_node_num is the node number (integer)
  # MODIFIES: the value of the visited property of nodes in self.nodes
  # RETURN: a list of the node values (integers).
  def bfs(start_node_num)
    node = find_node(start_node_num)
    _clear_visited
    ret_list = [node.value]
    # Your code here
    q = Queue.new
    q << node
    node.visited = true

    until q.empty?
      current = q.pop
      current.edges.each do |edge|
        next if edge.node_to.visited
        q << edge.node_to
        edge.node_to.visited = true
        ret_list << edge.node_to.value
      end
    end

    return ret_list
  end

  # Return the results of bfs with numbers converted to names.
  def bfs_names(start_node_num)
    bfs(start_node_num).map do |num|
      @node_names[num]
    end
  end
end

# ----------------------------------TESTS--------------------------------------
class TestGraphTraversal < MiniTest::Test
  def setup
    @graph = Graph.new
    node_names_helper(@graph)
    edge_insert_helper(@graph)
  end

  def test_set_node_names
    graph_ = Graph.new
    names = ['Mountain View',   # 0
             'San Francisco',   # 1
             'London',          # 2
             'Shanghai',        # 3
             'Berlin',          # 4
             'Sao Paolo',       # 5
             'Bangalore']       # 6
    graph_.set_node_names(names)
    assert_equal(graph_.node_names, names)
    assert_includes(graph_.node_names, 'Bangalore')
  end

  def test_insert_node
    # Set up nodes
    graph_ = Graph.new

    graph_.insert_node(4)
    graph_.insert_node(10)
    graph_.insert_node(1)
    assert_equal(3, graph_.nodes.length)
    assert_equal(10, graph_.nodes[1].value)
  end

  def test_insert_edge
    graph_ = Graph.new

    graph_.insert_edge(51, 0, 1)
    graph_.insert_edge(9950, 3, 0)
    last_edge = graph_.insert_edge(9471, 2, 5)

    assert_equal(3, graph_.edges.length)
    assert_equal(5, graph_.nodes.length)
    assert_includes(graph_.edges, last_edge)
  end

  def test_get_edge_list
    e_list = [[51, 0, 1], [51, 1, 0], [9950, 0, 3], [9950, 3, 0],
              [10_375, 0, 5], [10_375, 5, 0], [9900, 1, 3], [9900, 3, 1],
              [9130, 1, 4], [9130, 4, 1], [9217, 2, 3], [9217, 3, 2],
              [932, 2, 4], [932, 4, 2], [9471, 2, 5], [9471, 5, 2]]
    assert_equal(e_list, @graph.get_edge_list)
  end

  def test_get_edge_list_names
    e_list_names = [[51, 'Mountain View', 'San Francisco'],
    [51, 'San Francisco', 'Mountain View'],
    [9950, 'Mountain View', 'Shanghai'], [9950, 'Shanghai', 'Mountain View'],
    [10_375, 'Mountain View', 'Sao Paolo'],
    [10_375, 'Sao Paolo', 'Mountain View'], [9900, 'San Francisco', 'Shanghai'],
    [9900, 'Shanghai', 'San Francisco'], [9130, 'San Francisco', 'Berlin'],
    [9130, 'Berlin', 'San Francisco'], [9217, 'London', 'Shanghai'],
    [9217, 'Shanghai', 'London'], [932, 'London', 'Berlin'],
    [932, 'Berlin', 'London'], [9471, 'London', 'Sao Paolo'],
    [9471, 'Sao Paolo', 'London']]
    assert_equal(e_list_names, @graph.get_edge_list_names)
  end

  def test_get_adjacency_list
    graph_ = Graph.new
    graph_.insert_edge(100, 1, 2)
    graph_.insert_edge(101, 1, 3)
    graph_.insert_edge(102, 1, 4)
    graph_.insert_edge(103, 3, 4)

    adj_list = [nil, [[2, 100], [3, 101], [4, 102]], nil, [[4, 103]], nil]

    assert_equal(adj_list, graph_.get_adjacency_list)
  end

  def test_get_adjacency_list_names
    adj_list = [[['San Francisco', 51], ['Shanghai', 9950],
      ['Sao Paolo', 10_375]], [['Mountain View', 51], ['Shanghai', 9900],
      ['Berlin', 9130]], [['Shanghai', 9217], ['Berlin', 932],
      ['Sao Paolo', 9471]], [['Mountain View', 9950], ['San Francisco', 9900],
      ['London', 9217]], [['San Francisco', 9130], ['London', 932]],
      [['Mountain View', 10_375], ['London', 9471]], nil]

    assert_equal(adj_list, @graph.get_adjacency_list_names)
  end

  def test_get_adjacency_matrix
    graph_ = Graph.new
    graph_.insert_edge(100, 1, 2)
    graph_.insert_edge(101, 1, 3)
    graph_.insert_edge(102, 1, 4)
    graph_.insert_edge(103, 3, 4)

    adj_mx = [[0, 0, 0, 0, 0], [0, 0, 100, 101, 102], [0, 0, 0, 0, 0],
              [0, 0, 0, 0, 103], [0, 0, 0, 0, 0]]

    assert_equal(adj_mx, graph_.get_adjacency_matrix)
  end

  def test_find_max_index
    graph_ = Graph.new

    graph_.insert_edge(88, 0, 1)
    graph_.insert_edge(747, 3, 0)
    graph_.insert_edge(42, 2, 5)

    assert_equal(6, graph_.find_max_index)

    node_names_helper(graph_)
    assert_equal(7, graph_.find_max_index)
  end

  def test_find_node
    graph_ = Graph.new

    target_node = graph_.insert_node(99)
    graph_.insert_node(0)

    assert_equal(target_node, graph_.find_node(99))
    assert_nil(graph_.find_node(15))
  end

  def test_clear_visited
    graph_ = Graph.new

    graph_.insert_edge(99, 0, 1)
    graph_.nodes.each { |node| node.visited = true }
    graph_.insert_edge(25, 2, 1)

    assert(graph_.nodes[1].visited)
    refute(graph_.nodes[2].visited)

    graph_._clear_visited
    refute(graph_.nodes[1].visited)

    # no visited nodes exist
    result = graph_.nodes.any?(&:visited)

    refute(result)
  end

  def test_dfs
    dfs = [2, 3, 0, 1, 4, 5]
    assert_equal(dfs, @graph.dfs(2))
  end

  def test_dfs_helper
    dfs = [2, 3, 0, 1, 4, 5]
    start = @graph.find_node(2)
    assert_equal(dfs, @graph.dfs_helper(start))
  end

  def test_dfs_names
    dfs = ['London', 'Shanghai', 'Mountain View', 'San Francisco', 'Berlin',
           'Sao Paolo']
    assert_equal(dfs, @graph.dfs_names(2))
  end

  def test_bfs
    bfs = [2, 3, 4, 5, 0, 1]
    assert_equal(bfs, @graph.bfs(2))
  end

  def test_bfs_names
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

  p 'Depth First Search'
  pp graph.dfs_names(2)
  puts

  # Should print:
  # Depth First Search
  # ['London', 'Shanghai', 'Mountain View', 'San Francisco', 'Berlin',
  #  'Sao Paolo']

  p 'Breadth First Search'
  pp graph.bfs_names(2)
  puts

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
