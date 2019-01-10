int wideCount = 64;
int highCount = 64;
int unit;
int count;
Panel[] panels;
Puck puck;

// player 1 is left paddle / 2 is right
Paddle playerOne;
Paddle playerTwo;

void setup() {
  size(2000, 2000);

  // find size of a Panel
  unit = width / wideCount;
  // total amount of panels = 64*64
  count = wideCount * highCount;
  panels = new Panel[count];

  // create grid of panels
  int index = 0;
  for (int y = 0; y < highCount; y++) {
    for (int x = 0; x < wideCount; x++) {
      panels[index++] = new Panel(x*unit, y*unit, unit/2, unit/2, unit);
    }
  }

  puck = new Puck();

  playerOne = new Paddle(1);
  playerTwo = new Paddle(2);
}


void draw() {
  background(0);
  for (Panel panel : panels) {
    panel.update();
    panel.show();
  }

  puck.checkPaddleOne(playerOne);
  puck.checkPaddleTwo(playerTwo);

  playerOne.show();
  playerTwo.show();
  playerOne.update();
  playerTwo.update();


  puck.update();
  puck.edges();
  puck.show();
}

void keyReleased(){
  playerOne.move(0);
  playerTwo.move(0);

}

void keyPressed(){
  if (key == 'a') {
    playerOne.move(-10);
  } else if ( key =='z') {
    playerOne.move(10);
  }

  if (key == 's') {
    playerTwo.move(-10);
  } else if ( key =='x') {
    playerTwo.move(10);
  }
}
