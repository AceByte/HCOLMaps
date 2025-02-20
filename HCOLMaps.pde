import controlP5.*;
import java.util.*;

Layout layout;
MapRenderer mapRenderer;
UIController uiController;
List<Node> path = new ArrayList<>();
ControlP5 cp5;
int currentFloor = 1;

void setup() {
    size(800, 600);
    layout = new Layout();
    mapRenderer = new MapRenderer(layout.getGraph());
    uiController = new UIController(this, layout.getGraph());
    cp5 = new ControlP5(this);

    // Default path calculation
    updatePath("A", "E");

    // Add buttons for changing floors
    cp5.addButton("floorUp")
       .setLabel("Up")
       .setPosition(700, 50)
       .setSize(50, 30)
       .onClick(event -> changeFloor(currentFloor + 1));

    cp5.addButton("floorDown")
       .setLabel("Down")
       .setPosition(700, 100)
       .setSize(50, 30)
       .onClick(event -> changeFloor(currentFloor - 1));
}

void draw() {
    background(255);
    mapRenderer.render(path);
    uiController.render();
}

void updatePath(String start, String end) {
    Dijkstra dijkstra = new Dijkstra(layout.getGraph());
    path = dijkstra.findShortestPath(start, end);
    println("Current path: " + path);
}

void changeFloor(int floor) {
    if (floor >= 1 && floor <= 2) { // Assuming there are only 2 floors
        currentFloor = floor;
        mapRenderer.changeFloor(floor);
        println("Current floor: " + currentFloor);
    }
}