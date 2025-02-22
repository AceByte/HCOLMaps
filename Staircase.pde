// Define the Staircase class that extends the Node class
class Staircase extends Node {
    int startFloor, endFloor; // Variables to store the start and end floors of the staircase

    // Constructor for the Staircase class
    Staircase(String id, float x, float y, int startFloor, int endFloor) {
        super(id, x, y); // Call the constructor of the superclass Node
        this.startFloor = startFloor; // Initialize the start floor
        this.endFloor = endFloor; // Initialize the end floor
    }
}