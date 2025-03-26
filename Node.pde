class Node {
    String id;
    float x, y;

    Node(String id, float x, float y) {
        this.id = id;
        this.x = x;
        this.y = y;
    }

    @Override
    public String toString() {
        return id;
    }
}