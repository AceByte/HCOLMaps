# HCOLMaps

HCOLMaps is a project that visualizes a graph of rooms and intersections, and calculates the shortest path between two nodes using Dijkstra's algorithm. The project is built using Processing.

## Project Structure

- `HCOLMaps.pde`: The main file that sets up the environment, initializes the layout, map renderer, and UI controller, and handles the drawing and path updating.
- `Layout.pde`: Defines the `Layout` class, which creates rooms, intersections, and hallways, and adds them to the graph.
- `LayoutManager.pde`: Defines the `LayoutManager` class, which handles the creation of rooms and intersections.
- `Graph.pde`: Defines the `Graph` class, which manages nodes and edges.
- `Node.pde`: Defines the `Node` class, which represents a node in the graph.
- `Room.pde`: Defines the `Room` class, which extends `Node` and represents a room.
- `Intersection.pde`: Defines the `Intersection` class, which extends `Node` and represents an intersection.
- `Hallway.pde`: Defines the `Hallway` class, which represents a hallway between two nodes.
- `Dijkstra.pde`: Implements Dijkstra's algorithm to find the shortest path between two nodes.
- `MapRenderer.pde`: Defines the `MapRenderer` class, which handles the rendering of the graph and the shortest path.
- `UiController.pde`: Defines the `UIController` class, which manages the user interface for selecting start and end nodes and calculating the path.

## Setup

1. Install [Processing](https://processing.org/download/).
2. Clone this repository to your local machine.
3. Open the project in Processing.

## Usage

1. Run the `HCOLMaps.pde` file in Processing.
2. Use the dropdown menus to select the start and end nodes.
3. Click the "Calculate Path" button to find and display the shortest path between the selected nodes.

## Classes and Methods

### HCOLMaps

- `setup()`: Initializes the layout, map renderer, and UI controller, and sets the default path.
- `draw()`: Renders the map and UI.
- `updatePath(String start, String end)`: Updates the path between the specified start and end nodes using Dijkstra's algorithm.

### Layout

- `Layout()`: Constructor that initializes the graph and creates rooms and hallways.
- `createRoomsAndHallways()`: Creates sample rooms, intersections, and hallways, and adds them to the graph.
- `calculateWeight(String start, String end, Room[] rooms, Intersection[] intersections)`: Calculates the weight (distance) between two nodes.
- `findNode(String id, Room[] rooms, Intersection[] intersections)`: Finds a node by its ID.
- `getGraph()`: Returns the graph.

### LayoutManager

- `LayoutManager(Graph graph)`: Constructor that initializes the graph and creates rooms and intersections.
- `createRooms()`: Creates sample rooms and adds them to the graph.
- `createIntersections()`: Creates sample intersections and adds them to the graph.

### Graph

- `addNode(String id, float x, float y)`: Adds a node to the graph.
- `addEdge(String from, String to, int weight)`: Adds an edge between two nodes with the specified weight.

### Node

- `Node(String id, float x, float y)`: Constructor that initializes the node with the specified ID and coordinates.

### Room

- `Room(String name, float x, float y)`: Constructor that initializes the room with the specified name and coordinates.

### Intersection

- `Intersection(String name, float x, float y)`: Constructor that initializes the intersection with the specified name and coordinates.

### Hallway

- `Hallway(String start, String end, float weight)`: Constructor that initializes the hallway with the specified start and end nodes and weight.

### Dijkstra

- `Dijkstra(Graph graph)`: Constructor that initializes the algorithm with the specified graph.
- `findShortestPath(String start, String end)`: Finds the shortest path between the specified start and end nodes.
- `dijkstra(Graph graph, String start, String end)`: Implements Dijkstra's algorithm to find the shortest path.

### MapRenderer

- `MapRenderer(Graph graph)`: Constructor that initializes the renderer with the specified graph.
- `render(List<Node> path)`: Renders the graph and the specified path.

### UIController

- `UIController(HCOLMaps parent, Graph graph)`: Constructor that initializes the UI controller with the specified parent and graph.
- `render()`: Renders the UI.
- `updatePath()`: Updates the path based on the selected start and end nodes.
- `updateDropdownSelection()`: Ensures the dropdowns reflect the correct selection.