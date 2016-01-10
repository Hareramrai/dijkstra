require 'minitest/autorun'
require '././edge'
#
class TestEdge < Minitest::Test
  def setup
    @edge = Edge.new "1", "2", "8"
  end

  def test_either_should_return_source
    assert_match @edge.either, @edge.source
  end

  def test_other_should_return_alternate_value
    assert_match @edge.destination, @edge.other(@edge.source)
  end

  def test_parse_failed_for_empty_string
    error = assert_raises ArgumentError do |_|
      Edge.parse ''
    end
    assert_match(/Edge should have only three/, error.message)
  end

  def test_parse_should_failed_for_invalid_distance_value
    error = assert_raises ArgumentError do |_|
      Edge.parse '1 2 distance'
    end
    assert_match(/Distance of node should be numeric./, error.message)
  end

end
