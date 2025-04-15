import java.util.*;
import controlP5.*;
import processing.core.*;
import gab.opencv.*;
import org.opencv.core.*;
import org.opencv.imgproc.*;

public class ImagePopup extends PApplet {
    ControlP5 cp5;
    PImage uploadedImage;
    boolean isVisible = false;
    boolean isInitialized = false;
    int popupWidth = 800;
    int popupHeight = 600;
    PFont labelFont, headerFont;
    HCOLMaps parent;
    OpenCV opencv;
    HashMap<String, String> annotations = new HashMap<>();

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
                detectShapesAndColors();
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
            opencv = new OpenCV(this, uploadedImage);
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

    void detectShapesAndColors() {
        opencv.loadImage(uploadedImage);
        opencv.gray();
        opencv.threshold(100);

        List<Contour> contours = opencv.findContours();
        for (Contour contour : contours) {
            PVector[] points = contour.getPoints();
            if (points.length > 5) {
                PVector center = contour.getCentroid();
                float radius = contour.getRadius();
                int color = getColorAt(center.x, center.y);

                if (isRed(color)) {
                    annotations.put("Room", "Detected red circle at " + center);
                } else if (isBlue(color)) {
                    annotations.put("Intersection", "Detected blue circle at " + center);
                } else if (isGreen(color)) {
                    annotations.put("Hallway", "Detected green line at " + center);
                } else if (isCyan(color)) {
                    annotations.put("Staircase", "Detected cyan circle at " + center);
                } else if (isBlack(color)) {
                    annotations.put("Wall", "Detected black line at " + center);
                }
            }
        }
    }

    int getColorAt(float x, float y) {
        int c = uploadedImage.get((int) x, (int) y);
        return c;
    }

    boolean isRed(int color) {
        return red(color) > 150 && green(color) < 100 && blue(color) < 100;
    }

    boolean isBlue(int color) {
        return blue(color) > 150 && red(color) < 100 && green(color) < 100;
    }

    boolean isGreen(int color) {
        return green(color) > 150 && red(color) < 100 && blue(color) < 100;
    }

    boolean isCyan(int color) {
        return blue(color) > 150 && green(color) > 150 && red(color) < 100;
    }

    boolean isBlack(int color) {
        return red(color) < 50 && green(color) < 50 && blue(color) < 50;
    }
}
