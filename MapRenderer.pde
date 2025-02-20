class MapRenderer {
    Graph graph;
    int currentFloor = 1;

    MapRenderer(Graph graph) {
        this.graph = graph;
    }

    void render(List<Node> path) {
        background(255); // Ensure background is reset

        // Draw edges (hallways)
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

        // Draw nodes (Rooms & Intersections)
        ellipseMode(CENTER); // Ensure circles are drawn correctly
        textAlign(CENTER, CENTER);
        textSize(14); // Ensure labels are visible

        for (Node node : graph.nodes.values()) {
            if (node instanceof Room) {
                if (((Room) node).floor != currentFloor) continue;
                fill(0, 0, 255); // Blue for rooms
                ellipse(node.x, node.y, 20, 20);
                fill(0); // Black text
                text(node.id, node.x, node.y - 15);
            } else if (node instanceof Intersection) {
                if (((Intersection) node).floor != currentFloor) continue;
                fill(150); // Gray for intersections
                ellipse(node.x, node.y, 20, 20);
            }
        }

        // Draw shortest path
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
