require './dijkstra_algorithm'
require './graph'
response = 'Y'
while response.eql?('Y')
  puts 'Press key to perform dijkstra algorithm'
  puts '1: Provide graph details from the file'
  puts '2: Manually create graph from the egdes'
  str_i = gets.chomp
  if str_i == '1'
    puts 'Please enter file path, see the sample file in data folder'
    file_path = gets.chomp
    graph = Graph.create_from_file(file_path)
    puts 'Please enter source node'
    source = gets.chomp
    puts 'Please enter destination node'
    destination = gets.chomp
    dij = DijkstraAlgorithm.new graph, source
    puts 'Shortest path is '
    p dij.shortest_path source, destination
  elsif str_i == '2'
    puts 'Enter number of edges'
    no_of_edges = gets.chomp.to_i
    graph = Graph.new
    no_of_edges.times do |_|
      puts 'Please provide edge info in the form like \'source destination distance\' :'
      line = gets.chomp
      edge = Edge.parse line
      graph.add_edge edge
    end
    puts 'Please enter source node'
    source = gets.chomp
    puts 'Please enter destination node'
    destination = gets.chomp
    dij = DijkstraAlgorithm.new graph, source
    puts 'Shortest path is '
    p dij.shortest_path source, destination
  else
    puts 'Invalid input !'
  end
  puts "Do you want to continue again ? press 'Y/y' "
  response = gets.chomp.upcase
end
