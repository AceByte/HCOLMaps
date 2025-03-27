import processing.data.JSONObject;
import processing.data.JSONArray;

class Graph {
    HashMap<String, Room> rooms = new HashMap<>();
    HashMap<String, Intersection> intersections = new HashMap<>();
    HashMap<String, Staircase> staircases = new HashMap<>();
    HashMap<String, HashMap<String, Integer>> adjacencyList = new HashMap<>();

    void loadFromJson(String filePath) {
        JSONObject data = loadJSONObject(filePath); // Indlæs JSON-fil
        JSONArray nodes = data.getJSONArray("nodes");
        JSONArray edges = data.getJSONArray("edges");

        // Indlæs noder
        for (int i = 0; i < nodes.size(); i++) {
            JSONObject node = nodes.getJSONObject(i);
            String type = node.getString("type");
            String id = node.getString("id");
            float x = node.getFloat("x");
            float y = node.getFloat("y");

            if (type.equals("Room")) {
                int floor = node.getInt("floor");
                addRoom(id, x, y, floor);
            } else if (type.equals("Intersection")) {
                int floor = node.getInt("floor");
                addIntersection(id, x, y, floor);
            } else if (type.equals("Staircase")) {
                int startFloor = node.getInt("startFloor");
                int endFloor = node.getInt("endFloor");
                addStaircase(id, x, y, startFloor, endFloor);
            }
        }

        // Indlæs kanter
        for (int i = 0; i < edges.size(); i++) {
            JSONObject edge = edges.getJSONObject(i);
            String from = edge.getString("from");
            String to = edge.getString("to");
            addEdge(from, to); // Ignorer eventuelle foruddefinerede vægte
        }
    }

    void addRoom(String id, float x, float y, int floor) {
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

    void addEdge(String from, String to) {
        Node nodeA = getAllNodes().get(from);
        Node nodeB = getAllNodes().get(to);

        if (nodeA == null || nodeB == null) {
            println("Error: One or both nodes not found for edge: " + from + " -> " + to);
            return;
        }

        // Beregn vægt baseret på pixeldistancen mellem noderne
        int weight = (int) dist(nodeA.x, nodeA.y, nodeB.x, nodeB.y);

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
        HashMap<String, Node> allNodes = new HashMap<>(); // Kort til at gemme alle noder
        allNodes.putAll(rooms); // Tilføj alle værelser til kortet
        allNodes.putAll(intersections); // Tilføj alle kryds til kortet
        allNodes.putAll(staircases); // Tilføj alle trapper til kortet
        return allNodes; // Returner kortet over alle noder
    }

    // Minimum og maksimum etage
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