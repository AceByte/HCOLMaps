class Layout {
    Graph graph;
    Layout() {
        graph = new Graph();
        createRoomsAndHallways();
    }

    void createRoomsAndHallways() {
        // Sample rooms
        Room[] rooms = {
            new Room("A", 100, 100),
            new Room("B", 300, 100),
            new Room("C", 500, 100),
            new Room("D", 300, 300),
            new Room("E", 500, 300),
            new Room("F", 700, 100),
            new Room("G", 700, 300),
            new Room("H", 100, 300),
            new Room("I", 500, 350),
            new Room("J", 700, 350)
        };

        // Add rooms to graph
        for (Room room : rooms) {
            graph.addNode(room.id, room.x, room.y);
        }

        // Sample intersection points
        Intersection[] intersections = {
            new Intersection("I1", 100, 200),
            new Intersection("I2", 300, 200),
            new Intersection("I3", 500, 200),
            new Intersection("I4", 600, 200),
            new Intersection("I5", 700, 200),
            new Intersection("I6", 600, 350)

        };

        // Add intersections to graph
        for (Intersection intersection : intersections) {
            graph.addNode(intersection.id, intersection.x, intersection.y);
        }

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
            {"I4", "I5"}
        };

        // Add hallways to graph with calculated weights
        for (String[] pair : hallwayPairs) {
            int weight = calculateWeight(pair[0], pair[1], rooms, intersections);
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