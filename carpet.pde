Hole hole;

void setup() {
  size(500, 500);
  noStroke();
  fill(0);
  rectMode(CENTER);
  smooth();
  
  hole = new Hole(1, 0, 0, width);
  hole.drawMe();
}

void draw() {
  //background(255);
  //hole.drawMe();
}

class Hole {
  float level, baseX, baseY, startX, startY, lastLength, sqLength;
  Hole[] children = new Hole[0];
  
  Hole(float lev, float bx, float by, float sqLen) {
    level = lev;
    baseX = bx;
    baseY = by;
    startX = baseX + sqLen/2;
    startY = baseY + sqLen/2;
    lastLength = sqLen;
    sqLength = sqLen / 3;
    if (sqLength > 1) {
      createChild();
    }
  }
  
  void createChild() {
    float bx, by;
    int count = 0;
    children = new Hole[9];

    for (int i = 0; i < 3; i++) {
      by = baseY + (i * sqLength);
      for (int j = 0; j < 3; j++) {
        bx = baseX + (j * sqLength);
        children[count] = new Hole(level + 1, bx, by, sqLength);
        count += 1;
      }
    }
  }
  
  void drawMe() {
    rect(startX, startY, sqLength, sqLength);

    for (int i = 0; i < children.length; i++) {
      children[i].drawMe();
    }
  }
}
