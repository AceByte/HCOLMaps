import java.util.*;
import controlP5.*;

public class ImagePopup extends PApplet {
    ControlP5 cp5;
    PImage uploadedImage;
    boolean isVisible = false;
    boolean isInitialized = false;
    int popupWidth = 800;
    int popupHeight = 600;
    PFont labelFont, headerFont;
    HCOLMaps parent;
    ColorDetector detector;
    PGraphics pg;

    public ImagePopup(HCOLMaps parent) {
        this.parent = parent;
    }

    public void settings() {
        size(popupWidth, popupHeight);
    }

    public void setup() {
        surface.setResizable(false);
        surface.setLocation(150, 150);
        cp5 = new ControlP5(this);
        labelFont = createFont("Arial", 12);
        headerFont = createFont("Arial", 16);

        // Don't initialize detector and pg here since uploadedImage is null
        // We'll create them after an image is loaded

        cp5.addButton("Upload Image")
            .setFont(labelFont)
            .setPosition(10, 10)
            .setSize(120, 30)
            .onClick(e -> selectInput("Select an image to upload:", "imageSelected"));

        cp5.addButton("Detect Colors")
            .setFont(labelFont)
            .setPosition(140, 10)
            .setSize(120, 30)
            .onClick(e -> detectColors())
            .setVisible(false);  // Hide until image is loaded

        cp5.addButton("Close")
            .setFont(labelFont)
            .setPosition(270, 10)
            .setSize(120, 30)
            .onClick(e -> close());

        isInitialized = true;
    }

    public void draw() {
        if (isVisible) {
            background(255);

            // Draw uploaded image or analysis result
            if (uploadedImage != null) {
                if (pg != null && pg.width > 0) {
                    // Display the processed image if available
                    image(pg, 0, 0, width, height);
                } else {
                    // Otherwise show the original image
                    image(uploadedImage, 0, 0, width, height);
                }
            } else {
                fill(0);
                textAlign(CENTER, CENTER);
                text("No image uploaded. Click 'Upload Image' to load an image.", width / 2, height / 2);
            }
        }
    }

    public void imageSelected(File selection) {
        if (selection != null) {
            uploadedImage = loadImage(selection.getAbsolutePath());

            // Only create these objects after an image is loaded
            detector = new ColorDetector(uploadedImage);
            pg = createGraphics(uploadedImage.width, uploadedImage.height);

            // Now show the detect colors button
            cp5.getController("Detect Colors").setVisible(true);
        }
    }

    public void detectColors() {
        if (uploadedImage != null && detector != null) {
            detector.detectColors();
            detector.highlightColors(pg);
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
        isVisible = false;
        surface.setVisible(false);
        dispose();
    }

    @Override
    public void dispose() {
        isVisible = false;
        super.dispose();
    }

    @Override
    public void exit() {
        dispose();
    }
}