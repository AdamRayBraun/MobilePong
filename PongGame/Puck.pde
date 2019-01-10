class Puck {
  //puck starts in middle of screen
  float x = height/2;
  float y = width/2;
  float r = 15;

  float xspeed;
  float yspeed;

  Puck() {
    reset();
  }

    // if puck hits paddle
    void checkPaddleOne(Paddle p) {
      if (y < p.y + p.h/2 &&
          y > p.y - p.h/2 &&
          x - r < p.x + p.w/2) {
            if (x > p.x) {
              xspeed *= -1;
            }
        }
      }

    void checkPaddleTwo(Paddle p) {
      if (y < p.y + p.h/2 &&
          y > p.y - p.h/2 &&
          x + r > p.x - p.w/2) {
            if (x < p.x) {
              xspeed *= -1;
            }
        }
      }


  void update(){
    x = x + xspeed;
    y = y + yspeed;
  }

  void reset() {
    x = width/2;
    y = height/2;
    float angle = random(-PI/4, PI/4);
    xspeed = 15 * cos(angle);
    yspeed = 15 * sin(angle);

    if (random(1) < 0.5) {
      xspeed *= -1;
    }
  }

  void edges() {
    // if puck hits floor or cieling reverse direction
    if (y < 0 || y > height) {
      yspeed *= -1;
    }

    // if player 1 scores
    if (x - r > width) {
      playerOneScore++;
      reset();
    }
    // if player 2 scores
    if (x + r < 0) {
      playerTwoScore++;
      reset();
    }
  }

  void show(){
    fill(255);
    ellipse(x,y,r*2,r*2);
  }
}
