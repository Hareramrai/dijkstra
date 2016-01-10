require 'minitest/autorun'
require '././graph'
#
class TestGraph < Minitest::Test
  def setup
    @graph = Graph.create_from_file
  end

  def test_create_from_file_should_failed_for_invalid_file_path
    error = assert_raises ArgumentError do |_|
      Graph.create_from_file '/incorrect_file'
    end
    assert_match(/Please provide a valid file path/, error.message)
  end

  def test_nodes_should_match_with_graph_nodes
    assert_equal (1..6).map(&:to_s), @graph.nodes.sort
  end

  def test_neighbors_should_failed_for_invalid_node
    error = assert_raises RuntimeError do |_|
      @graph.neighbors '29'
    end
    assert_match(/node is not part of the graph/, error.message)
  end

  def test_length_should_failed_for_invalid_source
    error = assert_raises RuntimeError do |_|
      @graph.length('9', '5')
    end
    assert_match(/node is not part of the graph/, error.message)
  end

  def test_length_should_failed_for_invalid_destination
    error = assert_raises RuntimeError do |_|
      @graph.length('9', '5')
    end
    assert_match(/node is not part of the graph/, error.message)
  end
end
