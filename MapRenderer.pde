class MapRenderer {
    Graph graph; // Graf objekt til at administrere noder og kanter
    int currentFloor = 1; // Variabel til at spore den aktuelle etage

    MapRenderer(Graph graph) {
        this.graph = graph; // Initialiser grafen
    }

    void render(List<Node> path) {
        // Tegn en boks rundt om kortet
        stroke(50); // Sæt stregfarven til lidt lysere end baggrunden
        strokeWeight(2); // Sæt stregtykkelsen
        noFill(); // Deaktiver fyldfarve
        rect(10, 10, width - 20, height - 270); // Tegn rektanglet med lidt polstring

        // Tegn kanter (gange) på den aktuelle etage
        stroke(150); // Sæt stregfarven til lys grå
        strokeWeight(2); // Sæt stregtykkelsen
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
            stroke(0,100,255); // Sæt stregfarven til blå
            strokeWeight(3); // Sæt stregtykkelsen
            for (int i = 0; i < path.size() - 1; i++) {
                Node a = path.get(i); // Hent den aktuelle node i stien
                Node b = path.get(i + 1); // Hent den næste node i stien
                if ((a instanceof Room && ((Room) a).floor != currentFloor) ||
                    (a instanceof Intersection && ((Intersection) a).floor != currentFloor) ||
                    (b instanceof Room && ((Room) b).floor != currentFloor) ||
                    (b instanceof Intersection && ((Intersection) b).floor != currentFloor)) {
                    continue;
                }
                line(a.x, a.y, b.x, b.y); // Tegn linjen mellem noderne
            }
        }

        noStroke(); // Fjern stregen
        // Tegn noder (Værelser og Trapper) på den aktuelle etage
        fill(200); // Sæt fyldfarven til lys grå
        for (Room room : graph.rooms.values()) {
            if (room.floor != currentFloor) continue;
            ellipse(room.x, room.y, 20, 20); // Tegn værelser som cirkler
            fill(200); // Sæt fyldfarven til lys grå
            textAlign(CENTER, CENTER); // Sæt tekstjusteringen
            text(room.id, room.x, room.y - 15); // Tegn værelsets ID
        }

        for (Staircase staircase : graph.staircases.values()) {
            if (staircase.startFloor != currentFloor && staircase.endFloor != currentFloor) continue;
            rect(staircase.x - 10, staircase.y - 10, 20, 20); // Tegn trapper som firkanter
            fill(200); // Sæt fyldfarven til lys grå
            textAlign(CENTER, CENTER); // Sæt tekstjusteringen
            text(staircase.id, staircase.x, staircase.y - 15); // Tegn trappens ID
        }
    }

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