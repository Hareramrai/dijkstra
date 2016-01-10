require 'minitest/autorun'
require '././dijkstra_algorithm'
require '././graph'
#
class TestDijkstraAlgorithm < Minitest::Test
  def setup
    @graph = Graph.create_from_file
    @dijkstra = DijkstraAlgorithm.new @graph, '1'
  end

  def test_dijkstra_algorithm_failed_without_graph
    error = assert_raises ArgumentError do |_|
      DijkstraAlgorithm.new '', ''
    end
    assert_match(/Graph should be vaild object/, error.message)
  end

  def test_dijkstra_failed_with_invalid_source_node
    error = assert_raises RuntimeError do |_|
      DijkstraAlgorithm.new @graph, 'abc'
    end
    assert_match(/node is not part of the graph/, error.message)
  end

  def test_shortest_path_should_failed_with_invalid_source
    error = assert_raises RuntimeError do |_|
      @dijkstra.shortest_path('8', '5')
    end
    assert_match(/node is not part of the graph/, error.message)
  end

  def test_shortest_path_should_failed_with_invalid_destination
    error = assert_raises RuntimeError do |_|
      @dijkstra.shortest_path('1', '8')
    end
    assert_match(/node is not part of the graph/, error.message)
  end

  def test_shortest_path_should_work_with_valid_points
    assert_equal %w(1 3 6 5), @dijkstra.shortest_path('1', '5')
  end

end
