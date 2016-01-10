# dijkstra
Dijkstra algorithm in ruby with minitest

You can create graph from the file as input. 

````
graph = Graph.create_from_file 'data.txt' # if no arugment is provided then it will use data/sample_data.txt/ as default path. 
````

You can also create graph manually. 

````
graph = Graph.new
edge = Edge.new src, dest, distance
graph.add_edge edge # also you can add multiple edges using same method.

````
For using dijkstra_algorith, you have to pass a graph as argument.

````
graph = Graph.create_from_file 'data/sample_data.txt'
dijkstra = DijkstraAlgorithm.new graph, "1" # '1' as source node 
dijkstra.shortest_path '1', '5'

```

You can run all the test cases using below command in terminal. 

````
for file in test/*.rb; do ruby $file; done 
````
