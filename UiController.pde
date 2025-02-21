class UIController {
    ControlP5 cp5;
    Graph graph;
    HCOLMaps parent;  // Correct reference to main sketch
    String startNode = "A";
    String endNode = "E";

    // Manually store items for the dropdowns
    String[] startNodeItems;
    String[] endNodeItems;

    UIController(HCOLMaps parent, Graph graph) {
        this.parent = parent;  // Store reference to the main sketch
        this.graph = graph;
        cp5 = new ControlP5(parent);

        // Get the nodes from the graph, excluding intersections
        startNodeItems = graph.getAllNodes().values().stream()
            .filter(node -> !(node instanceof Intersection))
            .map(node -> node.id)
            .toArray(String[]::new);
        endNodeItems = startNodeItems.clone();

        // Dropdown for start location
        cp5.addScrollableList("startDropdown")
           .setPosition(20, parent.height - 150)
           .setSize(150, 100)
           .addItems(startNodeItems)
           .setOpen(false)  // Keep dropdown closed after selection
           .onChange(event -> {
               // Capture the selected start node value
               String selectedStartNode = event.getController().getLabel();

               // Update the start node if it's valid
               if (selectedStartNode != null && !selectedStartNode.isEmpty()) {
                   startNode = selectedStartNode;
               }
               updatePath();
           });

        // Dropdown for end location
        cp5.addScrollableList("endDropdown")
           .setPosition(200, parent.height - 150)
           .setSize(150, 100)
           .addItems(endNodeItems)
           .setOpen(false)  // Keep dropdown closed after selection
           .onChange(event -> {
               // Capture the selected end node value
               String selectedEndNode = event.getController().getLabel();

               // Update the end node if it's valid
               if (selectedEndNode != null && !selectedEndNode.isEmpty()) {
                   endNode = selectedEndNode;
               }
               updatePath();
           });

        // Set initial values for start and end dropdowns by setting the value in the list.
        cp5.getController("startDropdown").setStringValue(startNode);
        cp5.getController("endDropdown").setStringValue(endNode);

        // Ensure the dropdowns show the right selected value immediately
        updateDropdownSelection();
    }

    void render() {
        fill(0);
        textSize(14);
        text("Select Start:", 40, parent.height - 160);
        text("Select End:", 220, parent.height - 160);
    }

    void updatePath() {
        // Retrieve the current values from the dropdowns
        startNode = cp5.get(ScrollableList.class, "startDropdown").getLabel();
        endNode = cp5.get(ScrollableList.class, "endDropdown").getLabel();

        parent.updatePath(startNode, endNode);  // Now calls updatePath in the main class
    }

    // Ensures dropdowns reflect the correct selection
    private void updateDropdownSelection() {
        // Make sure the dropdowns reflect the selected values immediately
        cp5.getController("startDropdown").setStringValue(startNode);
        cp5.getController("endDropdown").setStringValue(endNode);
    }
}
