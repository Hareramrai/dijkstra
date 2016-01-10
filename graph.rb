#
class Graph
  require './edge'

  def initialize(nodes = nil)
    @adjency_list = {}
    nodes.each { |node| @adjency_list[node] = [] } unless nodes.nil?
  end

  # class methods

  class << self
    # will create graph from the file
    def create_from_file(file_path = 'data/sample_data.txt')
      raise ArgumentError, 'Please provide a valid file path.' unless File.exists?(file_path)
      graph = new
      File.readlines(file_path).each do |line|
        next if line.to_s.strip.length == 0
        edge = Edge.parse line
        graph.add_edge edge
      end
      graph
    end
  end

  # instance methods
  def add_edge(edge)
    src = get_or_create(edge.either)
    dest = get_or_create(edge.other(edge.either))
    edge = Edge.new(src, dest, edge.distance.to_f)
    @adjency_list[src].push(edge)

    # If start == from we don't want to add the edge twice
    @adjency_list[dest].push(edge) if (src != dest)
  end

  def nodes
    @adjency_list.keys
  end

  def neighbors(node)
    validate_node(node)
    @adjency_list[node].dup
  end

  def length(src, dest)
    validate_node src
    validate_node dest
    @adjency_list[src].select { |edge| edge.destination.eql?(dest) || edge.source.eql?(dest) }
      .first.distance
  end

  def validate_node(node)
    node = node.to_s
    fail 'node is not part of the graph' unless @adjency_list.key?(node)
  end

  private

  def get_or_create(node)
    array_id = nodes.find_index(node)
    return nodes[array_id] unless array_id.nil?
    @adjency_list[node] = []
    node
  end
end
