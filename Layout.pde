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

        // Sample hallways for the first floor
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
            {"I4", "I7"}
        };

        // Sample hallways for the second floor
        String[][] hallwayPairs2 = {
            {"K", "I8"},
            {"I8", "R"},
            {"I8", "I9"},
            {"I9", "L"},
            {"I9", "I10"},
            {"I10", "M"},
            {"I10", "I11"},
            {"I12", "P"},
            {"I12", "Q"},
            {"I10", "O"},
            {"I9", "N"},
            {"I11", "I13"},
            {"I13", "S"},
            {"I13", "T"},
            {"I11", "I12"},
            {"I11", "I14"}
        };

        // Sample hallways for the third floor
        String[][] hallwayPairs3 = {
            {"U", "I15"},
            {"I15", "BB"},
            {"I15", "I16"},
            {"I16", "V"},
            {"I16", "I17"},
            {"I17", "W"},
            {"I17", "I18"},
            {"I19", "Z"},
            {"I19", "AA"},
            {"I17", "Y"},
            {"I16", "X"},
            {"I18", "I20"},
            {"I20", "CC"},
            {"I20", "DD"},
            {"I18", "I19"},
            {"I18", "I21"}
        };

        // Add hallways to graph with calculated weights
        for (String[] pair : hallwayPairs) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections);
            graph.addEdge(pair[0], pair[1], weight);
        }
        for (String[] pair : hallwayPairs2) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections);
            graph.addEdge(pair[0], pair[1], weight);
        }
        for (String[] pair : hallwayPairs3) {
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