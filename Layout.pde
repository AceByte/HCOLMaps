class Layout {
    Graph graph;
    LayoutManager layoutManager;

    Layout() {
        graph = new Graph();
        layoutManager = new LayoutManager(graph);
        createRoomsAndHallways();
    }

    void createRoomsAndHallways() {
        layoutManager.createRooms();
        layoutManager.createIntersections();
        layoutManager.createStaircases();

        // Sample hallways
        String[][] hallwayPairs = {
            {"A", "I1"},
            {"I1", "H"},
            {"I1", "I2"},
            {"I2", "B"},
            {"I2", "I3"},
            {"I3", "C"},
            {"I3", "I4"},
            {"I5", "F"},
            {"I5", "G"},
            {"I3", "E"},
            {"I2", "D"},
            {"I4", "I6"},
            {"I6", "I"},
            {"I6", "J"},
            {"I4", "I5"},
            {"I4", "I7"},
            {"I7", "I8"},
            {"I8", "K"},
            {"I8", "L"}
        };

        // Add hallways to graph with calculated weights
        for (String[] pair : hallwayPairs) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections);
            graph.addEdge(pair[0], pair[1], weight);
        }
    }

    int calculateWeight(String start, String end, Room[] rooms, Intersection[] intersections) {
        Node startNode = findNode(start, rooms, intersections);
        Node endNode = findNode(end, rooms, intersections);
        if (startNode != null && endNode != null) {
            return (int) dist(startNode.x, startNode.y, endNode.x, endNode.y);
        }
        return 0;
    }

    Node findNode(String id, Room[] rooms, Intersection[] intersections) {
        for (Room room : rooms) {
            if (room.id.equals(id)) {
                return room;
            }
        }
        for (Intersection intersection : intersections) {
            if (intersection.id.equals(id)) {
                return intersection;
            }
        }
        return null;
    }

    Graph getGraph() {
        return graph;
    }
}