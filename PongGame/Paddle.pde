class Paddle {
  float x;
  float y = height/2;
  float w;
  float h;

  float ychange= 0;

  Paddle(int playerNumber, int unit) {
    // paddle positioning
    w = unit * 3;
    h = unit * 20;
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
