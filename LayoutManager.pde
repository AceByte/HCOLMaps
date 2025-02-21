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
            new Room("A", 50, 50, 1),
            new Room("B", 250, 50, 1),
            new Room("C", 450, 50, 1),
            new Room("D", 250, 250, 1),
            new Room("E", 450, 250, 1),
            new Room("F", 650, 50, 1),
            new Room("G", 650, 250, 1),
            new Room("H", 50, 250, 1),
            new Room("I", 450, 300, 1),
            new Room("J", 650, 300, 1),
            new Room("K", 50, 50, 2),
            new Room("L", 250, 50, 2)
        };

        for (Room room : rooms) {
            graph.addRoom(room.id, room.x, room.y, room.floor);
        }
    }

    void createIntersections() {
        intersections = new Intersection[]{
            new Intersection("I1", 50, 150, 1),
            new Intersection("I2", 250, 150, 1),
            new Intersection("I3", 450, 150, 1),
            new Intersection("I4", 550, 150, 1),
            new Intersection("I5", 650, 150, 1),
            new Intersection("I6", 550, 300, 1),
            new Intersection("I7", 550, 100, 1),
            new Intersection("I8", 550, 100, 2)
        };

        for (Intersection intersection : intersections) {
            graph.addIntersection(intersection.id, intersection.x, intersection.y, intersection.floor);
        }
    }

    void createStaircases() {
        staircases = new Staircase[]{
            new Staircase("S1", 550, 100, 1, 2)
        };

        for (Staircase staircase : staircases) {
            graph.addStaircase(staircase.id, staircase.x, staircase.y, staircase.startFloor, staircase.endFloor);
            graph.addEdge(staircase.id, "I7", 1); // Connect staircase to intersection on floor 1
            graph.addEdge(staircase.id, "I8", 1); // Connect staircase to intersection on floor 2
        }
    }
}