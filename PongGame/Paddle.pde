class Paddle {
  float x;
  float y = height/2;
  float w = 100;
  float h = 500;

  float ychange= 0;

  Paddle(int playerNumber) {
    // paddle positioning
    if (playerNumber == 1) {
      x = w;
    } else {
      x = width - w;
    }
  }

  void update(){
    y += ychange;
    y = constrain(y, h/2, height);
  }

  void move(float steps) {
    ychange = steps;
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
}
