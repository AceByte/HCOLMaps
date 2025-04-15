class ColorDetector {
    PImage image;
    HashMap<String, ArrayList<PVector>> colorLocations;

    ColorDetector(PImage image) {
        this.image = image;
        this.colorLocations = new HashMap<>();
        this.colorLocations.put("Red", new ArrayList<>());
        this.colorLocations.put("Green", new ArrayList<>());
        this.colorLocations.put("Blue", new ArrayList<>());
        this.colorLocations.put("Black", new ArrayList<>());
    }

    void detectColors() {
        if (image == null) {
            println("No image loaded for color detection.");
            return;
        }

        image.loadPixels();
        for (int y = 0; y < image.height; y++) {
            for (int x = 0; x < image.width; x++) {
                int loc = x + y * image.width;
                color col = image.pixels[loc]; // Renamed variable to 'col'

                if (isRed(col)) {
                    colorLocations.get("Red").add(new PVector(x, y));
                } else if (isGreen(col)) {
                    colorLocations.get("Green").add(new PVector(x, y));
                } else if (isBlue(col)) {
                    colorLocations.get("Blue").add(new PVector(x, y));
                } else if (isBlack(col)) {
                    colorLocations.get("Black").add(new PVector(x, y));
                }
            }
        }

        printResults();
    }

    boolean isRed(color col) {
        return red(col) > 150 && green(col) < 100 && blue(col) < 100;
    }

    boolean isGreen(color col) {
        return green(col) > 150 && red(col) < 100 && blue(col) < 100;
    }

    boolean isBlue(color col) {
        return blue(col) > 150 && red(col) < 100 && green(col) < 100;
    }

    boolean isBlack(color col) {
        return red(col) < 50 && green(col) < 50 && blue(col) < 50;
    }

    void printResults() {
        for (String colorName : colorLocations.keySet()) {
            println(colorName + " locations: " + colorLocations.get(colorName).size());
            for (PVector loc : colorLocations.get(colorName)) {
                println(colorName + " at (" + loc.x + ", " + loc.y + ")");
            }
        }
    }

    void highlightColors(PGraphics pg) {
        pg.beginDraw();
        pg.image(image, 0, 0);

        for (PVector loc : colorLocations.get("Red")) {
            pg.fill(255, 0, 0);
            pg.noStroke();
            pg.ellipse(loc.x, loc.y, 5, 5);
        }

        for (PVector loc : colorLocations.get("Green")) {
            pg.fill(0, 255, 0);
            pg.noStroke();
            pg.ellipse(loc.x, loc.y, 5, 5);
        }

        for (PVector loc : colorLocations.get("Blue")) {
            pg.fill(0, 0, 255);
            pg.noStroke();
            pg.ellipse(loc.x, loc.y, 5, 5);
        }

        for (PVector loc : colorLocations.get("Black")) {
            pg.fill(0);
            pg.noStroke();
            pg.ellipse(loc.x, loc.y, 5, 5);
        }

        pg.endDraw();
    }
}