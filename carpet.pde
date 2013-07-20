Hole hole;

void setup() {
  size(500, 500);
  noStroke();
  fill(0);
  rectMode(CENTER);
  smooth();

  hole = new Hole(1, 0, 0, 0, width);
}

void draw() {
  background(255);
  hole.drawMe();
}

class Hole {
  float level, baseX, baseY, startX, startY;
  float lastLength, currentLength, lengthVar;
  float drawLength = 0;
  int index;
  boolean zooming = true;
  Hole[] children = new Hole[0];

  Hole(float lev, int idx, float bx, float by, float len) {
    level = lev;
    index = idx;
    baseX = bx;
    baseY = by;
    startX = baseX + len/2;
    startY = baseY + len/2;
    lastLength = len;
    currentLength = len / 3;
    lengthVar = currentLength / 100;

    if (currentLength > 1 && idx != 4) {
      createChild();
    }
  }

  void createChild() {
    float nextBaseX, nextBaseY;
    int count = 0;
    children = new Hole[9];

    for (int i = 0; i < 3; i++) {
      nextBaseY = baseY + (i * currentLength);
      for (int j = 0; j < 3; j++) {
        nextBaseX = baseX + (j * currentLength);
        children[count] = new Hole(level + 1, count, nextBaseX, nextBaseY, currentLength);
        count += 1;
      }
    }
  }

  void drawMe() {
    if (drawLength <= currentLength) {
      drawLength += lengthVar;
      rect(startX, startY, drawLength, drawLength);
    } else {
      rect(startX, startY, currentLength, currentLength);
      for (int i = 0; i < children.length; i++) {
        if (children[i].index == 4) {
          continue;
        }
        children[i].drawMe();
      }
    }
  }
}

