class Intersection extends Node {
    int floor; // Etagenummer for krydset

    Intersection(String name, float x, float y, int floor) {
        super(name, x, y); // Initialiser noden med navn og koordinater
        this.floor = floor; // Initialiser etagenummeret
    }
}