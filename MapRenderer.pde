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
                stroke(0,100,255); // Sæt stregfarven til blå
                line(a.x, a.y, b.x, b.y); // Tegn linjen mellem noderne

                stroke(0,200,255); // Sæt stregfarven til blå
                dash.line(a.x, a.y, b.x, b.y); // Tegn stiplet linje mellem noderne

                dash.offset(dist);
                dist += 0.1;

            }
        }
        noStroke();

        // Tegn noder (Værelser og Trapper) på den aktuelle etage
        fill(200);
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 20, 20); // Tegn værelser som cirkler
            fill(200);
            textAlign(CENTER, CENTER);
            text(room.id, room.x, room.y - 15); // Tegn værelsets ID
        }

        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 10, staircase.y - 10, 20, 20); // Tegn trapper som firkanter
            fill(200);
            textAlign(CENTER, CENTER);
            text(staircase.id, staircase.x, staircase.y - 15); // Tegn trappens ID
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