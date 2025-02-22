class Intersection extends Node {
    int floor; // Floor number of the intersection

    Intersection(String name, float x, float y, int floor) {
        super(name, x, y); // Initialize the node with the name and coordinates
        this.floor = floor; // Initialize the floor number
    }
}