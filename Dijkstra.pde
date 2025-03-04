import java.util.*; // Importer Java-værktøjer

class Dijkstra {
    Graph graph; // Graf-objekt til at administrere noder og kanter

    Dijkstra(Graph graph) {
        this.graph = graph; // Initialiser grafen
    }

    List<Node> findShortestPath(String start, String end) {
        return dijkstra(graph, start, end); // Find den korteste sti ved hjælp af Dijkstra's algoritme
    }

    List<Node> dijkstra(Graph graph, String start, String end) {
        Map<String, Integer> distances = new HashMap<>(); // Kort til at gemme afstande fra startnoden
        Map<String, String> previous = new HashMap<>(); // Kort til at gemme den forrige node i stien
        PriorityQueue<String> pq = new PriorityQueue<>(Comparator.comparingInt(distances::get)); // Prioritetskø for noder, der skal udforskes

        HashMap<String, Node> allNodes = graph.getAllNodes(); // Hent alle noder i grafen
        for (String node : allNodes.keySet()) {
            distances.put(node, Integer.MAX_VALUE); // Initialiser afstande til uendelig
            previous.put(node, null); // Initialiser forrige noder til null
        }
        distances.put(start, 0); // Sæt afstanden til startnoden til 0
        pq.add(start); // Tilføj startnoden til prioritetskøen

        while (!pq.isEmpty()) {
            String current = pq.poll(); // Hent noden med den mindste afstand
            if (current.equals(end)) {
                break; // Stop, hvis vi har nået slutnoden
            }

            Map<String, Integer> neighbors = graph.adjacencyList.get(current); // Hent naboerne til den aktuelle node
            if (neighbors != null) {
                for (String neighbor : neighbors.keySet()) {
                    int newDist = distances.get(current) + neighbors.get(neighbor); // Beregn den nye afstand til naboen
                    if (newDist < distances.get(neighbor)) {
                        distances.put(neighbor, newDist); // Opdater afstanden til naboen
                        previous.put(neighbor, current); // Opdater den forrige node for naboen
                        pq.add(neighbor); // Tilføj naboen til prioritetskøen
                    }
                }
            }
        }

        List<Node> path = new ArrayList<>(); // Liste til at gemme stien
        for (String at = end; at != null; at = previous.get(at)) {
            path.add(allNodes.get(at)); // Tilføj noderne i stien til listen
        }
        Collections.reverse(path); // Vend stien for at få den korrekte rækkefølge
        return path; // Returner stien
    }
}
