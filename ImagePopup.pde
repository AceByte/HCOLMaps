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

        cp5.addButton("Upload Image")
            .setFont(labelFont)
            .setPosition(10, 10)
            .setSize(120, 30)
            .onClick(e -> selectInput("Select an image to upload:", "imageSelected"));

        cp5.addButton("Close")
            .setFont(labelFont)
            .setPosition(140, 10)
            .setSize(120, 30)
            .onClick(e -> close());

        isInitialized = true;
    }

    public void draw() {
        if (isVisible) {
            background(255);

            // Draw uploaded image
            if (uploadedImage != null) {
                image(uploadedImage, 0, 0, width, height);
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