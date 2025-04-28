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
PImage backgroundImage;

void setup() {
    size(1200, 800);
    layout = new Layout();
    mapRenderer = new MapRenderer(layout.getGraph(), this);
    uiController = new UIController(this, layout.getGraph());
    cp5 = new ControlP5(this);

    currentFloor = 1;
    mapRenderer.changeFloor(currentFloor);
    backgroundImage = loadImage("Floor_" + currentFloor + ".png");
    mouseReleased();
}

void draw() {
    background(20);

    if (backgroundImage != null) {
        image(backgroundImage, 0, 0, width, 540);
    }

    mapRenderer.render(path);
    uiController.render();
}

// updatePath() - Opdaterer stien baseret på de valgte start- og slutnoder
void updatePath(String start, String end) {
    if (!layout.getGraph().getAllNodes().containsKey(start)) {
        println("Fejl: Startnode '" + start + "' blev ikke fundet i grafen.");
        return;
    }
    if (!layout.getGraph().getAllNodes().containsKey(end)) {
        println("Fejl: Slutnode '" + end + "' blev ikke fundet i grafen.");
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

// changeFloor() - Skift etage
void changeFloor(int floor) {
    int minFloor = layout.getGraph().getMinFloor();
    int maxFloor = layout.getGraph().getMaxFloor();
    if (floor >= minFloor && floor <= maxFloor) {
        currentFloor = floor;
        mapRenderer.changeFloor(floor);
        backgroundImage = loadImage("Floor_" + floor + ".png");
        println("Aktuel etage: " + currentFloor);
    }
}