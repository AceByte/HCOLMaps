class Staircase extends Node {
    int startFloor, endFloor;

    Staircase(String id, float x, float y, int startFloor, int endFloor) {
        super(id, x, y);
        this.startFloor = startFloor;
        this.endFloor = endFloor;
    }
}