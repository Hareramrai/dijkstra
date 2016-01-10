#
class Edge

  attr_reader :distance, :source, :destination

  def initialize(src, dest, weight)
    @source = src
    @destination = dest
    @distance = weight
  end

  def either
    @source
  end

  def other(vertex)
    (vertex == @source) ? @destination : @source
  end

  # str has value of source, destination and distance
  def self.parse(str)
    arr = str.split
    raise ArgumentError, 'Edge should have only three' \
      ' field(src dest weight)' unless arr.size == 3
    raise ArgumentError, 'Distance of node should be numeric.' unless arr[2].number?
    Edge.new arr[0], arr[1], arr[2]
  end
end

# added number method to check wheather a string value is number or not
class String
  def number?
    true if Float(self) rescue nil
  end
end
