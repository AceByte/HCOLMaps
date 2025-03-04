class Layout {
    Graph graph; // Graf objekt til at administrere noder og kanter
    LayoutManager layoutManager; // LayoutManager objekt til at skabe rum og kryds

    Layout() {
        graph = new Graph(); // Initialiser grafen
        layoutManager = new LayoutManager(graph); // Initialiser layout manageren med grafen
        createRoomsAndHallways(); // Opret rum og gange
    }

    void createRoomsAndHallways() {
        layoutManager.createRooms(); // Opret rum
        layoutManager.createIntersections(); // Opret kryds
        layoutManager.createStaircases(); // Opret trapper

        // Eksempel på gange for første sal
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

        // Eksempel på gange for anden sal
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

        // Eksempel på gange for tredje sal
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

        // Tilføj gange til grafen med beregnede vægte
        for (String[] pair : hallwayPairs) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections); // Beregn vægt for gangen
            graph.addEdge(pair[0], pair[1], weight); // Tilføj kant til grafen
        }
        for (String[] pair : hallwayPairs2) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections); // Beregn vægt for gangen
            graph.addEdge(pair[0], pair[1], weight); // Tilføj kant til grafen
        }
        for (String[] pair : hallwayPairs3) {
            int weight = calculateWeight(pair[0], pair[1], layoutManager.rooms, layoutManager.intersections); // Beregn vægt for gangen
            graph.addEdge(pair[0], pair[1], weight); // Tilføj kant til grafen
        }
    }

    int calculateWeight(String start, String end, Room[] rooms, Intersection[] intersections) {
        Node startNode = findNode(start, rooms, intersections); // Find startnoden
        Node endNode = findNode(end, rooms, intersections); // Find slutnoden
        if (startNode != null && endNode != null) {
            return (int) dist(startNode.x, startNode.y, endNode.x, endNode.y); // Beregn afstanden mellem noderne
        }
        return 0; // Returner 0 hvis noderne ikke findes
    }

    Node findNode(String id, Room[] rooms, Intersection[] intersections) {
        for (Room room : rooms) {
            if (room.id.equals(id)) {
                return room; // Returner rummet hvis ID'et matcher
            }
        }
        for (Intersection intersection : intersections) {
            if (intersection.id.equals(id)) {
                return intersection; // Returner krydset hvis ID'et matcher
            }
        }
        return null; // Returner null hvis ingen matchende node findes
    }

    Graph getGraph() {
        return graph; // Returner grafen
    }
}