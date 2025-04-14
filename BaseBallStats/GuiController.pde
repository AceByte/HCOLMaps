import controlP5.*;

class Gui {
    ControlP5 cp5;
    GameListManager gameListManager;
    GamePopup gamePopup;
    EditPopup editPopup;
    PApplet p;
    PFont labelFont, headerFont;
    DatabaseManager db;

    Gui(PApplet p, DatabaseManager db) {
        this.p = p;
        this.db = db;
        cp5 = new ControlP5(p);

        labelFont = p.createFont("Arial", 12);
        headerFont = p.createFont("Arial", 16);

        gameListManager = new GameListManager(p, cp5, db, this);

        setupMainInterface();
    }

    void setupMainInterface() {
        cp5.addButton("AddNewGame")
           .setPosition(10, 10)
           .setSize(150, 30)
           .setFont(labelFont)
           .setCaptionLabel("Add New Game")
           .onClick(e -> openAddPopup());

        cp5.addButton("ViewTotalStats")
           .setPosition(170, 10)
           .setSize(150, 30)
           .setFont(labelFont)
           .setCaptionLabel("View Total Stats");
    }

    void display() {
        p.background(30);
        p.fill(255);
        cp5.draw();

        gameListManager.display();

        if (gamePopup != null && gamePopup.isVisible) {
            gamePopup.redraw();
        }
        if (editPopup != null && editPopup.isVisible) {
            editPopup.redraw();
        }

        checkAndRemoveClosedPopups();
    }

    void openGamePopup(Game game) {
        if (gamePopup == null || !gamePopup.isVisible) {
            gamePopup = new GamePopup(db);
            PApplet.runSketch(new String[]{"GamePopup"}, gamePopup);
            gamePopup.open(game);
        }
    }

    void openEditPopup(Game game) {
        if (editPopup == null || !editPopup.isVisible) {
            editPopup = new EditPopup(db);
            PApplet.runSketch(new String[]{"EditPopup"}, editPopup);
            editPopup.open(game);
        }
    }

    void openAddPopup() {
        AddPopup addPopup = new AddPopup(db);
        PApplet.runSketch(new String[]{"AddPopup"}, addPopup);
        addPopup.open();
    }

    void closePopups() {
        if (gamePopup != null) {
            gamePopup.close();
            gamePopup = null;
        }
        if (editPopup != null) {
            editPopup.close();
            editPopup = null;
        }
    }

    void checkAndRemoveClosedPopups() {
        if (gamePopup != null && !gamePopup.isVisible) {
            gamePopup = null;
        }
        if (editPopup != null && !editPopup.isVisible) {
            editPopup = null;
        }
    }
}
