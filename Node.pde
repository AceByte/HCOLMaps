class Node {
    String id; // ID of the node
    float x, y; // Coordinates of the node

    Node(String id, float x, float y) {
        this.id = id; // Initialize the ID
        this.x = x; // Initialize the x-coordinate
        this.y = y; // Initialize the y-coordinate
    }

    @Override
    public String toString() {
        return id; // Return the ID as the string representation of the node
    }
}
