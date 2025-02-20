class MapRenderer {
    Graph graph;
    int currentFloor = 1;

    MapRenderer(Graph graph) {
        this.graph = graph;
    }

    void render(List<Node> path) {
        // Draw edges (hallways) on the current floor
        stroke(200);
        strokeWeight(2);
        for (String from : graph.adjacencyList.keySet()) {
            Node nodeA = graph.nodes.get(from);
            if (nodeA instanceof Room && ((Room) nodeA).floor != currentFloor) continue;
            if (nodeA instanceof Intersection && ((Intersection) nodeA).floor != currentFloor) continue;
            for (String to : graph.adjacencyList.get(from).keySet()) {
                Node nodeB = graph.nodes.get(to);
                if (nodeB instanceof Room && ((Room) nodeB).floor != currentFloor) continue;
                if (nodeB instanceof Intersection && ((Intersection) nodeB).floor != currentFloor) continue;
                line(nodeA.x, nodeA.y, nodeB.x, nodeB.y);
            }
        }

        // Draw nodes (Rooms, Intersections) on the current floor
        fill(0);
        for (Node node : graph.nodes.values()) {
            if (node instanceof Room && ((Room) node).floor != currentFloor) continue;
            if (node instanceof Intersection && ((Intersection) node).floor != currentFloor) continue;
            ellipse(node.x, node.y, 20, 20);
            fill(0);
            textAlign(CENTER, CENTER);
            text(node.id, node.x, node.y - 15);
        }

        // Draw shortest path on the current floor
        if (path != null && path.size() > 1) {
            stroke(255, 0, 0);
            strokeWeight(3);
            for (int i = 0; i < path.size() - 1; i++) {
                Node a = path.get(i);
                Node b = path.get(i + 1);
                if ((a instanceof Room && ((Room) a).floor != currentFloor) ||
                    (a instanceof Intersection && ((Intersection) a).floor != currentFloor) ||
                    (b instanceof Room && ((Room) b).floor != currentFloor) ||
                    (b instanceof Intersection && ((Intersection) b).floor != currentFloor)) {
                    continue;
                }
                line(a.x, a.y, b.x, b.y);
            }
        }
    }

    void changeFloor(int floor) {
        currentFloor = floor;
    }
}
