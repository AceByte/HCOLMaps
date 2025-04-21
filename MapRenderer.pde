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
                Node a = path.get(i);
                Node b = path.get(i + 1);

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

                if (a instanceof Room && ((Room) a).floor == currentFloor) {
                    fill(0, 100, 255);
                    ellipse(a.x, a.y, 30, 30); // Increased size from 20 to 30
                }
                if (b instanceof Room && ((Room) b).floor == currentFloor) {
                    fill(0, 100, 255);
                    ellipse(b.x, b.y, 30, 30); // Increased size from 20 to 30
                }
                if (a instanceof Staircase && (((Staircase) a).startFloor == currentFloor || ((Staircase) a).endFloor == currentFloor)) {
                    fill(0, 100, 255);
                    rect(a.x - 15, a.y - 15, 30, 30); // Increased size from 20x20 to 30x30
                }
                if (b instanceof Staircase && (((Staircase) b).startFloor == currentFloor || ((Staircase) b).endFloor == currentFloor)) {
                    fill(0, 100, 255);
                    rect(b.x - 15, b.y - 15, 30, 30); // Increased size from 20x20 to 30x30
                }

                stroke(0, 100, 255);
                line(a.x, a.y, b.x, b.y);

                stroke(0, 200, 255);
                dash.offset(dist);
                dash.line(a.x, a.y, b.x, b.y);

                dist += 0.1;
            }
        }
        noStroke();

        // Tegn alle værelser (grå cirkler og etiketter)
        fill(200);
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 30, 30); // Increased size from 20 to 30
            fill(0); // Set text color to black
            textAlign(CENTER, CENTER);
            text(room.id, room.x, room.y - 20); // Adjusted label position
        }

        // Tegn alle trapper (grå rektangler og etiketter)
        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 15, staircase.y - 15, 30, 30); // Increased size from 20x20 to 30x30
            fill(0); // Set text color to black
            textAlign(CENTER, CENTER);
            text(staircase.id, staircase.x, staircase.y - 20); // Adjusted label position
        }

        // Fremhæv værelser og trapper i stien (blå cirkler og rektangler)
        if (path != null && path.size() > 1) {
            for (int i = 0; i < path.size(); i++) {
                Node node = path.get(i);

                if (node instanceof Room && ((Room) node).floor == currentFloor) {
                    fill(0, 100, 255);
                    ellipse(node.x, node.y, 30, 30); // Increased size from 20 to 30
                }
                if (node instanceof Staircase && (((Staircase) node).startFloor == currentFloor || ((Staircase) node).endFloor == currentFloor)) {
                    fill(0, 100, 255);
                    rect(node.x - 15, node.y - 15, 30, 30); // Increased size from 20x20 to 30x30
                }
            }
        }
    }

    // Hjælpemetode til at hente en node fra grafen baseret på ID
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