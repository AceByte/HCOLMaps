class MapRenderer {
    Graph graph;

    MapRenderer(Graph graph) {
        this.graph = graph;
    }

    void render(List<Node> path) {
        // Draw edges (hallways)
        stroke(200);
        strokeWeight(2);
        for (String from : graph.adjacencyList.keySet()) {
            Node nodeA = graph.nodes.get(from);
            for (String to : graph.adjacencyList.get(from).keySet()) {
                Node nodeB = graph.nodes.get(to);
                line(nodeA.x, nodeA.y, nodeB.x, nodeB.y);
            }
        }

        // Draw nodes (Rooms, Intersections)
        fill(0);
        for (Node node : graph.nodes.values()) {
            ellipse(node.x, node.y, 20, 20);
            fill(0);
            textAlign(CENTER, CENTER);
            text(node.id, node.x, node.y - 15);
        }

        // Draw shortest path
        if (path != null && path.size() > 1) {
            stroke(255, 0, 0);
            strokeWeight(3);
            for (int i = 0; i < path.size() - 1; i++) {
                Node a = path.get(i);
                Node b = path.get(i + 1);
                line(a.x, a.y, b.x, b.y);
            }
        }
    }
}
