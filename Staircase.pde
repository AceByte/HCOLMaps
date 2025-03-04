// Definer Staircase-klassen, der udvider Node-klassen
class Staircase extends Node {
    int startFloor, endFloor; // Variabler til at gemme start- og slutetagerne for trappen

    // Konstruktor for Staircase-klassen
    Staircase(String id, float x, float y, int startFloor, int endFloor) {
        super(id, x, y); // Kald konstruktøren af superklassen Node
        this.startFloor = startFloor; // Initialiser startetagen
        this.endFloor = endFloor; // Initialiser slutetagen
    }
}