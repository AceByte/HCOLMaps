# HCOLMaps

HCOLMaps is a project that visualizes a graph of rooms, intersections, staircases, and calculates the shortest path between two nodes using Dijkstra's algorithm. The project is built using Processing.

## Project Structure

- **HCOLMaps.pde**: Main entry point of the application. Handles setup, rendering, and user interactions.
- **Graph.pde**: Represents the graph structure, including nodes (rooms, intersections, staircases, exits) and edges.
- **Node.pde**: Base class for all nodes in the graph.
- **Room.pde**: Represents a room in the graph.
- **Intersection.pde**: Represents an intersection in the graph.
- **Staircase.pde**: Represents a staircase connecting different floors.
- **Layout.pde**: Manages the graph layout and loads data from a JSON file.
- **LayoutManager.pde**: Provides additional layout management functionality.
- **MapRenderer.pde**: Handles rendering of the map, including nodes, edges, and paths.
- **UIController.pde**: Manages the user interface, including dropdowns and buttons.
- **Dijkstra.pde**: Implements Dijkstra's algorithm for finding the shortest path.
- **Hallway.pde**: Represents a hallway (edge) between two nodes.
- **Data.json**: Contains the graph data, including nodes and edges.

## Classes and Methods

### HCOLMaps
- **setup()**: Initializes the application, including layout, renderer, and UI.
- **draw()**: Renders the map and UI.
- **updatePath(start, end)**: Updates the shortest path between two nodes.
- **changeFloor(floor)**: Changes the current floor and updates the map.
- **mouseReleased()**: Logs the mouse position when released.

### Graph
- **loadFromJson(filePath)**: Loads graph data from a JSON file.
- **addRoom(id, x, y, floor)**: Adds a room to the graph.
- **addIntersection(id, x, y, floor)**: Adds an intersection to the graph.
- **addStaircase(id, x, y, startFloor, endFloor)**: Adds a staircase to the graph.
- **addEdge(from, to)**: Adds an edge between two nodes.
- **addNode(node)**: Adds a generic node to the graph.
- **addEdge(from, to, weight)**: Adds an edge with a specific weight.
- **getAllNodes()**: Returns all nodes in the graph.
- **getMinFloor() / getMaxFloor()**: Returns the minimum/maximum floor in the graph.

### Node
- **Node(id, x, y)**: Constructor for a generic node.
- **toString()**: Returns the string representation of the node ID.

### Room
- **Room(name, x, y, floor)**: Constructor for a room node.

### Intersection
- **Intersection(name, x, y, floor)**: Constructor for an intersection node.

### Staircase
- **Staircase(id, x, y, startFloor, endFloor)**: Constructor for a staircase node.

### Layout
- **Layout()**: Initializes the graph and loads data from a JSON file.
- **getGraph()**: Returns the graph object.

### LayoutManager
- **LayoutManager(graph)**: Constructor for managing the graph layout.

### MapRenderer
- **MapRenderer(graph, parent)**: Constructor for the map renderer.
- **render(path)**: Renders the map, including nodes, edges, and the shortest path.
- **changeFloor(floor)**: Updates the current floor for rendering.
- **getNode(id)**: Retrieves a node from the graph by its ID.

### UIController
- **UIController(parent, graph)**: Constructor for the UI controller.
- **render()**: Renders the UI elements.
- **updatePath()**: Updates the path based on selected start and end nodes.
- **updateFloorLabel()**: Updates the floor label in the UI.
- **updateFloorButtons()**: Updates the visibility of floor navigation buttons.
- **getNodeIds()**: Retrieves all node IDs from the graph.
- **getRoomIds()**: Retrieves room IDs sorted numerically.

### Dijkstra
- **Dijkstra(graph)**: Constructor for the Dijkstra algorithm.
- **findShortestPath(start, end)**: Finds the shortest path between two nodes.
- **dijkstra(graph, start, end)**: Implements the Dijkstra algorithm.

### Hallway
- **Hallway(start, end, allNodes)**: Constructor for a hallway edge.
- **weight**: Dynamically calculates the weight based on pixel distance.

### Data.json
- **nodes**: Defines the nodes in the graph, including type, ID, coordinates, and floor.
- **edges**: Defines the edges between nodes.
