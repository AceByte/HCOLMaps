import controlP5.*;
import java.util.ArrayList;

class GameListManager {
    PApplet p;
    ControlP5 cp5;
    DatabaseManager db;
    Gui gui;
    ArrayList<Game> games;
    PFont labelFont;

    GameListManager(PApplet p, ControlP5 cp5, DatabaseManager db, Gui gui) {
        this.p = p;
        this.cp5 = cp5;
        this.db = db;
        this.gui = gui;
        games = new ArrayList<>();

        labelFont = p.createFont("Arial", 12);

        // Load games from database
        loadGamesFromDatabase();
        println("Loaded " + games.size() + " games from database.");
        refreshGameList();  // Refresh game list after loading
    }

    void loadGamesFromDatabase() {
        games.clear();
        ArrayList<Game> loadedGames = db.getAllGames();
        games.addAll(loadedGames);
        println("Loaded " + loadedGames.size() + " games.");  // Debug print
    }

    void refreshGameList() {
        cp5.getAll().forEach(controller -> {
            if (controller.getName().startsWith("Game") ||
                controller.getName().startsWith("EditGame") ||
                controller.getName().startsWith("DeleteGame")) {
                cp5.remove(controller.getName());
            }
        });

        println("Refreshing game list with " + games.size() + " games.");

        int yOffset = 50;
        for (int i = 0; i < games.size(); i++) {
            final Game game = games.get(i);
            final int index = i;

            println("Creating buttons for game: " + game.getSummary());  // Debug print

            cp5.addButton("Game" + i)
            .setPosition(10, yOffset)
            .setSize(300, 30)
            .setFont(labelFont)
            .setCaptionLabel(game.getSummary())
            .onClick(e -> gui.openGamePopup(game));

            cp5.addButton("EditGame" + i)
            .setPosition(320, yOffset)
            .setSize(70, 30)
            .setFont(labelFont)
            .setCaptionLabel("Edit")
            .onClick(e -> gui.openEditPopup(game));

            cp5.addButton("DeleteGame" + i)
            .setPosition(400, yOffset)
            .setSize(70, 30)
            .setFont(labelFont)
            .setCaptionLabel("Delete")
            .onClick(e -> {
                db.deleteGame(game.getId());
                games.remove(index);
                refreshGameList();
            });

            yOffset += 40;
        }

        println("Refreshed game list with " + games.size() + " games.");
    }

    void display() {
        // If any additional display logic is needed, add it here
    }
}
