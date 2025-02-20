class Graph {
    HashMap<String, Node> nodes = new HashMap<>();
    HashMap<String, HashMap<String, Integer>> adjacencyList = new HashMap<>();

    void addNode(String id, float x, float y) {
        Node node = new Node(id, x, y);
        nodes.put(id, node);
        adjacencyList.put(id, new HashMap<>());
    }

    void addEdge(String from, String to, int weight) {
        adjacencyList.get(from).put(to, weight);
        adjacencyList.get(to).put(from, weight);
    }
}
