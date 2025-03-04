class LayoutManager {
    Room[] rooms; // Array til at gemme værelser
    Intersection[] intersections; // Array til at gemme kryds
    Staircase[] staircases; // Array til at gemme trapper
    Graph graph; // Graf-objekt til at administrere noder og kanter

    LayoutManager(Graph graph) {
        this.graph = graph; // Initialiser grafen
        createRooms(); // Opret værelser
        createIntersections(); // Opret kryds
        createStaircases(); // Opret trapper
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
            new Room("L", 250, 50, 2),
            new Room("M", 450, 50, 2),
            new Room("N", 250, 250, 2),
            new Room("O", 450, 250, 2),
            new Room("P", 650, 50, 2),
            new Room("Q", 650, 250, 2),
            new Room("R", 50, 250, 2),
            new Room("S", 450, 300, 2),
            new Room("T", 650, 300, 2),
            new Room("U", 50, 50, 3),
            new Room("V", 250, 50, 3),
            new Room("W", 450, 50, 3),
            new Room("X", 250, 250, 3),
            new Room("Y", 450, 250, 3),
            new Room("Z", 650, 50, 3),
            new Room("AA", 650, 250, 3),
            new Room("BB", 50, 250, 3),
            new Room("CC", 450, 300, 3),
            new Room("DD", 650, 300, 3)
        };

        for (Room room : rooms) {
            graph.addRoom(room.id, room.x, room.y, room.floor); // Tilføj hvert værelse til grafen
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
            new Intersection("I8", 50, 150, 2),
            new Intersection("I9", 250, 150, 2),
            new Intersection("I10", 450, 150, 2),
            new Intersection("I11", 550, 150, 2),
            new Intersection("I12", 650, 150, 2),
            new Intersection("I13", 550, 300, 2),
            new Intersection("I14", 550, 250, 2),
            new Intersection("I15", 50, 150, 3),
            new Intersection("I16", 250, 150, 3),
            new Intersection("I17", 450, 150, 3),
            new Intersection("I18", 550, 150, 3),
            new Intersection("I19", 650, 150, 3),
            new Intersection("I20", 550, 300, 3),
            new Intersection("I21", 550, 250, 3)
        };

        for (Intersection intersection : intersections) {
            graph.addIntersection(intersection.id, intersection.x, intersection.y, intersection.floor); // Tilføj hvert kryds til grafen
        }
    }

    void createStaircases() {
        staircases = new Staircase[]{
            new Staircase("S1", 550, 100, 1, 2),
            new Staircase("S2", 550, 250, 2, 3)
        };

        for (Staircase staircase : staircases) {
            graph.addStaircase(staircase.id, staircase.x, staircase.y, staircase.startFloor, staircase.endFloor); // Tilføj hver trappe til grafen
            graph.addEdge(staircase.id, "I7", 1); // Forbind trappen til krydset på etage 1
            graph.addEdge(staircase.id, "I14", 1); // Forbind trappen til krydset på etage 2
            graph.addEdge(staircase.id, "I21", 1); // Forbind trappen til krydset på etage 3
        }
    }
}