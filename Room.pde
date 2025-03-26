class Room extends Node {
    int floor;

    Room(String name, float x, float y, int floor) {
        super(name, x, y);
        this.floor = floor;
    }
}