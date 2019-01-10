class Panel {
  int xOffset;
  int yOffset;
  float x, y;
  int unit;

  // Contructor
  Panel(int xOffsetTemp, int yOffsetTemp, int xTemp, int yTemp, int tempUnit) {
    xOffset = xOffsetTemp;
    yOffset = yOffsetTemp;
    x = xTemp;
    y = yTemp;
    unit = tempUnit;
  }

  void update() {
  }

  void show() {
    fill(0);
    stroke(255);
    rect(xOffset + x, yOffset + y, unit, unit);
  }
}
