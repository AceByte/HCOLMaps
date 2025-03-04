class Node {
    String id; // ID for noden
    float x, y; // Koordinater for noden

    Node(String id, float x, float y) {
        this.id = id; // Initialiser ID'et
        this.x = x; // Initialiser x-koordinaten
        this.y = y; // Initialiser y-koordinaten
    }

    @Override
    public String toString() {
        return id; // Returner ID'et som den tekstlige repræsentation af noden
    }
}