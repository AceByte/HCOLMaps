class Graph {
    HashMap<String, Room> rooms = new HashMap<>();
    HashMap<String, Intersection> intersections = new HashMap<>();
    HashMap<String, Staircase> staircases = new HashMap<>();
    HashMap<String, HashMap<String, Integer>> adjacencyList = new HashMap<>();

    void addRoom(String id, float x, float y, int floor) {
        Room room = new Room(id, x, y, floor);
        rooms.put(id, room);
        adjacencyList.put(id, new HashMap<>());
    }

    void addIntersection(String id, float x, float y, int floor) {
        Intersection intersection = new Intersection(id, x, y, floor);
        intersections.put(id, intersection);
        adjacencyList.put(id, new HashMap<>());
    }

    void addStaircase(String id, float x, float y, int startFloor, int endFloor) {
        Staircase staircase = new Staircase(id, x, y, startFloor, endFloor);
        staircases.put(id, staircase);
        adjacencyList.put(id, new HashMap<>());
    }

    void addEdge(String from, String to, int weight) {
        if (!adjacencyList.containsKey(from)) {
            adjacencyList.put(from, new HashMap<>());
        }
        if (!adjacencyList.containsKey(to)) {
            adjacencyList.put(to, new HashMap<>());
        }
        adjacencyList.get(from).put(to, weight);
        adjacencyList.get(to).put(from, weight);
    }

    HashMap<String, Node> getAllNodes() {
        HashMap<String, Node> allNodes = new HashMap<>();
        allNodes.putAll(rooms);
        allNodes.putAll(intersections);
        allNodes.putAll(staircases);
        return allNodes;
    }
}
