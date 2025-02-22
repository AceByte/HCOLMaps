import java.util.*; // Import Java utilities

class UIController {
    ControlP5 cp5; // ControlP5 object for GUI controls
    Graph graph; // Graph object to manage nodes and edges
    HCOLMaps parent; // Reference to the main sketch
    String startNode = "A"; // Default start node
    String endNode = "E"; // Default end node

    // Manually store items for the dropdowns
    String[] startNodeItems; // Array to store start node items
    String[] endNodeItems; // Array to store end node items

    UIController(HCOLMaps parent, Graph graph) {
        this.parent = parent; // Store reference to the main sketch
        this.graph = graph; // Store reference to the graph
        cp5 = new ControlP5(parent); // Initialize ControlP5

        // Get the nodes from the graph, excluding intersections and sorting alphabetically
        startNodeItems = graph.getAllNodes().values().stream()
            .filter(node -> !(node instanceof Intersection))
            .map(node -> node.id)
            .sorted()
            .toArray(String[]::new);
        endNodeItems = startNodeItems.clone(); // Clone the start node items for the end node items

        // Dropdown for start location
        cp5.addScrollableList("startDropdown")
           .setPosition(20, parent.height - 150) // Set the position of the dropdown
           .setSize(150, 100) // Set the size of the dropdown
           .addItems(startNodeItems) // Add items to the dropdown
           .setOpen(false) // Keep dropdown closed after selection
           .onChange(event -> {
               // Capture the selected start node value
               String selectedStartNode = event.getController().getValueLabel().getText();
               println("Dropdown start node selected: " + selectedStartNode);

               // Update the start node if it's valid
               if (selectedStartNode != null && !selectedStartNode.isEmpty()) {
                   startNode = selectedStartNode;
                   println("Start node updated to: " + startNode);
               } else {
                   println("Invalid start node selected");
               }
               updatePath(); // Update the path
           });

        // Dropdown for end location
        cp5.addScrollableList("endDropdown")
           .setPosition(200, parent.height - 150) // Set the position of the dropdown
           .setSize(150, 100) // Set the size of the dropdown
           .addItems(endNodeItems) // Add items to the dropdown
           .setOpen(false) // Keep dropdown closed after selection
           .onChange(event -> {
               // Capture the selected end node value
               String selectedEndNode = event.getController().getValueLabel().getText();
               println("Dropdown end node selected: " + selectedEndNode);

               // Update the end node if it's valid
               if (selectedEndNode != null && !selectedEndNode.isEmpty()) {
                   endNode = selectedEndNode;
                   println("End node updated to: " + endNode);
               } else {
                   println("Invalid end node selected");
               }
               updatePath(); // Update the path
           });

        // Set initial values for start and end dropdowns by setting the value in the list.
        cp5.get(ScrollableList.class, "startDropdown").setStringValue(startNode);
        cp5.get(ScrollableList.class, "endDropdown").setStringValue(endNode);

        // Ensure the dropdowns show the right selected value immediately
        updateDropdownSelection(); // Update the dropdown selection

        // Button to calculate new path
        cp5.addButton("calculatePathButton")
           .setLabel("Calculate Path") // Set the label for the button
           .setPosition(380, parent.height - 150) // Set the position of the button
           .setSize(150, 30) // Set the size of the button
           .onClick(event -> {
               updatePath(); // Ensure the path is updated after button click
           });
    }

    void render() {
        fill(0); // Set the fill color to black
        textSize(14); // Set the text size
        text("Select Start:", 40, parent.height - 160); // Draw the "Select Start" label
        text("Select End:", 220, parent.height - 160); // Draw the "Select End" label
    }

    void updatePath() {
        // Retrieve the current values from the dropdowns
        startNode = cp5.get(ScrollableList.class, "startDropdown").getValueLabel().getText();
        endNode = cp5.get(ScrollableList.class, "endDropdown").getValueLabel().getText();

        println("Updating path from " + startNode + " to " + endNode); // Print the start and end nodes
        parent.updatePath(startNode, endNode); // Call updatePath in the main class
    }

    // Ensures dropdowns reflect the correct selection
    private void updateDropdownSelection() {
        // Make sure the dropdowns reflect the selected values immediately
        cp5.getController("startDropdown").setStringValue(startNode);
        cp5.getController("endDropdown").setStringValue(endNode);
    }
}
