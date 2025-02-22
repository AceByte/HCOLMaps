class Room extends Node {
    int floor; // Floor number of the room

    Room(String name, float x, float y, int floor) {
        super(name, x, y); // Initialize the node with the name and coordinates
        this.floor = floor; // Initialize the floor number
    }
}