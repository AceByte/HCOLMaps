class Hallway {
    String start, end; // Start- og slutnoder for gangen
    float weight; // Vægt (afstand) af gangen

    Hallway(String start, String end, float weight) {
        this.start = start; // Initialiser startnoden
        this.end = end; // Initialiser slutnoden
        this.weight = weight; // Initialiser vægten
    }
}