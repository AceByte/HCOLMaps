import controlP5.*; // Import ControlP5 library for GUI controls
import java.util.*; // Import Java utilities

Layout layout; // Layout object to manage the graph layout
MapRenderer mapRenderer; // MapRenderer object to render the graph
UIController uiController; // UIController object to manage the UI
List<Node> path = new ArrayList<>(); // List to store the shortest path
ControlP5 cp5; // ControlP5 object for GUI controls
int currentFloor = 1; // Variable to track the current floor

void setup() {
    size(800, 600); // Set the size of the window
    layout = new Layout(); // Initialize the layout
    mapRenderer = new MapRenderer(layout.getGraph()); // Initialize the map renderer with the graph
    uiController = new UIController(this, layout.getGraph()); // Initialize the UI controller with the graph
    cp5 = new ControlP5(this); // Initialize ControlP5

    // Default path calculation
    updatePath("A", "E"); // Calculate the default path from node A to node E

    // Add buttons for changing floors
    cp5.addButton("floorUp")
       .setLabel("Up") // Label for the button
       .setPosition(700, 50) // Position of the button
       .setSize(50, 30) // Size of the button
       .onClick(event -> changeFloor(currentFloor + 1)); // Action to perform on click

    cp5.addButton("floorDown")
       .setLabel("Down") // Label for the button
       .setPosition(700, 100) // Position of the button
       .setSize(50, 30) // Size of the button
       .onClick(event -> changeFloor(currentFloor - 1)); // Action to perform on click
}

void draw() {
    background(20); // Set the background color to white
    mapRenderer.render(path); // Render the map with the current path
    uiController.render(); // Render the UI
}

void updatePath(String start, String end) {
    println("Calculating path from " + start + " to " + end); // Print the start and end nodes
    Dijkstra dijkstra = new Dijkstra(layout.getGraph()); // Initialize Dijkstra's algorithm with the graph
    path = dijkstra.findShortestPath(start, end); // Find the shortest path
    println("Current path: " + path); // Print the current path
}

void changeFloor(int floor) {
    if (floor >= 1 && floor <= 3) { // Check if the floor is within the valid range
        currentFloor = floor; // Update the current floor
        mapRenderer.changeFloor(floor); // Change the floor in the map renderer
        println("Current floor: " + currentFloor); // Print the current floor
    }
}