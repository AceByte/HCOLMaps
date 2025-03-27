class Layout {
    Graph graph;

    Layout() {
        graph = new Graph();
        graph.loadFromJson("Data.json"); // Indlæs noder og kanter fra JSON
    }

    Graph getGraph() {
        return graph;
    }
}