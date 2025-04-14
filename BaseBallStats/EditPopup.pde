import controlP5.*;
import processing.core.*;

public class EditPopup extends PApplet {
    ControlP5 cp5;
    Game selectedGame;
    boolean isVisible = false;
    boolean isInitialized = false;
    boolean shouldClose = false;
    int popupWidth = 600;
    int popupHeight = 700;
    PFont labelFont, headerFont;
    DatabaseManager db;

    public EditPopup(DatabaseManager db) {
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
                .setAutoClear(false)
                .hide();
        }

        String[] battingLabels = {"At Bats", "Hits", "Home Runs", "Runs", "RBI", "Stolen Bases"};
        for (int i = 0; i < battingLabels.length; i++) {
            cp5.addTextfield(battingLabels[i])
                .setFont(labelFont)
                .setPosition(20, 320 + i * 60)
                .setSize(200, 30)
                .setAutoClear(false)
                .hide();
        }

        String[] pitchingLabels = {"Innings Pitched", "Strikeouts", "Hits Allowed", "Runs Allowed", "Walks Allowed", "Strikes", "Balls"};
        for (int i = 0; i < pitchingLabels.length; i++) {
            cp5.addTextfield(pitchingLabels[i])
                .setFont(labelFont)
                .setPosition(320, 50 + i * 60)
                .setSize(200, 30)
                .setAutoClear(false)
                .hide();
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
            .onClick(e -> saveChanges());

        isInitialized = true;
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

        if (cp5 != null) {
            cp5.get(Textfield.class, "Date").setText(selectedGame.date).show();
            cp5.get(Textfield.class, "Team Score").setText(selectedGame.teamScore).show();
            cp5.get(Textfield.class, "Opponent Score").setText(selectedGame.opponentScore).show();
            cp5.get(Textfield.class, "Opponent").setText(selectedGame.opponent).show();

            cp5.get(Textfield.class, "At Bats").setText(String.valueOf(selectedGame.battingStats.atBats)).show();
            cp5.get(Textfield.class, "Hits").setText(String.valueOf(selectedGame.battingStats.hits)).show();
            cp5.get(Textfield.class, "Home Runs").setText(String.valueOf(selectedGame.battingStats.homeRuns)).show();
            cp5.get(Textfield.class, "Runs").setText(String.valueOf(selectedGame.battingStats.runs)).show();
            cp5.get(Textfield.class, "RBI").setText(String.valueOf(selectedGame.battingStats.runsBattedIn)).show();
            cp5.get(Textfield.class, "Stolen Bases").setText(String.valueOf(selectedGame.battingStats.stolenBases)).show();

            cp5.get(Textfield.class, "Innings Pitched").setText(String.valueOf(selectedGame.pitchingStats.inningsPitched)).show();
            cp5.get(Textfield.class, "Strikeouts").setText(String.valueOf(selectedGame.pitchingStats.strikeouts)).show();
            cp5.get(Textfield.class, "Hits Allowed").setText(String.valueOf(selectedGame.pitchingStats.hitsAllowed)).show();
            cp5.get(Textfield.class, "Runs Allowed").setText(String.valueOf(selectedGame.pitchingStats.runsAllowed)).show();
            cp5.get(Textfield.class, "Walks Allowed").setText(String.valueOf(selectedGame.pitchingStats.walksAllowed)).show();
            cp5.get(Textfield.class, "Strikes").setText(String.valueOf(selectedGame.pitchingStats.strikes)).show();
            cp5.get(Textfield.class, "Balls").setText(String.valueOf(selectedGame.pitchingStats.balls)).show();
        }
    }

    void close() {
        isVisible = false;
        selectedGame = null;
        shouldClose = true;
        surface.setVisible(false);
    }

    void saveChanges() {
        if (selectedGame != null) {
            selectedGame.date = cp5.get(Textfield.class, "Date").getText();
            selectedGame.teamScore = cp5.get(Textfield.class, "Team Score").getText();
            selectedGame.opponentScore = cp5.get(Textfield.class, "Opponent Score").getText();
            selectedGame.opponent = cp5.get(Textfield.class, "Opponent").getText();

            selectedGame.battingStats.atBats = Integer.parseInt(cp5.get(Textfield.class, "At Bats").getText());
            selectedGame.battingStats.hits = Integer.parseInt(cp5.get(Textfield.class, "Hits").getText());
            selectedGame.battingStats.homeRuns = Integer.parseInt(cp5.get(Textfield.class, "Home Runs").getText());
            selectedGame.battingStats.runs = Integer.parseInt(cp5.get(Textfield.class, "Runs").getText());
            selectedGame.battingStats.runsBattedIn = Integer.parseInt(cp5.get(Textfield.class, "RBI").getText());
            selectedGame.battingStats.stolenBases = Integer.parseInt(cp5.get(Textfield.class, "Stolen Bases").getText());

            selectedGame.pitchingStats.inningsPitched = Integer.parseInt(cp5.get(Textfield.class, "Innings Pitched").getText());
            selectedGame.pitchingStats.strikeouts = Integer.parseInt(cp5.get(Textfield.class, "Strikeouts").getText());
            selectedGame.pitchingStats.hitsAllowed = Integer.parseInt(cp5.get(Textfield.class, "Hits Allowed").getText());
            selectedGame.pitchingStats.runsAllowed = Integer.parseInt(cp5.get(Textfield.class, "Runs Allowed").getText());
            selectedGame.pitchingStats.walksAllowed = Integer.parseInt(cp5.get(Textfield.class, "Walks Allowed").getText());
            selectedGame.pitchingStats.strikes = Integer.parseInt(cp5.get(Textfield.class, "Strikes").getText());
            selectedGame.pitchingStats.balls = Integer.parseInt(cp5.get(Textfield.class, "Balls").getText());

            db.updateGame(selectedGame.getId(), selectedGame);

            close();
        }
    }

    public void draw() {
        if (isVisible) {
            background(30);
            fill(255);
            textAlign(LEFT, TOP);
            textFont(headerFont);
            text("Edit Game Details", 70, 30);
            text("Pitching Stats", 350, 30);
            text("Batting Stats", 70, 300);
        }

        if (shouldClose) {
            isVisible = false;
            selectedGame = null;
            surface.setVisible(false);

            // Remove all controllers
            cp5.getAll().forEach(c -> c.remove());

            dispose();
            shouldClose = false;
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
