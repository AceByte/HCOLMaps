class Hallway {
    String start, end;
    float weight;

    Hallway(String start, String end, HashMap<String, Node> allNodes) {
        this.start = start;
        this.end = end;

        // Beregn vægten dynamisk baseret på pixeldistancen
        Node nodeA = allNodes.get(start);
        Node nodeB = allNodes.get(end);
        if (nodeA != null && nodeB != null) {
            this.weight = dist(nodeA.x, nodeA.y, nodeB.x, nodeB.y);
        } else {
            this.weight = 0; 
        }
    }
}