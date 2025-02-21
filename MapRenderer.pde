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
            Node nodeA = getNode(from);
            if (nodeA == null || (nodeA instanceof Room && ((Room) nodeA).floor != currentFloor) ||
                (nodeA instanceof Intersection && ((Intersection) nodeA).floor != currentFloor)) continue;
            for (String to : graph.adjacencyList.get(from).keySet()) {
                Node nodeB = getNode(to);
                if (nodeB == null || (nodeB instanceof Room && ((Room) nodeB).floor != currentFloor) ||
                    (nodeB instanceof Intersection && ((Intersection) nodeB).floor != currentFloor)) continue;
                line(nodeA.x, nodeA.y, nodeB.x, nodeB.y);
            }
        }

        // Draw nodes (Rooms and Staircases) on the current floor
        fill(0);
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 20, 20); // Draw rooms as circles
            fill(0);
            textAlign(CENTER, CENTER);
            text(room.id, room.x, room.y - 15);
        }

        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 10, staircase.y - 10, 20, 20); // Draw staircases as squares
            fill(0);
            textAlign(CENTER, CENTER);
            text(staircase.id, staircase.x, staircase.y - 15);
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

    Node getNode(String id) {
        if (graph.rooms.containsKey(id)) return graph.rooms.get(id);
        if (graph.intersections.containsKey(id)) return graph.intersections.get(id);
        if (graph.staircases.containsKey(id)) return graph.staircases.get(id);
        return null;
    }

    void changeFloor(int floor) {
        currentFloor = floor;
    }
}