# This class perform dijkstra algorithm on given graph with source node
class DijkstraAlgorithm
  require './graph'
  def initialize(graph, source = nil)
    raise ArgumentError, 'Graph should be vaild object' unless graph.is_a? Graph
    @graph = graph
    @graph.validate_node source if source
    @source = source || graph.nodes.first
    @distances = {}
    @previous  = {}
    @unvisited_node = []
  end

  def shortest_path(source, destination)
    path = []
    @graph.validate_node source
    @graph.validate_node destination
    dijkstra
    while @previous[destination] && source != destination
      path.unshift(destination)
      destination = @previous[destination]
    end
    path.unshift(destination)
  end

  private

  def initialize_defaults
    @graph.nodes.each do |node|
      @distances[node] = Float::INFINITY # Unknown distance from src to node
      @previous[node] = nil # Previous node in optimal path from source
      @unvisited_node << node
    end
    @distances[@source.to_s] = 0 # Distance from source to source
  end

  def minimum_distance_node
    @distances.select { |k, _| @unvisited_node.include?(k.to_s) }
      .min_by { |_, v| v }
  end

  # compute for shorter path
  def compute_cost(src, dest)
    cost = @distances[src] + @graph.length(src, dest)
    return if cost > @distances[dest]
    # shorter path has been found
    @distances[dest] = cost
    @previous[dest] = src
  end

  def perform
    until @unvisited_node.empty?
      min_node = minimum_distance_node.first # .first returns the node key
      @unvisited_node.delete min_node
      @graph.neighbors(min_node).each do |vertex|
        compute_cost min_node, vertex.other(min_node)
      end
    end
  end

  def dijkstra
    initialize_defaults
    perform
  end

end
