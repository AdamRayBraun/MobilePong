# MobilePong

## Getting Started

### 1. Run local spacebrew server
MobilePong uses a [spacebrew](http://docs.spacebrew.cc/) local server to connect the mobile paddle interface with the processing game.

* Download [spacebrew repo](https://github.com/Spacebrew/spacebrew)
* In a terminal navigate to spacebrew folder
* Install NPM dependencies
  * `$ npm install`
* While still in the spacebrew base directory, run the Server
  * `node node_server_forever.js`

### 2. Host web interface on local Server

The websites need to be hosted on a local server to be access by the mobile paddles. There are countless methods for this but I found success using XAMPP (and turning my firewall off). Avoid hosting on port 9000 as that is being used by the local spacebrew admin.

### 3. Open MobilePong

The main game can be found in `MobilePong/PongGame/PongGame.pde`

### 4. Connect players

On separate devices navigate to the locally hosted folder and open the welcome page:
`web/PongConnection.html`

## Troubleshooting

If your paddle is not connecting check the spacrebrew admin at `localhost:9000`
With two players successfully connected it should appear as so:
[alt text](https://github.com/AdamRayBraun/MobilePong/blob/master/Spacrebrew%20example.png "Spacebrew connection example")


## My challenge:

Develop a pong game in Processing: sound easy right ?
There a couple of catches: let's use a 64 x 64 pixels grayscale panel as a display and play with smart phones.

The bare minimum requirements are to build a pong game with:
* a home screen: has "start" and "high score" buttons
* a game screen: main pong game
* a high score/enter name screen
displays top 10 scores
if the winner's current score is higher than any of the existing scores (initialised with 0),
then a name can be entered at the right index (up to 3 characters long)

This can be done with key presses at this stage.

Next level developing a minimal web interface to allow users to join a game and play:
to join a game users will enter an IP address and press a "connect" button
the server will reply with an OK message if there are none or just 1 other player,
otherwise the interface will display a "game in progress, please wait" message
if there's only one player he/she will wait until a second player joins
once both players are in they stream a message containing the player ID (e.g. player one or player two) and the paddle position

## To Do
### ( in order of importance ):

* ~~Basic pong game logic~~
* ~~Splitting game into home/play/highscore screens~~
* displaying game in grayscale panels
* ~~Having winning scores update highscore list~~ (does pong create highscores?)
* ~~Connecting processing server with mobile clients via spacebrew~~
* ~~having two mobiles control both paddles simultaneously~~

* ~~update README with instructions for use / explanation of progress~~

Bonus points
* Input from mobile accelerometer
* animations / special effects
* sound
