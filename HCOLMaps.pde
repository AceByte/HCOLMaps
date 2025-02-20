import controlP5.*;
import java.util.*;

Layout layout;
MapRenderer mapRenderer;
UIController uiController;
List<Node> path = new ArrayList<>();

void setup() {
    size(800, 600);
    layout = new Layout();
    mapRenderer = new MapRenderer(layout.getGraph());
    uiController = new UIController(this, layout.getGraph());

    // Default path calculation
    updatePath("A", "E");
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
