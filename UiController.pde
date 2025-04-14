import java.util.*;

class UIController {
    ControlP5 cp5;
    Graph graph;
    HCOLMaps parent;
    String startNode = "";
    String endNode = "";

    UIController(HCOLMaps parent, Graph graph) {
        this.parent = parent;
        this.graph = graph;
        cp5 = new ControlP5(parent);

        String[] roomIds = getRoomIds();
        cp5.setFont(createFont("Arial", 14, true));

        // Dropdown til at vælge startnode
        cp5.addDropdownList("startNodeDropdown")
           .setPosition(40, parent.height - 200)
           .setSize(200, 200)
           .setBarHeight(30)
           .setItemHeight(25)
           .setOpen(false)
           .setLabel("Start")
           .setColorBackground(color(50))
           .setColorActive(color(150))
           .setColorForeground(color(180))
           .addItems(roomIds)
           .onChange(event -> {
               int selectedIndex = (int) event.getController().getValue();
               if (selectedIndex >= 0 && selectedIndex < roomIds.length) {
                   startNode = roomIds[selectedIndex];
                   event.getController().setCaptionLabel(startNode);
                   println("Startnode valgt: " + startNode);
                   updatePath();
               } else {
                   println("Invalid index selected: " + selectedIndex);
               }
           });

        // Dropdown til at vælge slutnode
        cp5.addDropdownList("endNodeDropdown")
           .setPosition(260, parent.height - 200)
           .setSize(200, 200)
           .setBarHeight(30)
           .setItemHeight(25)
           .setOpen(false)
           .setLabel("Slut")
           .setColorBackground(color(50))
           .setColorActive(color(150))
           .setColorForeground(color(180))
           .addItems(roomIds)
           .onChange(event -> {
               int selectedIndex = (int) event.getController().getValue();
               if (selectedIndex >= 0 && selectedIndex < roomIds.length) {
               endNode = roomIds[selectedIndex];
               event.getController().setCaptionLabel(endNode);
               println("Slutnode valgt: " + endNode);
               updatePath();
               } else {
               println("Invalid index selected: " + selectedIndex);
               }
           });

        // knapper til at skifte etager
        cp5.addButton("floorUp")
           .setLabel("Op")
           .setPosition(700, 50)
           .setSize(50, 30)
           .setColorBackground(color(50))
           .setColorActive(color(150))
           .setColorForeground(color(180))
           .onClick(event -> {
               parent.changeFloor(parent.currentFloor + 1);
               updateFloorLabel();
               updateFloorButtons();
           });

        cp5.addButton("floorDown")
           .setLabel("Ned")
           .setPosition(700, 100)
           .setSize(50, 30)
           .setColorBackground(color(50))
           .setColorActive(color(150))
           .setColorForeground(color(180))
           .onClick(event -> {
               parent.changeFloor(parent.currentFloor - 1);
               updateFloorLabel();
               updateFloorButtons();
           });

        //  etiket for at vise den aktuelle etage
        cp5.addTextlabel("floorLabel")
           .setText("Etage: " + parent.currentFloor)
           .setPosition(700, 150)
           .setSize(100, 30);

        cp5.addButton("openImagePopup")
           .setLabel("Upload Image")
           .setPosition(700, 200)
           .setSize(100, 30)
           .onClick(event -> {
               parent.openImagePopup();
           });

        updateFloorButtons();
    }

    void render() {
        fill(200);
        textSize(16);
        textAlign(LEFT, CENTER);
        text("Vælg:", 40, parent.height - 220);
        text("Vælg:", 260, parent.height - 220);
    }

    // Opdaterer stien baseret på de valgte start- og slutnoder
    void updatePath() {
        if (startNode.isEmpty() || endNode.isEmpty()) {
            println("Advarsel: Start- eller slutnode er ikke valgt.");
            return;
        }
        println("Opdaterer sti fra " + startNode + " til " + endNode);

        parent.updatePath(startNode, endNode);

        // Calculate and print the total weight of the path
        List<Node> path = parent.path;
        if (path != null && path.size() > 1) {
            int totalWeight = 0;
            for (int i = 0; i < path.size() - 1; i++) {
                Node current = path.get(i);
                Node next = path.get(i + 1);
                int weight = graph.adjacencyList.get(current.id).get(next.id);
                totalWeight += weight;
            }
            println("Total weight of the path: " + totalWeight);
        } else {
            println("No valid path found.");
        }
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
                if (a.length() != b.length()) {
                    return Integer.compare(a.length(), b.length());
                }
                return a.compareTo(b);
            })
            .toArray(String[]::new);
    }

    private void updateFloorLabel() {
        cp5.get(Textlabel.class, "floorLabel").setText("Etage: " + parent.currentFloor);
    }

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