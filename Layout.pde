class Layout {
    Graph graph;

    Layout() {
        graph = new Graph();
        graph.loadFromJson("Data.json"); 
    }

    Graph getGraph() {
        return graph;
    }
}