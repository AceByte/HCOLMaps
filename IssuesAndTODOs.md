# Issues and TODOs

## Issues
1. **Wrong Staircase Used from Floor 2-3**
   - The application uses the wrong staircase when navigating from floor 2 to floor 3.

2. **Dropdown List Selection Issue**
   - The application does not choose the correct point from the dropdown list.

3. **Hardcoded Floor Limits**
   - The floor limits are hardcoded in the `changeFloor` method, making it difficult to extend the application to more floors.

4. **No Error Handling for Invalid Nodes**
   - The `updatePath` method does not handle cases where the start or end nodes are invalid or do not exist.

5. **No Visual Indication of Current Floor**
   - The current floor is not visually indicated on the UI, making it difficult for users to know which floor they are on.

6. **No Path Highlighting for Different Floors**
   - The path is not highlighted correctly when it spans multiple floors.

## TODOs
1. **Android Compatibility**
   - Ensure the application can be used on Android devices.

2. **Dark Mode/Light Mode**
   - Implement a dark mode and light mode for the user interface.

3. **UI Improvements**
   - Improve the overall user interface for better usability.

4. **Create Walls**
   - Add walls to the map to better represent the layout.

5. **Create Icons**
   - Design and add icons for different elements on the map.

6. **Navigation Instructions**
   - Provide navigation instructions for users to follow the path.

7. **More Categories for Rooms**
   - Add more categories for rooms to better classify them.

8. **Create Exits**
   - Add exits to the map to represent possible exit points.

9. **Dynamic Floor Limits**
   - Make the floor limits dynamic to allow for easy extension to more floors.

10. **Error Handling for Invalid Nodes**
    - Add error handling in the `updatePath` method to handle cases where the start or end nodes are invalid or do not exist.

11. **Visual Indication of Current Floor**
    - Add a visual indication of the current floor on the UI.

12. **Path Highlighting for Different Floors**
    - Ensure the path is highlighted correctly when it spans multiple floors.

13. **Optimize Pathfinding Algorithm**
    - Optimize the Dijkstra's algorithm implementation for better performance with larger graphs.

14. **Add Unit Tests**
    - Add unit tests for the key classes and methods to ensure the correctness of the implementation.

15. **Documentation**
    - Improve the documentation for the project, including class and method descriptions, and usage instructions.