import java.util.*; // Import Java utilities

class Dijkstra {
    Graph graph; // Graph object to manage nodes and edges

    Dijkstra(Graph graph) {
        this.graph = graph; // Initialize the graph
    }

    List<Node> findShortestPath(String start, String end) {
        return dijkstra(graph, start, end); // Find the shortest path using Dijkstra's algorithm
    }

    List<Node> dijkstra(Graph graph, String start, String end) {
        Map<String, Integer> distances = new HashMap<>(); // Map to store distances from the start node
        Map<String, String> previous = new HashMap<>(); // Map to store the previous node in the path
        PriorityQueue<String> pq = new PriorityQueue<>(Comparator.comparingInt(distances::get)); // Priority queue for nodes to explore

        HashMap<String, Node> allNodes = graph.getAllNodes(); // Get all nodes in the graph
        for (String node : allNodes.keySet()) {
            distances.put(node, Integer.MAX_VALUE); // Initialize distances to infinity
            previous.put(node, null); // Initialize previous nodes to null
        }
        distances.put(start, 0); // Set the distance to the start node to 0
        pq.add(start); // Add the start node to the priority queue

        while (!pq.isEmpty()) {
            String current = pq.poll(); // Get the node with the smallest distance
            if (current.equals(end)) {
                break; // Stop if we reached the end node
            }

            Map<String, Integer> neighbors = graph.adjacencyList.get(current); // Get the neighbors of the current node
            if (neighbors != null) {
                for (String neighbor : neighbors.keySet()) {
                    int newDist = distances.get(current) + neighbors.get(neighbor); // Calculate the new distance to the neighbor
                    if (newDist < distances.get(neighbor)) {
                        distances.put(neighbor, newDist); // Update the distance to the neighbor
                        previous.put(neighbor, current); // Update the previous node for the neighbor
                        pq.add(neighbor); // Add the neighbor to the priority queue
                    }
                }
            }
        }

        List<Node> path = new ArrayList<>(); // List to store the path
        for (String at = end; at != null; at = previous.get(at)) {
            path.add(allNodes.get(at)); // Add the nodes in the path to the list
        }
        Collections.reverse(path); // Reverse the path to get the correct order
        return path; // Return the path
    }
}
