import java.util.*; // Importer Java-værktøjer

class UIController {
    ControlP5 cp5; // ControlP5-objekt til GUI-kontroller
    Graph graph; // Graph-objekt til at administrere noder og kanter
    HCOLMaps parent; // Reference til hovedskitsen
    String startNode = ""; // Startnode
    String endNode = ""; // Slutnode

    UIController(HCOLMaps parent, Graph graph) {
        this.parent = parent; // Gem reference til hovedskitsen
        this.graph = graph; // Gem reference til grafen
        cp5 = new ControlP5(parent); // Initialiser ControlP5

        // Debug: Print sorted room IDs
        String[] roomIds = getRoomIds();

        // Dropdown til at vælge startnode
        cp5.addDropdownList("startNodeDropdown")
           .setPosition(40, parent.height - 200) // Position for dropdown
           .setSize(200, 200) // Størrelse for dropdown (bredde og højde på den synlige del)
           .setBarHeight(30) // Højde på dropdownens bar (når den er lukket)
           .setItemHeight(25) // Højde på hver enkelt item i dropdownen
           .setOpen(false) // Sørg for at dropdown starter som lukket
           .setLabel("Vælg Start") // Etiket for dropdown
           .setColorBackground(color(50)) // Baggrundsfarve (lys grå)
           .setColorActive(color(150)) // Aktiv farve (mørkere grå)
           .setColorForeground(color(180)) // Forgrundsfarve (mellem grå)
           .addItems(roomIds) // Tilføj kun rum som valgmuligheder
           .onChange(event -> {
               int selectedIndex = (int) event.getController().getValue();
               if (selectedIndex >= 0 && selectedIndex < roomIds.length) {
                   startNode = roomIds[selectedIndex];
                   event.getController().setCaptionLabel(startNode); // Update the dropdown caption
                   println("Startnode valgt: " + startNode);
                   updatePath();
               } else {
                   println("Invalid index selected: " + selectedIndex);
               }
           });

        // Dropdown til at vælge slutnode
        cp5.addDropdownList("endNodeDropdown")
           .setPosition(260, parent.height - 200) // Position for dropdown
           .setSize(200, 300) // Størrelse for dropdown (bredde og højde på den synlige del)
           .setBarHeight(30) // Højde på dropdownens bar (når den er lukket)
           .setItemHeight(25) // Højde på hver enkelt item i dropdownen
           .setOpen(false) // Sørg for at dropdown starter som lukket
           .setLabel("Vælg Slut") // Etiket for dropdown
           .setColorBackground(color(50)) // Baggrundsfarve (lys grå)
           .setColorActive(color(150)) // Aktiv farve (mørkere grå)
           .setColorForeground(color(180)) // Forgrundsfarve (mellem grå)
           .addItems(roomIds) // Tilføj kun rum som valgmuligheder
           .onChange(event -> {
               int selectedIndex = (int) event.getController().getValue();
               if (selectedIndex >= 0 && selectedIndex < roomIds.length) {
                   endNode = roomIds[selectedIndex];
                   event.getController().setCaptionLabel(endNode); // Update the dropdown caption
                   println("Slutnode valgt: " + endNode);
                   updatePath();
               } else {
                   println("Invalid index selected: " + selectedIndex);
               }
           });

        // Tilføj knapper til at skifte etager
        cp5.addButton("floorUp")
           .setLabel("Op") // Etiket for knappen
           .setPosition(700, 50) // Position af knappen
           .setSize(50, 30) // Størrelse af knappen
           .setColorBackground(color(50)) // Baggrundsfarve (lys grå)
           .setColorActive(color(150)) // Aktiv farve (mørkere grå)
           .setColorForeground(color(180)) // Forgrundsfarve (mellem grå)
           .onClick(event -> {
               parent.changeFloor(parent.currentFloor + 1); // Handling ved klik
               updateFloorLabel(); // Opdater etiket for etage
               updateFloorButtons(); // Opdater knapperne for etageskift
           });

        cp5.addButton("floorDown")
           .setLabel("Ned") // Etiket for knappen
           .setPosition(700, 100) // Position af knappen
           .setSize(50, 30) // Størrelse af knappen
           .setColorBackground(color(50)) // Baggrundsfarve (lys grå)
           .setColorActive(color(150)) // Aktiv farve (mørkere grå)
           .setColorForeground(color(180)) // Forgrundsfarve (mellem grå)
           .onClick(event -> {
               parent.changeFloor(parent.currentFloor - 1); // Handling ved klik
               updateFloorLabel(); // Opdater etiket for etage
               updateFloorButtons(); // Opdater knapperne for etageskift
           });

        // Tilføj etiket for at vise den aktuelle etage
        cp5.addTextlabel("floorLabel")
           .setText("Etage: " + parent.currentFloor) // Sæt initial tekst
           .setPosition(700, 150) // Position af etiketten
           .setSize(100, 30); // Størrelse af etiketten

        updateFloorButtons(); // Opdater knapperne for etageskift ved initialisering
    }

    void render() {
        fill(50); // Sæt fyldfarven til mørk grå
        textSize(16); // Sæt tekststørrelsen
        textAlign(LEFT, CENTER); // Juster teksten til venstre
        text("Vælg Start:", 40, parent.height - 220); // Tegn "Vælg Start" etiketten
        text("Vælg Slut:", 260, parent.height - 220); // Tegn "Vælg Slut" etiketten
    }

    void updatePath() {
        if (startNode.isEmpty() || endNode.isEmpty()) {
            println("Advarsel: Start- eller slutnode er ikke valgt.");
            return;
        }
        println("Opdaterer sti fra " + startNode + " til " + endNode); // Print start- og slutnoderne
        parent.updatePath(startNode, endNode); // Kald updatePath i hovedklassen
    }

    String[] getNodeIds() {
        // Hent alle node-ID'er fra grafen og sorter dem alfabetisk
        return graph.getAllNodes().keySet().stream()
            .sorted()
            .toArray(String[]::new);
    }

    // Hent kun ID'er for rum ("rooms") og sorter dem med single-letter IDs først
    String[] getRoomIds() {
        return graph.rooms.keySet().stream()
            .sorted((a, b) -> {
                // First compare by length (shorter strings first)
                if (a.length() != b.length()) {
                    return Integer.compare(a.length(), b.length());
                }
                // If lengths are equal, compare alphabetically
                return a.compareTo(b);
            })
            .toArray(String[]::new);
    }

    // Opdaterer etiketten for den aktuelle etage
    private void updateFloorLabel() {
        cp5.get(Textlabel.class, "floorLabel").setText("Etage: " + parent.currentFloor);
    }

    // Opdaterer synligheden af knapperne for etageskift
    private void updateFloorButtons() {
        int minFloor = parent.layout.getGraph().getMinFloor();
        int maxFloor = parent.layout.getGraph().getMaxFloor();

        if (parent.currentFloor <= minFloor) {
            cp5.getController("floorDown").hide();
        } else {
            cp5.getController("floorDown").show();
        }

        if (parent.currentFloor >= maxFloor) {
            cp5.getController("floorUp").hide();
        } else {
            cp5.getController("floorUp").show();
        }
    }
}