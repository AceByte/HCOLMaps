import garciadelcastillo.dashedlines.*;
class MapRenderer {
    float dist = 0;
    DashedLines dash;
    Graph graph;
    int currentFloor = 1;
    PApplet parent;

    MapRenderer(Graph graph, PApplet parent) {
        this.graph = graph;
        this.parent = parent;
        dash = new DashedLines(parent);
    }

    void render(List<Node> path) {
        dash.pattern(10, 10);
        // Tegn en boks rundt om kortet
        stroke(50);
        strokeWeight(2);
        noFill();
        rect(10, 10, width - 20, height - 270);

        // Tegn kanter (gange) på den aktuelle etage
        stroke(150);
        strokeWeight(2);
        for (String from : graph.adjacencyList.keySet()) {
            Node nodeA = getNode(from); // Hent noden for fra-ID'et
            if (nodeA == null || (nodeA instanceof Room && ((Room) nodeA).floor != currentFloor) ||
                (nodeA instanceof Intersection && ((Intersection) nodeA).floor != currentFloor)) continue;
            for (String to : graph.adjacencyList.get(from).keySet()) {
                Node nodeB = getNode(to); // Hent noden for til-ID'et
                if (nodeB == null || (nodeB instanceof Room && ((Room) nodeB).floor != currentFloor) ||
                    (nodeB instanceof Intersection && ((Intersection) nodeB).floor != currentFloor)) continue;
                line(nodeA.x, nodeA.y, nodeB.x, nodeB.y); // Tegn linjen mellem noderne
            }
        }

        // Tegn korteste sti på den aktuelle etage
        if (path != null && path.size() > 1) {
            strokeWeight(3);
            for (int i = 0; i < path.size() - 1; i++) {
                Node a = path.get(i); // Hent den aktuelle node i stien
                Node b = path.get(i + 1); // Hent den næste node i stien

                // Check for null nodes
                if (a == null || b == null) {
                    println("Warning: Null node in path at index " + i);
                    continue;
                }

                if ((a instanceof Room && ((Room) a).floor != currentFloor) ||
                    (a instanceof Intersection && ((Intersection) a).floor != currentFloor) ||
                    (b instanceof Room && ((Room) b).floor != currentFloor) ||
                    (b instanceof Intersection && ((Intersection) b).floor != currentFloor)) {
                    continue;
                }

                // Highlight rooms and stairs that the line goes through
                if (a instanceof Room && ((Room) a).floor == currentFloor) {
                    fill(0, 100, 255); // Sæt farven til blå
                    ellipse(a.x, a.y, 20, 20); // Tegn værelset som en cirkel
                }
                if (b instanceof Room && ((Room) b).floor == currentFloor) {
                    fill(0, 100, 255); // Sæt farven til blå
                    ellipse(b.x, b.y, 20, 20); // Tegn værelset som en cirkel
                }
                if (a instanceof Staircase && (((Staircase) a).startFloor == currentFloor || ((Staircase) a).endFloor == currentFloor)) {
                    fill(0, 100, 255); // Sæt farven til blå
                    rect(a.x - 10, a.y - 10, 20, 20); // Tegn trappen som en firkant
                }
                if (b instanceof Staircase && (((Staircase) b).startFloor == currentFloor || ((Staircase) b).endFloor == currentFloor)) {
                    fill(0, 100, 255); // Sæt farven til blå
                    rect(b.x - 10, b.y - 10, 20, 20); // Tegn trappen som en firkant
                }

                stroke(0, 100, 255); // Sæt stregfarven til blå
                line(a.x, a.y, b.x, b.y); // Tegn linjen mellem noderne

                stroke(0, 200, 255); // Sæt stregfarven til blå
                dash.offset(dist); // Brug den aktuelle offset
                dash.line(a.x, a.y, b.x, b.y); // Tegn stiplet linje mellem noderne

                dist += 0.1; // Nulstil dist for at gøre det konsistent
            }
        }
        noStroke();

        // Draw all rooms (gray circles and labels)
        fill(200);
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 20, 20); // Draw rooms as gray circles
            fill(200);
            textAlign(CENTER, CENTER);
            text(room.id, room.x, room.y - 15); // Draw room ID
        }

        // Draw all staircases (gray rectangles and labels)
        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 10, staircase.y - 10, 20, 20); // Draw staircases as gray rectangles
            fill(200);
            textAlign(CENTER, CENTER);
            text(staircase.id, staircase.x, staircase.y - 15); // Draw staircase ID
        }

        // Highlight rooms and staircases in the path (blue circles and rectangles)
        if (path != null && path.size() > 1) {
            for (int i = 0; i < path.size(); i++) {
                Node node = path.get(i);

                if (node instanceof Room && ((Room) node).floor == currentFloor) {
                    fill(0, 100, 255); // Set color to blue
                    ellipse(node.x, node.y, 20, 20); // Draw the room as a blue circle
                }
                if (node instanceof Staircase && (((Staircase) node).startFloor == currentFloor || ((Staircase) node).endFloor == currentFloor)) {
                    fill(0, 100, 255); // Set color to blue
                    rect(node.x - 10, node.y - 10, 20, 20); // Draw the staircase as a blue rectangle
                }
            }
        }
    }

    // Hjælpemetode til at hente en node fra grafen baseret på ID
    Node getNode(String id) {
        if (graph.rooms.containsKey(id)) return graph.rooms.get(id); // Returner værelset hvis ID'et matcher
        if (graph.intersections.containsKey(id)) return graph.intersections.get(id); // Returner krydset hvis ID'et matcher
        if (graph.staircases.containsKey(id)) return graph.staircases.get(id); // Returner trappen hvis ID'et matcher
        return null; // Returner null hvis ingen matchende node findes
    }

    void changeFloor(int floor) {
        currentFloor = floor; // Opdater den aktuelle etage
    }
}