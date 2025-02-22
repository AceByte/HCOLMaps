class Graph {
    HashMap<String, Room> rooms = new HashMap<>(); // Map to store rooms
    HashMap<String, Intersection> intersections = new HashMap<>(); // Map to store intersections
    HashMap<String, Staircase> staircases = new HashMap<>(); // Map to store staircases
    HashMap<String, HashMap<String, Integer>> adjacencyList = new HashMap<>(); // Adjacency list to store edges

    void addRoom(String id, float x, float y, int floor) {
        Room room = new Room(id, x, y, floor); // Create a new room
        rooms.put(id, room); // Add the room to the map
        adjacencyList.put(id, new HashMap<>()); // Initialize the adjacency list for the room
    }

    void addIntersection(String id, float x, float y, int floor) {
        Intersection intersection = new Intersection(id, x, y, floor); // Create a new intersection
        intersections.put(id, intersection); // Add the intersection to the map
        adjacencyList.put(id, new HashMap<>()); // Initialize the adjacency list for the intersection
    }

    void addStaircase(String id, float x, float y, int startFloor, int endFloor) {
        Staircase staircase = new Staircase(id, x, y, startFloor, endFloor); // Create a new staircase
        staircases.put(id, staircase); // Add the staircase to the map
        adjacencyList.put(id, new HashMap<>()); // Initialize the adjacency list for the staircase
    }

    void addEdge(String from, String to, int weight) {
        if (!adjacencyList.containsKey(from)) {
            adjacencyList.put(from, new HashMap<>()); // Initialize the adjacency list for the from node if not present
        }
        if (!adjacencyList.containsKey(to)) {
            adjacencyList.put(to, new HashMap<>()); // Initialize the adjacency list for the to node if not present
        }
        adjacencyList.get(from).put(to, weight); // Add the edge from the from node to the to node
        adjacencyList.get(to).put(from, weight); // Add the edge from the to node to the from node
    }

    HashMap<String, Node> getAllNodes() {
        HashMap<String, Node> allNodes = new HashMap<>(); // Map to store all nodes
        allNodes.putAll(rooms); // Add all rooms to the map
        allNodes.putAll(intersections); // Add all intersections to the map
        allNodes.putAll(staircases); // Add all staircases to the map
        return allNodes; // Return the map of all nodes
    }
}
