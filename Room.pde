class Room extends Node {
    int floor; // Etage nummer på rummet

    Room(String name, float x, float y, int floor) {
        super(name, x, y); // Initialiser noden med navnet og koordinaterne
        this.floor = floor; // Initialiser etage nummeret
    }
}