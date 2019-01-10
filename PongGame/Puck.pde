class Puck {
  //puck starts in middle of screen
  float x = height/2;
  float y = width/2;
  float r = 15;

  float xspeed = 15;
  float yspeed = 15;

    // if puck hits paddle
    void checkPaddleOne(Paddle p) {
      //  puck position in paddle y position
      if (y < p.y + p.h/2 &&
          y > p.y - p.h/2 &&
          x - r < p.x + p.w/2) {
            xspeed *= -1;
        }
      }

    void checkPaddleTwo(Paddle p) {
      //  puck position in paddle y position
      if (y < p.y + p.h/2 &&
          y > p.y - p.h/2 &&
          x + r > p.x - p.w/2) {
            xspeed *= -1;
        }
      }


  void update(){
    x = x + xspeed;
    y = y + yspeed;
  }

  void reset() {
    x = width/2;
    y = height/2;
  }

  void edges() {
    // if puck hits floor or cieling reverse direction
    if (y < 0 || y > height) {
      yspeed *= -1;
    }

    // if player 1 scores
    if (x > width) {
      reset();
    }
    // if player 2 scores
    if (x < 0) {
      reset();
    }
  }

  void show(){
    fill(255);
    ellipse(x,y,r*2,r*2);
  }
}
