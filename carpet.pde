Hole hole;
int stepCount = 100;

void setup() {
  size(500, 500);
  noStroke();
  fill(0);
  rectMode(CENTER);
  smooth();

  hole = new Hole(1, 0, 0, 0, width, height, width);
}

void draw() {
  background(255);
  hole.drawMe();
}

class Hole {
  float level, baseX, baseY, startX, startY;
  float lastStartX, lastStartY;
  float lastLength, currentLength, lengthVar;
  float drawLength = 0;
  float zoomX = 0;
  float zoomY = 0;
  float zoomLength = 0;
  int index;
  int drawStep = 0;
  boolean drawFlag = true;
  Hole[] children = new Hole[0];

  Hole(float lev, int idx, float bx, float by, float lsx, float lsy, float len) {
    level = lev;
    index = idx;
    baseX = bx;
    baseY = by;
    startX = baseX + len/2;
    startY = baseY + len/2;

    lastStartX = lsx;
    lastStartY = lsy;

    lastLength = len;
    currentLength = len / 3;
    lengthVar = currentLength / stepCount;

    if (level < 5 && idx != 4) {
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
        children[count] = new Hole(level + 1, count, nextBaseX, nextBaseY, startX, startY, currentLength);
        count += 1;
      }
    }
  }

  void drawMe() {

    if (drawLength <= currentLength) {
      drawLength += lengthVar;
      rect(startX, startY, drawLength, drawLength);
    } else {

      if (level != 1 && ++drawStep >= stepCount) {
        if (zoomLength + currentLength < lastLength) {
          zoomX += (lastStartX - startX) / stepCount;
          zoomY += (lastStartY - startY) / stepCount;
          zoomLength += (lastLength - currentLength) / stepCount;
        } else if (index != 0) {
          drawFlag = false;
        }
      }

      if (drawFlag) {
        rect(startX + zoomX, startY + zoomY, currentLength + zoomLength, currentLength + zoomLength);
      }

      for (int i = 0; i < children.length; i++) {
        if (children[i].index == 4) {
          continue;
        }
        children[i].drawMe();
      }
    }
  }
}

