class Room extends Node {
    int floor; // Etage nummer på rummet
    String category; // Kategori for rummet

    Room(String name, float x, float y, int floor, String category) {
        super(name, x, y); // Initialiser noden med navnet og koordinaterne
        this.floor = floor; // Initialiser etage nummeret
        this.category = category; // Initialiser kategorien
    }
}