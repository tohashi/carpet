Hole hole;

void setup() {
  size(500, 500);
  background(255);
  noStroke();
  fill(0);
  smooth();
  
  float sqLength = width / 3;
  hole = new Hole(1, 0, 0, sqLength);
}

void draw() {
}

class Hole {
  float level, baseX, baseY, startX, startY, sqLength;
  Hole [] children = new Hole[9];
  
  Hole(float lev, float bx, float by, float sqLen) {
    level = lev;
    baseX = bx;
    baseY = by;
    startX = bx + sqLen;
    startY = by + sqLen;
    sqLength = sqLen;
    if (sqLength > 1) {
      createChild();
    }
    drawMe();
  }
  
  void createChild() {
    float nextSqLength = sqLength / 3;
    float bx, by;
    int count = 0;

    for (int i = 0; i < 3; i++) {
      by = baseX + (i * sqLength);
      for (int j = 0; j < 3; j++) {
        bx = baseY + (j * sqLength);
        children[count] = new Hole(level + 1, bx, by, nextSqLength);
        count += 1;
      }
    }
  }
  
  void drawMe() {
    noStroke();
    fill(0);
    rect(startX, startY, sqLength, sqLength);
  }
}
