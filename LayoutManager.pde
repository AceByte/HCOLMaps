class LayoutManager {
    Room[] rooms;
    Intersection[] intersections;
    Staircase[] staircases;
    Graph graph;

    LayoutManager(Graph graph) {
        this.graph = graph;
        createRooms();
        createIntersections();
        createStaircases();
    }

    void createRooms() {
        rooms = new Room[]{
            new Room("A", 100, 100, 1),
            new Room("B", 300, 100, 1),
            new Room("C", 500, 100, 1),
            new Room("D", 300, 300, 1),
            new Room("E", 500, 300, 1),
            new Room("F", 700, 100, 1),
            new Room("G", 700, 300, 1),
            new Room("H", 100, 300, 1),
            new Room("I", 500, 350, 1),
            new Room("J", 700, 350, 1),
            new Room("K", 100, 100, 2),
            new Room("L", 300, 100, 2)
        };

        for (Room room : rooms) {
            graph.addNode(room.id, room.x, room.y);
        }
    }

    void createIntersections() {
        intersections = new Intersection[]{
            new Intersection("I1", 100, 200, 1),
            new Intersection("I2", 300, 200, 1),
            new Intersection("I3", 500, 200, 1),
            new Intersection("I4", 600, 200, 1),
            new Intersection("I5", 700, 200, 1),
            new Intersection("I6", 600, 350, 1),
            new Intersection("I7", 600, 150, 1),
            new Intersection("I8", 600, 150, 2)
        };

        for (Intersection intersection : intersections) {
            graph.addNode(intersection.id, intersection.x, intersection.y);
        }
    }

    void createStaircases() {
        staircases = new Staircase[]{
            new Staircase("I7", 1, "I8", 2),
        };

        for (Staircase staircase : staircases) {
            graph.addEdge(staircase.start, staircase.end, 1); // Add default weight 1 for staircases
        }
    }
}