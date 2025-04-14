import controlP5.*;
Gui gui;
DatabaseManager db;

void setup() {
    size(600, 800);
    db = new DatabaseManager(this, "baseball.db");
    gui = new Gui(this, db);
}

void draw() {
    gui.display();
}

void keyPressed() {
    if (key == 's') {
        println("Reloading games from the database...");
        gui.gameListManager.loadGamesFromDatabase();  // Reload games into the manager
        gui.gameListManager.refreshGameList();  // Refresh the game list
    }
}


