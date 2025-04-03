import controlP5.*;
import java.util.*;

// Globale variabler
Layout layout;
MapRenderer mapRenderer;
UIController uiController;
DashedLines dash;
List<Node> path = new ArrayList<>();
ControlP5 cp5;
int currentFloor = 1;

// setup() - Initialiserer programmet
void setup() {
    size(800, 600);
    layout = new Layout();
    mapRenderer = new MapRenderer(layout.getGraph(), this);
    uiController = new UIController(this, layout.getGraph());
    cp5 = new ControlP5(this);
}

// draw() - Tegner grafen og brugergrænsefladen
void draw() {
    background(20);
    mapRenderer.render(path);
    uiController.render();
}

// updatePath() - Opdaterer den korteste sti mellem to noder
void updatePath(String start, String end) {
    if (!layout.getGraph().getAllNodes().containsKey(start)) {
        println("Fejl: Startnoden '" + start + "' findes ikke i grafen.");
        return;
    }
    if (!layout.getGraph().getAllNodes().containsKey(end)) {
        println("Fejl: Slutnoden '" + end + "' findes ikke i grafen.");
        return;
    }

    println("Beregner sti fra " + start + " til " + end);
    Dijkstra dijkstra = new Dijkstra(layout.getGraph());
    path = dijkstra.findShortestPath(start, end);

    if (path == null || path.isEmpty()) {
        println("Fejl: Ingen sti fundet mellem '" + start + "' og '" + end + "'.");
    } else {
        println("Aktuel sti: " + path);
    }
}

// changeFloor() - Skifter til en anden etage
void changeFloor(int floor) {
    int minFloor = layout.getGraph().getMinFloor();
    int maxFloor = layout.getGraph().getMaxFloor();
    if (floor >= minFloor && floor <= maxFloor) {
        currentFloor = floor;
        mapRenderer.changeFloor(floor);
        println("Aktuel etage: " + currentFloor);
    }
}