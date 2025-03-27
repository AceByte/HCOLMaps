import java.util.*;

class Dijkstra {
    Graph graph;

    Dijkstra(Graph graph) {
        this.graph = graph;
    }

    List<Node> findShortestPath(String start, String end) {
        return dijkstra(graph, start, end);
    }

    List<Node> dijkstra(Graph graph, String start, String end) {
        // Initialiser afstande og prioritetskø
        Map<String, Integer> distances = new HashMap<>();
        Map<String, String> previous = new HashMap<>();
        PriorityQueue<String> pq = new PriorityQueue<>(Comparator.comparingInt(distances::get));

        HashMap<String, Node> allNodes = graph.getAllNodes();
        for (String node : allNodes.keySet()) {
            distances.put(node, Integer.MAX_VALUE);
            previous.put(node, null);
        }
        distances.put(start, 0);
        pq.add(start);

        // Beregn korteste sti
        while (!pq.isEmpty()) {
            String current = pq.poll();
            if (current.equals(end)) {
                break;
            }

            Map<String, Integer> neighbors = graph.adjacencyList.get(current);
            if (neighbors != null) {
                for (String neighbor : neighbors.keySet()) {
                    int newDist = distances.get(current) + neighbors.get(neighbor);
                    if (newDist < distances.get(neighbor)) {
                        distances.put(neighbor, newDist);
                        previous.put(neighbor, current);
                        pq.add(neighbor);
                    }
                }
            }
        }

        // Rekonstruer stien fra slut til start
        List<Node> path = new ArrayList<>();
        for (String at = end; at != null; at = previous.get(at)) {
            path.add(allNodes.get(at));
        }
        Collections.reverse(path);
        return path;
    }
}
