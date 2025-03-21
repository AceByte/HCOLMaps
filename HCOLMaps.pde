import controlP5.*; // Importer ControlP5-biblioteket til GUI-kontroller
import java.util.*; // Importer Java-værktøjer

Layout layout; // Layout-objekt til at administrere grafens layout
MapRenderer mapRenderer; // MapRenderer-objekt til at gengive grafen
UIController uiController; // UIController-objekt til at administrere UI
List<Node> path = new ArrayList<>(); // Liste til at gemme den korteste sti
ControlP5 cp5; // ControlP5-objekt til GUI-kontroller
int currentFloor = 1; // Variabel til at spore den aktuelle etage

void setup() {
    size(800, 600); // Sæt størrelsen på vinduet
    layout = new Layout(); // Initialiser layoutet
    mapRenderer = new MapRenderer(layout.getGraph()); // Initialiser map renderer med grafen
    uiController = new UIController(this, layout.getGraph()); // Initialiser UI controller med grafen
    cp5 = new ControlP5(this); // Initialiser ControlP5

    // Standard sti beregning
    updatePath("A", "CC"); // Beregn standardstien fra node A til node E
}

void draw() {
    background(20); // Sæt baggrundsfarven til hvid
    mapRenderer.render(path); // Gengiv kortet med den aktuelle sti
    uiController.render(); // Gengiv UI
}

void updatePath(String start, String end) {
    println("Beregner sti fra " + start + " til " + end); // Udskriv start- og slutnoderne
    Dijkstra dijkstra = new Dijkstra(layout.getGraph()); // Initialiser Dijkstra's algoritme med grafen
    path = dijkstra.findShortestPath(start, end); // Find den korteste sti
    println("Aktuel sti: " + path); // Udskriv den aktuelle sti
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