import controlP5.*;
import java.util.*;

// Globale variabler
Layout layout; // Layout-objekt til at administrere grafens layout
MapRenderer mapRenderer; // MapRenderer-objekt til at gengive grafen
UIController uiController; // UIController-objekt til at administrere brugergrænsefladen
DashedLines dash; // Objekt til at tegne stiplede linjer
List<Node> path = new ArrayList<>(); // Liste til at gemme den korteste sti
ControlP5 cp5; // ControlP5-objekt til GUI-kontroller
int currentFloor = 1; // Variabel til at spore den aktuelle etage

// setup() - Initialiserer programmet
void setup() {
    size(800, 600);
    layout = new Layout(); // Initialiser layoutet, som indlæser grafen fra JSON
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
    // Tjek om start- og slutnoderne findes i grafen
    if (!layout.getGraph().getAllNodes().containsKey(start)) {
        println("Fejl: Startnoden '" + start + "' findes ikke i grafen."); // Fejlmeddelelse
        return;
    }
    if (!layout.getGraph().getAllNodes().containsKey(end)) {
        println("Fejl: Slutnoden '" + end + "' findes ikke i grafen."); // Fejlmeddelelse
        return;
    }

    println("Beregner sti fra " + start + " til " + end);
    Dijkstra dijkstra = new Dijkstra(layout.getGraph());
    path = dijkstra.findShortestPath(start, end);

    // Tjek om en sti blev fundet
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
    if (floor >= minFloor && floor <= maxFloor) { // Tjek om den ønskede etage er gyldig
        currentFloor = floor;
        mapRenderer.changeFloor(floor);
        println("Aktuel etage: " + currentFloor);
    }
}