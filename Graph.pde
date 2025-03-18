class Graph {
    HashMap<String, Room> rooms = new HashMap<>(); // Kort til at gemme værelser
    HashMap<String, Intersection> intersections = new HashMap<>(); // Kort til at gemme kryds
    HashMap<String, Staircase> staircases = new HashMap<>(); // Kort til at gemme trapper
    HashMap<String, HashMap<String, Integer>> adjacencyList = new HashMap<>(); // Adjacensliste til at gemme kanter

    void addRoom(String id, float x, float y, int floor) {
        // This method is redundant and can be removed or updated to include a default category
        Room room = new Room(id, x, y, floor); // Opret et nyt værelse med en standardkategori
        rooms.put(id, room); // Tilføj værelset til kortet
        adjacencyList.put(id, new HashMap<>()); // Initialiser adjacenslisten for værelset
    }

    void addIntersection(String id, float x, float y, int floor) {
        Intersection intersection = new Intersection(id, x, y, floor); // Opret et nyt kryds
        intersections.put(id, intersection); // Tilføj krydset til kortet
        adjacencyList.put(id, new HashMap<>()); // Initialiser adjacenslisten for krydset
    }

    void addStaircase(String id, float x, float y, int startFloor, int endFloor) {
        Staircase staircase = new Staircase(id, x, y, startFloor, endFloor); // Opret en ny trappe
        staircases.put(id, staircase); // Tilføj trappen til kortet
        adjacencyList.put(id, new HashMap<>()); // Initialiser adjacenslisten for trappen
    }

    void addEdge(String from, String to, int weight) {
        if (!adjacencyList.containsKey(from)) {
            adjacencyList.put(from, new HashMap<>()); // Initialiser adjacenslisten for fra-noden, hvis den ikke er til stede
        }
        if (!adjacencyList.containsKey(to)) {
            adjacencyList.put(to, new HashMap<>()); // Initialiser adjacenslisten for til-noden, hvis den ikke er til stede
        }
        adjacencyList.get(from).put(to, weight); // Tilføj kanten fra fra-noden til til-noden
        adjacencyList.get(to).put(from, weight); // Tilføj kanten fra til-noden til fra-noden
    }

    HashMap<String, Node> getAllNodes() {
        HashMap<String, Node> allNodes = new HashMap<>(); // Kort til at gemme alle noder
        allNodes.putAll(rooms); // Tilføj alle værelser til kortet
        allNodes.putAll(intersections); // Tilføj alle kryds til kortet
        allNodes.putAll(staircases); // Tilføj alle trapper til kortet
        return allNodes; // Returner kortet over alle noder
    }

    int getMinFloor() {
        int minFloor = Integer.MAX_VALUE;
        for (Room room : rooms.values()) {
            if (room.floor < minFloor) {
                minFloor = room.floor;
            }
        }
        for (Intersection intersection : intersections.values()) {
            if (intersection.floor < minFloor) {
                minFloor = intersection.floor;
            }
        }
        for (Staircase staircase : staircases.values()) {
            if (staircase.startFloor < minFloor) {
                minFloor = staircase.startFloor;
            }
            if (staircase.endFloor < minFloor) {
                minFloor = staircase.endFloor;
            }
        }
        return minFloor;
    }

    int getMaxFloor() {
        int maxFloor = Integer.MIN_VALUE;
        for (Room room : rooms.values()) {
            if (room.floor > maxFloor) {
                maxFloor = room.floor;
            }
        }
        for (Intersection intersection : intersections.values()) {
            if (intersection.floor > maxFloor) {
                maxFloor = intersection.floor;
            }
        }
        for (Staircase staircase : staircases.values()) {
            if (staircase.startFloor > maxFloor) {
                maxFloor = staircase.startFloor;
            }
            if (staircase.endFloor > maxFloor) {
                maxFloor = staircase.endFloor;
            }
        }
        return maxFloor;
    }
}