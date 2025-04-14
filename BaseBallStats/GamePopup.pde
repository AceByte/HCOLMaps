import controlP5.*;

public class GamePopup extends PApplet {
    ControlP5 cp5;
    Game selectedGame;
    boolean isVisible = false;
    boolean isInitialized = false;
    int popupWidth = 600;
    int popupHeight = 700;
    PFont labelFont, headerFont;
    DatabaseManager db;

    public GamePopup(DatabaseManager db) {
        this.db = db;
    }

    public void settings() {
        size(popupWidth, popupHeight);
    }

    public void setup() {
        surface.setResizable(false);
        surface.setLocation(100, 100);
        cp5 = new ControlP5(this);
        isInitialized = true;
        labelFont = createFont("Arial", 12);
        headerFont = createFont("Arial", 16);

        cp5.addButton("Close Game Popup")
            .setFont(labelFont)
            .setPosition(popupWidth - 250, popupHeight - 40)
            .setSize(200, 30)
            .onClick(e -> close());

        cp5.addButton("Delete Game")
            .setFont(labelFont)
            .setPosition(popupWidth - 250, popupHeight - 80)
            .setSize(200, 30)
            .onClick(e -> deleteGame());

        cp5.addButton("Save Changes")
            .setFont(labelFont)
            .setPosition(popupWidth - 250, popupHeight - 120)
            .setSize(200, 30)
            .onClick(e -> saveGameChanges());
    }

    void open(Game game) {
        if (!isInitialized) {
            delay(50);
            open(game);
            return;
        }
        selectedGame = game;
        isVisible = true;
        surface.setVisible(true);
    }

    public void draw() {
        if (isVisible && selectedGame != null) {
            background(30);

            fill(255);
            textFont(headerFont);
            textAlign(LEFT, TOP);
            text("Game Details", 70, 120);

            fill(255);
            textFont(labelFont);
            textAlign(LEFT, TOP);
            textSize(14);
            text("Date: " + selectedGame.date, 70, 160);
            text("Score: " + selectedGame.teamScore + " - " + selectedGame.opponentScore, 70, 180);
            text("Opponent: " + selectedGame.opponent, 70, 200);

            text("Batting Stats:", 70, 240);
            text("At Bats: " + selectedGame.battingStats.atBats, 90, 260);
            text("Hits: " + selectedGame.battingStats.hits, 90, 280);
            text("Home Runs: " + selectedGame.battingStats.homeRuns, 90, 300);
            text("Runs: " + selectedGame.battingStats.runs, 90, 320);
            text("RBI: " + selectedGame.battingStats.runsBattedIn, 90, 340);
            text("Stolen Bases: " + selectedGame.battingStats.stolenBases, 90, 360);

            text("Pitching Stats:", 70, 400);
            text("Innings Pitched: " + selectedGame.pitchingStats.inningsPitched, 90, 420);
            text("Strikeouts: " + selectedGame.pitchingStats.strikeouts, 90, 440);
            text("Hits Allowed: " + selectedGame.pitchingStats.hitsAllowed, 90, 460);
            text("Runs Allowed: " + selectedGame.pitchingStats.runsAllowed, 90, 480);
            text("Walks Allowed: " + selectedGame.pitchingStats.walksAllowed, 90, 500);
            text("Strikes: " + selectedGame.pitchingStats.strikes, 90, 520);
            text("Balls: " + selectedGame.pitchingStats.balls, 90, 540);
        }
    }

    void close() {
        isVisible = false;
        selectedGame = null;
        surface.setVisible(false);
        dispose();
    }

    void deleteGame() {
        if (selectedGame != null) {
            db.deleteGame(selectedGame.getId());
            close();
        }
    }

    void saveGameChanges() {
        if (selectedGame != null) {
            db.updateGame(selectedGame.getId(), selectedGame);
            close();
        }
    }

    @Override
    public void dispose() {
        isVisible = false;
        selectedGame = null;
        super.dispose();
    }

    @Override
    public void exit() {
        dispose();
    }
}
