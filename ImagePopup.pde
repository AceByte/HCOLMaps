import java.util.*;
import controlP5.*;

public class ImagePopup extends PApplet {
    PImage uploadedImage;
    List<Arrow> arrows = new ArrayList<>();
    List<TextLabel> textLabels = new ArrayList<>();
    boolean isVisible = false;
    boolean isInitialized = false;
    HCOLMaps parent; // Reference to the parent
    ControlP5 cp5; // ControlP5 instance for buttons

    public ImagePopup(HCOLMaps parent) {
        this.parent = parent; // Store the parent reference
    }

    public void settings() {
        size(800, 600);
    }

    public void setup() {
        surface.setResizable(false);
        surface.setLocation(150, 150);
        background(255);
        textSize(16);
        fill(0);
        textAlign(CENTER, CENTER);
        text("Click 'Upload Image' to load an image", width / 2, height / 2);
        isInitialized = true;

        // Initialize ControlP5 and add buttons
        cp5 = new ControlP5(this);

        cp5.addButton("Upload Image")
            .setPosition(10, 10)
            .setSize(120, 30)
            .onClick(event -> selectInput("Select an image to upload:", "imageSelected"));

        cp5.addButton("Close")
            .setPosition(140, 10)
            .setSize(120, 30)
            .onClick(event -> close());

        // Load existing data (arrows and text) from the parent or a file
        loadExistingData();
    }

    public void draw() {
        if (!isVisible) return;

        background(255);

        // Draw uploaded image
        if (uploadedImage != null) {
            image(uploadedImage, 0, 0, width, height);
        }

        // Draw arrows
        stroke(255, 0, 0);
        strokeWeight(3);
        for (Arrow arrow : arrows) {
            line(arrow.start.x, arrow.start.y, arrow.end.x, arrow.end.y);
            drawArrowHead(arrow.start, arrow.end);
        }

        // Draw text labels
        fill(0);
        textSize(16);
        for (TextLabel label : textLabels) {
            text(label.text, label.position.x, label.position.y);
        }
    }

    public void imageSelected(File selection) {
        if (selection != null) {
            uploadedImage = loadImage(selection.getAbsolutePath());
        }
    }

    public void open() {
        if (!isInitialized) {
            delay(50);
            open();
            return;
        }
        isVisible = true;
        surface.setVisible(true);
    }

    public void close() {
        isVisible = false; // Mark the popup as not visible
        surface.setVisible(false); // Hide the popup window
        surface.stopThread(); // Stop the rendering thread for the popup
        dispose(); // Dispose of the popup resources
        parent.popup = null; // Reset the popup reference in the parent
    }

    private void drawArrowHead(PVector start, PVector end) {
        float angle = atan2(end.y - start.y, end.x - start.x);
        float arrowSize = 10;
        PVector arrowPoint1 = new PVector(
            end.x - arrowSize * cos(angle - PI / 6),
            end.y - arrowSize * sin(angle - PI / 6)
        );
        PVector arrowPoint2 = new PVector(
            end.x - arrowSize * cos(angle + PI / 6),
            end.y - arrowSize * sin(angle + PI / 6)
        );
        line(end.x, end.y, arrowPoint1.x, arrowPoint1.y);
        line(end.x, end.y, arrowPoint2.x, arrowPoint2.y);
    }

    private void loadExistingData() {
        // Example: Load arrows and text from the parent or a file
        // Replace this with actual logic to load data
        arrows = parent.getArrows(); // Assuming parent has a method to provide arrows
        textLabels = parent.getTextLabels(); // Assuming parent has a method to provide text labels
    }
}

class Arrow {
    PVector start, end;

    Arrow(PVector start, PVector end) {
        this.start = start;
        this.end = end;
    }
}

class TextLabel {
    String text;
    PVector position;

    TextLabel(String text, PVector position) {
        this.text = text;
        this.position = position;
    }
}