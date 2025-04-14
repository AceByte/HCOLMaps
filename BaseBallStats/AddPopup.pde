import controlP5.*;
import processing.core.*;

public class AddPopup extends PApplet {
    ControlP5 cp5;
    Game newGame;
    boolean isVisible = false;
    boolean isInitialized = false;
    boolean shouldClose = false;
    int popupWidth = 600;
    int popupHeight = 700;
    PFont labelFont, headerFont;
    DatabaseManager db;

    public AddPopup(DatabaseManager db) {
        this.db = db;
    }

    public void settings() {
        size(popupWidth, popupHeight);
    }

    public void setup() {
        surface.setResizable(false);
        surface.setLocation(150, 150);
        cp5 = new ControlP5(this);
        labelFont = createFont("Arial", 12);
        headerFont = createFont("Arial", 16);

        String[] labels = {"Date", "Team Score", "Opponent Score", "Opponent"};
        for (int i = 0; i < labels.length; i++) {
            cp5.addTextfield(labels[i])
                .setFont(labelFont)
                .setPosition(20, 50 + i * 60)
                .setSize(200, 30)
                .setAutoClear(false);
        }

        String[] battingLabels = {"At Bats", "Hits", "Home Runs", "Runs", "RBI", "Stolen Bases"};
        for (int i = 0; i < battingLabels.length; i++) {
            cp5.addTextfield(battingLabels[i])
                .setFont(labelFont)
                .setPosition(20, 320 + i * 60)
                .setSize(200, 30)
                .setAutoClear(false);
        }

        String[] pitchingLabels = {"Innings Pitched", "Strikeouts", "Hits Allowed", "Runs Allowed", "Walks Allowed", "Strikes", "Balls"};
        for (int i = 0; i < pitchingLabels.length; i++) {
            cp5.addTextfield(pitchingLabels[i])
                .setFont(labelFont)
                .setPosition(320, 50 + i * 60)
                .setSize(200, 30)
                .setAutoClear(false);
        }

        cp5.addButton("Close")
            .setFont(labelFont)
            .setPosition(460, popupHeight - 40)
            .setSize(100, 30)
            .onClick(e -> close());

        cp5.addButton("Save")
            .setFont(labelFont)
            .setPosition(350, popupHeight - 40)
            .setSize(100, 30)
            .onClick(e -> saveNewGame());

        isInitialized = true;
    }

    void open() {
        if (!isInitialized) {
            delay(50);
            open();
            return;
        }
        newGame = new Game("", "", "", "", new BattingStats(0, 0, 0, 0, 0, 0), new PitchingStats(0, 0, 0, 0, 0, 0, 0, 0));
        isVisible = true;
        surface.setVisible(true);
    }

    void close() {
        isVisible = false;
        newGame = null;
        shouldClose = true;
        surface.setVisible(false);
    }

    void saveNewGame() {
        if (newGame != null) {
            try {
                newGame.date = cp5.get(Textfield.class, "Date").getText();
                newGame.teamScore = cp5.get(Textfield.class, "Team Score").getText();
                newGame.opponentScore = cp5.get(Textfield.class, "Opponent Score").getText();
                newGame.opponent = cp5.get(Textfield.class, "Opponent").getText();

                newGame.battingStats.atBats = parseIntSafely(cp5.get(Textfield.class, "At Bats").getText());
                newGame.battingStats.hits = parseIntSafely(cp5.get(Textfield.class, "Hits").getText());
                newGame.battingStats.homeRuns = parseIntSafely(cp5.get(Textfield.class, "Home Runs").getText());
                newGame.battingStats.runs = parseIntSafely(cp5.get(Textfield.class, "Runs").getText());
                newGame.battingStats.runsBattedIn = parseIntSafely(cp5.get(Textfield.class, "RBI").getText());
                newGame.battingStats.stolenBases = parseIntSafely(cp5.get(Textfield.class, "Stolen Bases").getText());

                newGame.pitchingStats.inningsPitched = parseIntSafely(cp5.get(Textfield.class, "Innings Pitched").getText());
                newGame.pitchingStats.strikeouts = parseIntSafely(cp5.get(Textfield.class, "Strikeouts").getText());
                newGame.pitchingStats.hitsAllowed = parseIntSafely(cp5.get(Textfield.class, "Hits Allowed").getText());
                newGame.pitchingStats.runsAllowed = parseIntSafely(cp5.get(Textfield.class, "Runs Allowed").getText());
                newGame.pitchingStats.walksAllowed = parseIntSafely(cp5.get(Textfield.class, "Walks Allowed").getText());
                newGame.pitchingStats.strikes = parseIntSafely(cp5.get(Textfield.class, "Strikes").getText());
                newGame.pitchingStats.balls = parseIntSafely(cp5.get(Textfield.class, "Balls").getText());

                db.insertGame(newGame);

                println("Game saved successfully! with data: " + newGame);
                close();
            } catch (Exception e) {
                println("Error saving game: " + e.getMessage());
            }
        }
    }

    int parseIntSafely(String value) {
        try {
            return value.isEmpty() ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            println("Invalid number format: " + value);
            return 0;
        }
    }

    public void draw() {
        if (isVisible) {
            background(30);
            fill(255);
            textAlign(LEFT, TOP);
            textFont(headerFont);
            text("Add New Game Details", 70, 30);
            text("Pitching Stats", 350, 30);
            text("Batting Stats", 70, 300);
        }

        if (shouldClose) {
            isVisible = false;
            newGame = null;
            surface.setVisible(false);

            cp5.getAll().forEach(c -> c.remove());

            dispose();
            shouldClose = false;
        }
    }

    @Override
    public void dispose() {
        isVisible = false;
        newGame = null;
        super.dispose();
    }

    @Override
    public void exit() {
        dispose();
    }
}
