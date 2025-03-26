import controlP5.*; // Importer ControlP5-biblioteket til GUI-kontroller
import java.util.*; // Importer Java-værktøjer

Layout layout; // Layout-objekt til at administrere grafens layout
MapRenderer mapRenderer; // MapRenderer-objekt til at gengive grafen
UIController uiController; // UIController-objekt til at administrere UI
DashedLines dash;
List<Node> path = new ArrayList<>(); // Liste til at gemme den korteste sti
ControlP5 cp5; // ControlP5-objekt til GUI-kontroller
int currentFloor = 1; // Variabel til at spore den aktuelle etage

void setup() {
    size(800, 600); // Sæt størrelsen på vinduet
    layout = new Layout(); // Initialiser layoutet
    mapRenderer = new MapRenderer(layout.getGraph(), this); // Initialiser map renderer med grafen
    uiController = new UIController(this, layout.getGraph()); // Initialiser UI controller med grafen
    cp5 = new ControlP5(this); // Initialiser ControlP5
}

void draw() {
    background(20); // Sæt baggrundsfarven til hvid
    mapRenderer.render(path); // Gengiv kortet med den aktuelle sti
    uiController.render(); // Gengiv UI
}

void updatePath(String start, String end) {
    // Check if the start and end nodes exist in the graph
    if (!layout.getGraph().getAllNodes().containsKey(start)) {
        println("Fejl: Startnoden '" + start + "' findes ikke i grafen.");
        return;
    }
    if (!layout.getGraph().getAllNodes().containsKey(end)) {
        println("Fejl: Slutnoden '" + end + "' findes ikke i grafen.");
        return;
    }

    println("Beregner sti fra " + start + " til " + end); // Udskriv start- og slutnoderne
    Dijkstra dijkstra = new Dijkstra(layout.getGraph()); // Initialiser Dijkstra's algoritme med grafen
    path = dijkstra.findShortestPath(start, end); // Find den korteste sti

    if (path == null || path.isEmpty()) {
        println("Fejl: Ingen sti fundet mellem '" + start + "' og '" + end + "'.");
    } else {
        println("Aktuel sti: " + path); // Udskriv den aktuelle sti
    }
}

void changeFloor(int floor) {
    int minFloor = layout.getGraph().getMinFloor();
    int maxFloor = layout.getGraph().getMaxFloor();
    if (floor >= minFloor && floor <= maxFloor) { // Tjek om etagen er inden for det gyldige område
        currentFloor = floor; // Opdater den aktuelle etage
        mapRenderer.changeFloor(floor); // Skift etagen i map renderer
        println("Aktuel etage: " + currentFloor); // Udskriv den aktuelle etage
    }
}