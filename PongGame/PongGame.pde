import spacebrew.*;
String server="192.168.0.28";
String name="Pong Game";
String description ="Pong Server";
Spacebrew sb;
String playerOneInput = "player1_slider";
String playerTwoInput = "player2_slider";
boolean playerOneConnection = false;
boolean playerTwoConnection = false;
int numberOfPlayers = 0;
int counter = millis();

boolean keyboardDebugging = true;

// Panel vars
int wideCount = 64;
int highCount = 64;
int unit;
int count;
Panel[] panels;

//puck
Puck puck;

// Paddles
//player 1 is left paddle / 2 is right
Paddle playerOne;
Paddle playerTwo;

//High scores
HighScore[] highScores;

// game logic vars
int playerOneScore = 0;
int playerTwoScore = 0;
int mostRecentWinner;
int maxPoints = 5;
boolean startSelected = true;
boolean homeSelected = true;


// 0 home screen
// 1 pong game
// 2 game over
// 3 highscore
int gameMode = 0;


void setup() {
  size(1024, 1024);

  // instantiate the spacebrewConnection variable
	sb = new Spacebrew( this );
  // declare your subscribers
  sb.addSubscribe( playerOneInput, "range" );
  sb.addSubscribe( playerTwoInput, "range" );
  sb.addSubscribe( "playerOneConnected", "boolean");
  sb.addSubscribe( "playerTwoConnected", "boolean");
  sb.addPublish( "numberOfPlayers", "range", 0);
	sb.connect(server, name, description );

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

  // initiate high score array with zeros
  highScores = new HighScore[10];
  for (int x=0; x<10; x++) {
    highScores[x] = new HighScore("NUN", 0);
  }


  puck = new Puck();

  playerOne = new Paddle(1, unit);
  playerTwo = new Paddle(2, unit);
}


void draw() {
  background(0);
  for (Panel panel : panels) {
    panel.update();
    panel.show();
  }

  switch(gameMode){
    case 0:
      // HOME SCREEN
      textSize(80);
      if (startSelected == true) {
        fill(255);
      } else {
        fill(150);
      }
      textAlign(CENTER,CENTER);
      text("Start", width/2,height/2);
      textSize(50);
      if (startSelected == false) {
        fill(255);
      } else {
        fill(150);
      }
      text("High Scores", width/2,height/2 + 100);
      break;

    case 1:
      // PONG GAME
      puck.checkPaddleOne(playerOne);
      puck.checkPaddleTwo(playerTwo);

      playerOne.show();
      playerTwo.show();
      playerOne.update();
      playerTwo.update();


      puck.update();
      puck.edges();
      puck.show();

      //scores
      fill(255);
      textSize(40);
      text(playerOneScore, 10, 40);
      text(playerTwoScore, width - 60, 40);

      if (playerOneScore == maxPoints) {
        mostRecentWinner = 1;
        gameMode = 2;
        playerOneScore = 0;
        playerTwoScore = 0;
      } else if (playerTwoScore == maxPoints) {
        mostRecentWinner = 2;
        gameMode = 2;
        playerOneScore = 0;
        playerTwoScore = 0;
      }
      break;

    case 2:
      // GAME OVER
      fill(255);
      textSize(100);
      textAlign(CENTER,CENTER);
      String winningMessage = "Player " + mostRecentWinner + " wins!";
      text(winningMessage, width/2, height/4);
      textSize(80);
      if (homeSelected == true) {
        fill(255);
      } else {
        fill(150);
      }
      text("Home", width/2, height/2);
      if (homeSelected == false) {
        fill(255);
      } else {
        fill(150);
      }
      text("High Scores", width/2, height/2 + 150);
      break;

    case 3:
      // HIGHSCORES
      fill(255);
      text("High scores", width/2, 40);
      textSize(30);
      for (int x = 0; x<10; x++) {
        int highScoreIndex = x+1;
        String highScoreMessage = highScoreIndex + "  " + highScores[x].name + "  " + highScores[x].score;
        text(highScoreMessage, width/2, x*90 + 110);
      }
      break;
  }

  if (millis() > counter + 1000){
    broadcastConnections();
    counter = millis();
  }
}

// Spacebrew websocket inputs
void onRangeMessage( String name, int value ){
  if (name.equals(playerOneInput) == true) {
    playerOne.slide(value);
  } else if (name.equals(playerTwoInput) == true) {
    playerTwo.slide(value);
  }
}

void onBooleanMessage( String name, boolean value) {
  println("from " + name + " val " + value);
  if (name.equals("playerOneConnected") == true) {
    playerOneConnection = value;
  } else if (name.equals("playerTwoConnected") == true) {
    playerTwoConnection = value;
  }
}

void broadcastConnections(){
  // TODO find more elegant solution for this filthy hack
  if (playerOneConnection == false && playerTwoConnection == false){
    numberOfPlayers = 0;
  } else if (playerOneConnection == true && playerTwoConnection == false){
    numberOfPlayers = 1;
  } else if (playerOneConnection == true && playerTwoConnection == true){
    numberOfPlayers = 2;
  } else if (playerOneConnection == false && playerTwoConnection == true){
    numberOfPlayers = 10;
  }
  sb.send("numberOfPlayers", numberOfPlayers);
}

// Keyboard inputs
void keyReleased(){
  if (keyboardDebugging == true) {
    playerOne.move(0);
    playerTwo.move(0);
  }
}
void keyPressed(){
  // welcome screen gameMode
  if (gameMode == 0) {
    // toggle between start and highscore buttons
    if (key == CODED) {
      if (keyCode == UP || keyCode == DOWN) {
        if (startSelected == true){
          startSelected = false;
        } else {
          startSelected = true;
        }
      }
    }
    if (key == ENTER) {
      if (startSelected == true) {
        gameMode = 1;
      } else {
        gameMode = 3;
      }
    }
    // pong game gameMode
  } else if (gameMode == 1){
    if (keyboardDebugging == true) {
      if (key == 'a') {
        playerOne.move(-20);
      } else if ( key =='z') {
        playerOne.move(20);
      }

      if (key == 's') {
        playerTwo.move(-20);
      } else if ( key =='x') {
        playerTwo.move(20);
      }
    }
  }
  // game over screen
  else if (gameMode == 2) {
    if (key == CODED) {
      if (keyCode == UP || keyCode == DOWN) {
        if (homeSelected == true){
          homeSelected = false;
        } else {
          homeSelected = true;
        }
      }
    }
    if (key == ENTER) {
      if (homeSelected == true) {
        gameMode = 0;
      } else {
        gameMode = 3;
      }
    }
  }
  else if (gameMode == 3) {
    if (key == ENTER) {
      gameMode = 0;
    }
  }
}
