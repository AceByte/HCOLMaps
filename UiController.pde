import java.util.*; // Importer Java-værktøjer

class UIController {
    ControlP5 cp5; // ControlP5-objekt til GUI-kontroller
    Graph graph; // Graph-objekt til at administrere noder og kanter
    HCOLMaps parent; // Reference til hovedskitsen
    String startNode = "A"; // Standard startnode
    String endNode = "E"; // Standard slutnode

    // Manuelt gemme elementer til dropdowns
    String[] startNodeItems; // Array til at gemme startnode-elementer
    String[] endNodeItems; // Array til at gemme slutnode-elementer

    UIController(HCOLMaps parent, Graph graph) {
        this.parent = parent; // Gem reference til hovedskitsen
        this.graph = graph; // Gem reference til grafen
        cp5 = new ControlP5(parent); // Initialiser ControlP5

        // Hent noderne fra grafen, ekskluderer kryds og sorterer alfabetisk
        startNodeItems = graph.getAllNodes().values().stream()
            .filter(node -> !(node instanceof Intersection))
            .map(node -> node.id)
            .sorted()
            .toArray(String[]::new);
        endNodeItems = startNodeItems.clone(); // Klon startnode-elementerne til slutnode-elementerne

        // Dropdown til startlokation
        cp5.addScrollableList("startDropdown")
           .setPosition(20, parent.height - 150) // Sæt positionen af dropdown
           .setSize(150, 100) // Sæt størrelsen af dropdown
           .addItems(startNodeItems) // Tilføj elementer til dropdown
           .setOpen(false) // Hold dropdown lukket efter valg
           .onChange(event -> {
               // Fang den valgte startnode-værdi
               String selectedStartNode = event.getController().getValueLabel().getText();
               println("Dropdown startnode valgt: " + selectedStartNode);

               // Opdater startnode hvis den er gyldig
               if (selectedStartNode != null && !selectedStartNode.isEmpty()) {
                   startNode = selectedStartNode;
                   println("Startnode opdateret til: " + startNode);
               } else {
                   println("Ugyldig startnode valgt");
               }
               updatePath(); // Opdater stien
           });

        // Dropdown til slutlokation
        cp5.addScrollableList("endDropdown")
           .setPosition(200, parent.height - 150) // Sæt positionen af dropdown
           .setSize(150, 100) // Sæt størrelsen af dropdown
           .addItems(endNodeItems) // Tilføj elementer til dropdown
           .setOpen(false) // Hold dropdown lukket efter valg
           .onChange(event -> {
               // Fang den valgte slutnode-værdi
               String selectedEndNode = event.getController().getValueLabel().getText();
               println("Dropdown slutnode valgt: " + selectedEndNode);

               // Opdater slutnode hvis den er gyldig
               if (selectedEndNode != null && !selectedEndNode.isEmpty()) {
                   endNode = selectedEndNode;
                   println("Slutnode opdateret til: " + endNode);
               } else {
                   println("Ugyldig slutnode valgt");
               }
               updatePath(); // Opdater stien
           });

        // Sæt initiale værdier for start- og slutdropdowns ved at sætte værdien i listen.
        cp5.get(ScrollableList.class, "startDropdown").setStringValue(startNode);
        cp5.get(ScrollableList.class, "endDropdown").setStringValue(endNode);

        // Sørg for at dropdowns viser den rigtige valgte værdi med det samme
        updateDropdownSelection(); // Opdater dropdown-valget

        // Knap til at beregne ny sti
        cp5.addButton("calculatePathButton")
           .setLabel("Beregn Sti") // Sæt etiketten for knappen
           .setPosition(380, parent.height - 150) // Sæt positionen af knappen
           .setSize(150, 30) // Sæt størrelsen af knappen
           .onClick(event -> {
               updatePath(); // Sørg for at stien opdateres efter knapklik
           });

        // Tilføj knapper til at skifte etager
        cp5.addButton("floorUp")
           .setLabel("Op") // Etiket for knappen
           .setPosition(700, 50) // Position af knappen
           .setSize(50, 30) // Størrelse af knappen
           .onClick(event -> {
               parent.changeFloor(parent.currentFloor + 1); // Handling ved klik
               updateFloorLabel(); // Opdater etiket for etage
               updateFloorButtons(); // Opdater knapperne for etageskift
           });

        cp5.addButton("floorDown")
           .setLabel("Ned") // Etiket for knappen
           .setPosition(700, 100) // Position af knappen
           .setSize(50, 30) // Størrelse af knappen
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
        fill(0); // Sæt fyldfarven til sort
        textSize(14); // Sæt tekststørrelsen
        text("Vælg Start:", 40, parent.height - 160); // Tegn "Vælg Start" etiketten
        text("Vælg Slut:", 220, parent.height - 160); // Tegn "Vælg Slut" etiketten
    }

    void updatePath() {
        // Hent de aktuelle værdier fra dropdowns
        startNode = cp5.get(ScrollableList.class, "startDropdown").getValueLabel().getText();
        endNode = cp5.get(ScrollableList.class, "endDropdown").getValueLabel().getText();

        println("Opdaterer sti fra " + startNode + " til " + endNode); // Print start- og slutnoderne
        parent.updatePath(startNode, endNode); // Kald updatePath i hovedklassen
    }

    // Sørger for at dropdowns afspejler det korrekte valg
    private void updateDropdownSelection() {
        // Sørg for at dropdowns afspejler de valgte værdier med det samme
        cp5.getController("startDropdown").setStringValue(startNode);
        cp5.getController("endDropdown").setStringValue(endNode);
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