import controlP5.*;
import java.util.*;

// Global variables
Layout layout;
MapRenderer mapRenderer;
UIController uiController;
DashedLines dash;
List<Node> path = new ArrayList<>();
ControlP5 cp5;
int currentFloor = 1;
// Removed ImagePopup reference
PImage backgroundImage; // Declare a variable for the image

// setup() - Initialize the program
void setup() {
    size(1200, 800);
    layout = new Layout();
    mapRenderer = new MapRenderer(layout.getGraph(), this);
    uiController = new UIController(this, layout.getGraph());
    cp5 = new ControlP5(this);

    currentFloor = 1;
    mapRenderer.changeFloor(currentFloor);
    backgroundImage = loadImage("Floor_" + currentFloor + ".png"); // Load the image for floor 3
    mouseReleased();
}

// draw() - Draw the graph and user interface
void draw() {
    background(20);

    // Display the image
    if (backgroundImage != null) {
        image(backgroundImage, 0, 0, width, 540); // Adjust position and size as needed
    }

    mapRenderer.render(path);
    uiController.render();
}

// updatePath() - Update the shortest path between two nodes
void updatePath(String start, String end) {
    if (!layout.getGraph().getAllNodes().containsKey(start)) {
        println("Error: Start node '" + start + "' not found in the graph.");
        return;
    }
    if (!layout.getGraph().getAllNodes().containsKey(end)) {
        println("Error: End node '" + end + "' not found in the graph.");
        return;
    }

    println("Calculating path from " + start + " to " + end);
    Dijkstra dijkstra = new Dijkstra(layout.getGraph());
    path = dijkstra.findShortestPath(start, end);

    if (path == null || path.isEmpty()) {
        println("Error: No path found between '" + start + "' and '" + end + "'.");
    } else {
        println("Current path: " + path);
    }
}

// changeFloor() - Switch to a different floor
void changeFloor(int floor) {
    int minFloor = layout.getGraph().getMinFloor();
    int maxFloor = layout.getGraph().getMaxFloor();
    if (floor >= minFloor && floor <= maxFloor) {
        currentFloor = floor;
        mapRenderer.changeFloor(floor);
        backgroundImage = loadImage("Floor_" + floor + ".png"); // Load the corresponding floor image
        println("Current floor: " + currentFloor);
    }
}

// Removed openImagePopup() method

void mouseReleased() {
    println("x: " + mouseX + ", y: " + mouseY); // Corrected concatenation
}