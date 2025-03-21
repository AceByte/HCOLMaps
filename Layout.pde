class Layout {
    Graph graph;

    Layout() {
        graph = new Graph();
        graph.loadFromJson("Data.json"); // Load nodes and edges from JSON
    }

    Graph getGraph() {
        return graph;
    }
}