class MapRenderer {
    Graph graph; // Graph object to manage nodes and edges
    int currentFloor = 1; // Variable to track the current floor

    MapRenderer(Graph graph) {
        this.graph = graph; // Initialize the graph
    }

    void render(List<Node> path) {
        // Draw a box around the map
        stroke(50); // Set the stroke color to a bit brighter than the background
        strokeWeight(2); // Set the stroke weight
        noFill(); // Disable fill color
        rect(10, 10, width - 20, height - 270); // Draw the rectangle with some padding

        // Draw edges (hallways) on the current floor
        stroke(150); // Set the stroke color to light gray
        strokeWeight(2); // Set the stroke weight
        for (String from : graph.adjacencyList.keySet()) {
            Node nodeA = getNode(from); // Get the node for the from ID
            if (nodeA == null || (nodeA instanceof Room && ((Room) nodeA).floor != currentFloor) ||
                (nodeA instanceof Intersection && ((Intersection) nodeA).floor != currentFloor)) continue;
            for (String to : graph.adjacencyList.get(from).keySet()) {
                Node nodeB = getNode(to); // Get the node for the to ID
                if (nodeB == null || (nodeB instanceof Room && ((Room) nodeB).floor != currentFloor) ||
                    (nodeB instanceof Intersection && ((Intersection) nodeB).floor != currentFloor)) continue;
                line(nodeA.x, nodeA.y, nodeB.x, nodeB.y); // Draw the line between the nodes
            }
        }

        // Draw shortest path on the current floor
        if (path != null && path.size() > 1) {
            stroke(0,100,255); // Set the stroke color to blue
            strokeWeight(3); // Set the stroke weight
            for (int i = 0; i < path.size() - 1; i++) {
                Node a = path.get(i); // Get the current node in the path
                Node b = path.get(i + 1); // Get the next node in the path
                if ((a instanceof Room && ((Room) a).floor != currentFloor) ||
                    (a instanceof Intersection && ((Intersection) a).floor != currentFloor) ||
                    (b instanceof Room && ((Room) b).floor != currentFloor) ||
                    (b instanceof Intersection && ((Intersection) b).floor != currentFloor)) {
                    continue;
                }
                line(a.x, a.y, b.x, b.y); // Draw the line between the nodes
            }
        }

        noStroke(); // Remove the stroke
        // Draw nodes (Rooms and Staircases) on the current floor
        fill(200); // Set the fill color to light gray
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 20, 20); // Draw rooms as circles
            fill(200); // Set the fill color to light gray
            textAlign(CENTER, CENTER); // Set the text alignment
            text(room.id, room.x, room.y - 15); // Draw the room ID
        }

        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 10, staircase.y - 10, 20, 20); // Draw staircases as squares
            fill(200); // Set the fill color to light gray
            textAlign(CENTER, CENTER); // Set the text alignment
            text(staircase.id, staircase.x, staircase.y - 15); // Draw the staircase ID
        }
    }

    Node getNode(String id) {
        if (graph.rooms.containsKey(id)) return graph.rooms.get(id); // Return the room if the ID matches
        if (graph.intersections.containsKey(id)) return graph.intersections.get(id); // Return the intersection if the ID matches
        if (graph.staircases.containsKey(id)) return graph.staircases.get(id); // Return the staircase if the ID matches
        return null; // Return null if no matching node is found
    }

    void changeFloor(int floor) {
        currentFloor = floor; // Update the current floor
    }
}