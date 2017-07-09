// Ryan Merkley  r2merkle

float [] XposButton = new float [2]; // x position of menu button
float [] YposButton = new float [2]; // y position of menu button
float [] XposMButton = new float [1]; // x position of return button
float [] YposMButton = new float [1]; // y position of return button
int selected = -1; // state of the game
int menuselected = -1; // state of mouse pressed
boolean Buttons1 = true; // turns menu buttons on or off
boolean Buttons2 = true; // turns return button on or off
PImage sadFace;
PImage happyFace; 
int lives = 3; // (USES BEST USE OF "GLOBAL VARIABLES") lives for turtle
int counter = 0; // score of the game
int minRandom = 100; // minimum value for object sizes
int maxRandom = 150; // maximum value for object sizes
int TurtleStartingXpos = 250; // turtles starting x position 
int TurtleStartingYpos = 565; // turtles starting y position
Car[] Cars = new Car[7]; // array of cars
Van[] Vans = new Van[4]; // array of vans
Log[] Logs = new Log[8]; // array of logs
turtle TurtleChar; // object for the turtle

void setup() {
  size(500, 630);
  colorMode(HSB, 360, 100, 100, 100);

  MainMenu(); // draws main menu
  starter(); // initializes all arrays

  // loads both images
  happyFace = loadImage("happyFace.png");
  sadFace = loadImage("Sface.png");
}

// initialzes all starting postions, speeds, colors, and sizes for all arrays
void starter() {
  TurtleChar = new turtle(TurtleStartingXpos, TurtleStartingYpos); // starting position of turtle

  // (USES BEST USE OF "USER DEFINED OBJECTS")
  // sets all starting positions, speeds, and random sizes for logs
  Logs[0] = new Log(25, 55, 3, random(minRandom, maxRandom));
  Logs[1] = new Log(300, 55, 3, random(minRandom, maxRandom));
  Logs[2] = new Log(150, 205, 3, random(minRandom, maxRandom));
  Logs[3] = new Log(550, 205, 3, random(minRandom, maxRandom));
  Logs[4] = new Log(160, 105, -3, random(minRandom, maxRandom));
  Logs[5] = new Log(550, 105, -3, random(minRandom, maxRandom));
  Logs[6] = new Log(25, 155, -2, random(minRandom, maxRandom));
  Logs[7] = new Log(400, 155, -2, random(minRandom, maxRandom));

  // sets all starting positions, speeds, and colors for cars
  Cars[0] = new Car(50, 300, 3, random(0, 255));   
  Cars[1] = new Car(300, 300, 3, random(0, 255)); 
  Cars[2] = new Car(200, 400, 3, random(0, 255));       
  Cars[3] = new Car(400, 400, 3, random(0, 255));
  Cars[4] = new Car(100, 500, 4, random(0, 255));
  Cars[5] = new Car(300, 500, 4, random(0, 255));
  Cars[6] = new Car(500, 500, 4, random(0, 255));

  // sets all starting positions, speeds, and colors for vans
  Vans[0] = new Van(250, 350, 3, random(0, 255));   
  Vans[1] = new Van(0, 450, 4, random(0, 255));
  Vans[2] = new Van(500, 350, 3, random(0, 255));   
  Vans[3] = new Van(200, 450, 4, random(0, 255));
}

void draw() {
  // runs the entire game once the user leaves the main menu. 
  if (selected == 0) {
    // disables all menu buttons  
    Buttons1 = false;
    Buttons2 = false;

    GameBackground(); // draws background

    // displays the score counter and turtles lives
    textSize(32);
    fill(#FF0303); // red text
    text(lives, width - 30, height - 10); // lives value
    text(counter, 100, height - 10); // counter value

    fill(0); // black text
    text("Lives:", width - 120, height - 10);
    text("Score:", 5, height - 10);

    TurtleChar.display(); // draws turtle

    // draws and moves all cars
    for (int i = 0; i < Cars.length; i++) {
      Cars[i].move();
      Cars[i].draw();
    }

    // draws and moves all vans
    for (int i = 0; i < Vans.length; i++) {
      Vans[i].move();
      Vans[i].draw();
    }

    // draws and moves all logs
    for (int i = 0; i < Logs.length; i++) {
      Logs[i].move();
      Logs[i].draw();
    }
  }

  // changes display of menu when main menu buttons are pressed 
  if (selected == 1) {
    background(255); // gray background
    HowToPlay(); // displays how to play menu
  }

  // changes display of menu when return button is pressed
  if (menuselected == 0) {
    background(255); // gray background
    MainMenu(); // displays main menu
  }

  // updates state of game when the turtle cross the top of the canvas
  if (TurtleChar.TurtleY < 1) {
    counter = counter + 1; // increases score

    // resets the turtles x and y positions 
    TurtleChar.TurtleX = TurtleStartingXpos;
    TurtleChar.TurtleY = TurtleStartingYpos;
  }

  // ends game when user runs out of lives
  if (lives == 0) {
    background(0); // black background

    // displays text to notify the user they lost the game
    fill(360); // white text
    textSize(50);
    text("GAME OVER!", 100, height / 2);
    textSize(20);
    text("Press the spacebar to play again.", 100, height / 2 + 20);

    image(sadFace, 125, 10, 250, 250); // sad face image

    // resets the turtles position
    TurtleChar.TurtleX = TurtleStartingXpos;
    TurtleChar.TurtleY = TurtleStartingYpos;
  }

  // ends game when user achieves max score
  if (counter == 5) {
    background(0); // black background

    // displays text to notify user they won the game
    fill(360); // white text
    textSize(50);
    text("WINNER!", 150, height / 2);
    textSize(20);
    text("Press the spacebar to play again.", 90, height / 2 + 20);

    // (USES BEST USE OF "LOAD AND DISPLAY IMAGES")
    image(happyFace, 125, 10, 250, 250); // happy face image

    // resets the turtles position
    TurtleChar.TurtleX = TurtleStartingXpos;
    TurtleChar.TurtleY = TurtleStartingYpos;
  }
}

void keyPressed() {
  // (USES BEST USE OF "EVENT FUNCTIONS")
  // moves turtle in different directions only if the game if running,
  // score isn't max level, and turtle has lives left
  if (selected == 0 && counter < 5 && lives > 0 && key == 'd') {
    TurtleChar.MoveRight(); // moves turtle to the right

    // restricts turtle to stay within the right side of the canvas
    if (TurtleChar.TurtleX > width - 17) {
      TurtleChar.TurtleX = width - 17;
    }
  } else if (selected == 0 && counter < 5 && lives > 0 && key == 'a') {
    TurtleChar.MoveLeft(); // moves turtle to the left
    
    // restricts turtle to stay within the left side of the canvas
    if (TurtleChar.TurtleX < 17) {
      TurtleChar.TurtleX = 17;
    }
  } else if (selected == 0 && counter < 5 && lives > 0 && key == 's') {
    TurtleChar.MoveDown(); // moves turtle down

    // restricts turtle to stay within the bottom of the canvas
    if (TurtleChar.TurtleY > TurtleStartingYpos) {
      TurtleChar.TurtleY = TurtleStartingYpos;
    }
  } else if (selected == 0 && counter < 5 && lives > 0 && key == 'w') {
    TurtleChar.MoveUp(); // moves the turtle up
  }

  // resets game and all game variables when the spacebar is pressed
  if (lives == 0 && key == ' ') {
    // resets game variables and draws background
    counter = 0;
    lives = 3;
    GameBackground();
  } else if (counter == 5 && key == ' ') {
    counter = 0;
    lives = 3;
    GameBackground();
  }
}

void mousePressed() {
  // when game is running, menu variables dont change
  if (selected != 0) {
    selected = -1; 
    menuselected = -1;
  }

  // (USES BEST USE OF "LOOPS")
  // enables how to play menu when menu button is pressed
  if (Buttons1 == true) {
    for (int i = 0; i < 2; i++) {
      // checks if mouse position is inside the button and selects it
      if (hitTest(mouseX, mouseY, XposButton[i], YposButton[i], 200, 100)) {
        selected = i; // changes state of the game
        Buttons1 = false; // turns off menu buttons
        Buttons2 = true; // turns on return buttons
      }
    }
  }

  // enables main menu when return button is pressed
  if (Buttons2 == true) {
    for (int i = 0; i < XposMButton.length; i++) {
      // checks to see if the mouse selects an image and its position is inside the image
      if (hitTest(mouseX, mouseY, XposMButton[i], YposMButton[i], 100, 40)) {
        menuselected = i; // changes state of the game
        Buttons1 = true; // turns on menu buttons
        Buttons2 = false; // turns off return button
      }
    }
  }
}

// creates menu buttons. It takes in an x coordinate and y coordinate for the position of the button
void MenuButton(float x, float y) {
  fill(#032AFF, 100); // transparent blue
  noStroke();
  rect(x, y, 200, 100); // creates button
}

// creates return button. It takes in an x and y coordinate for the position on the canvas 
void ReturnToMenuButton(float x, float y) {
  fill(#032AFF, 100); // transparent blue
  noStroke();
  rect(x, y, 100, 40); // creates button
}

// creates the layout of buttons and design of the main menu
void MainMenu() {
  background(200); // gray background

  // spaces and positions the buttons within the main menu 
  for (int i = 0; i < XposButton.length; i++) {
    XposButton[i] = 150; // x coordinate of buttons
    YposButton[i] = 150 + i * width / (YposButton.length * 2); // y coordinate of buttons
  }

  // displays buttons within the canvas
  for (int i = 0; i < XposButton.length; i++) { 
    MenuButton(XposButton[i], YposButton[i]); // draws buttons based off specified coordinates
  }

  // displays title of game and name of buttons
  textSize(32);
  fill(0); // black text
  text("The Adventures of Mr. Turtle", 25, 80);
  text("Play Game", 170, 210);
  text("How to Play", 160, 335);
}

// creates the layout of buttons and design for the How To Play menu 
void HowToPlay() {
  background(200); // gray background

  // sets the starting positions and spacing for the button
  for (int i = 0; i < XposMButton.length; i++) {
    XposMButton[i] = 3; // x coordinate of button
    YposMButton[i] = height - 43; // y coordinate of button
  }

  // displays the button within canvas
  for (int i = 0; i < XposMButton.length; i++) {
    ReturnToMenuButton(XposMButton[i], YposMButton[i]); // draws button based off specified parameters
  }

  // displays names of buttons, and functionality of the game 
  textSize(32);
  fill(0); // black text
  text("How To Play:", 145, 35);

  textSize(20);
  text("Instructions:", 10, 68);
  text("Controls:", 10, 208);
  text("Objective:", 10, 338);

  textSize(15);
  text("Main Menu", 10, height - 17);

  text("You are a turtle and you must escape an obstacle course in order", 10, 85);
  text("to get home safely. There are two sections you must cross. The", 10, 100);
  text("first section is a highway with lots of speeding cars. The second", 10, 115);
  text("section is a lake filled with tree logs that you must dodge. The", 10, 130);
  text("water will not kill you but, the tree logs will (don't jump on them!)", 10, 145);
  text("Can you help Mr. Turtle get home safely?", 10, 160);

  text("W key = Move Up", 10, 225);
  text("S key = Move Down", 10, 240);
  text("A key = Move Left", 10, 255);
  text("D key = Move Right", 10, 270);
  text("Spacebar = Restart Game", 10, 285);

  text("Mr. Turtle will start at the bottom of the screen and you must", 10, 355);
  text("complete the course 5 times in a row in order to win the game.", 10, 370);
  text("You are only given 3 lives to complete this objective otherwise you", 10, 385);
  text("will have to start over from the beginning.", 10, 400);
}

// (USES BEST USE OF FUNCTIONS) creates a turtle, sets its starting positions, and its ability to move
class turtle { 
  // turtle properties
  float TurtleX; // x coordinates
  float TurtleY; // y coordinates
  float Jump = 49; // spacing for turtles jump 

  // constructor that initializes the turtle properties. It takes in a x and y coordinate
  turtle(float TurtleXpos, float TurtleYpos) {
    TurtleX = TurtleXpos;
    TurtleY = TurtleYpos;
  }

  // draws the turtle
  void display() {
    stroke(0); // black outline

    // legs
    fill(#0B790F); // light green  
    ellipse(TurtleX - 12, TurtleY - 10, 10, 10);
    ellipse(TurtleX + 12, TurtleY - 10, 10, 10);
    ellipse(TurtleX - 12, TurtleY + 10, 10, 10);
    ellipse(TurtleX + 12, TurtleY + 10, 10, 10);
    ellipse(TurtleX, TurtleY - 15, 10, 10); // head

    // body
    fill(#11AD17); // dark green
    ellipse(TurtleX, TurtleY, 25, 30); // shell

    // shell dots
    ellipse(TurtleX - 5, TurtleY + 5, 5, 5); 
    ellipse(TurtleX + 5, TurtleY + 5, 5, 5); 
    ellipse(TurtleX + 5, TurtleY - 5, 5, 5); 
    ellipse(TurtleX - 5, TurtleY - 5, 5, 5);
  }

  // creates functions for the movement of the turtle
  void MoveUp() {
    TurtleY= TurtleY - Jump; // moves turtle upwards
  }

  void MoveDown() {
    TurtleY= TurtleY + Jump; // moves turtle downwards
  }

  void MoveLeft() {
    TurtleX= TurtleX - Jump; // moves turtle to the left
  }

  void MoveRight() {
    TurtleX= TurtleX + Jump; // moves turtle to the right
  }
}

// creates a car, moves the car, and updates the game when it intersects with the turtle
class Car {
  // car properties
  float x; // x coordinate
  float y; // y coordinate
  float hue; // color
  float speed; // speed

  // constructor that initializes the car properties. It takes in a x and y coordinate, color, and speed
  Car(float xIn, float yIn, float speedIn, float hueIn) {
    x = xIn;
    y = yIn;
    hue = hueIn;
    speed = speedIn;
  }

  // car action: moves car according to speed
  void move() {
    x = x + speed; // moves car to the right

    // car starts at left side and moves to the right
    if (x > width + 50) {
      x = -50; // places car back at left side
      hue = random(0, 255); // randomizes color of the car
    }

    // (USES BEST USE OF CONDITIONALS)
    // checks to see if car intersects with the turtle. takes in the 
    // turtles and cars x and y coordinates, width and height of car
    if (hitTest(TurtleChar.TurtleX, TurtleChar.TurtleY, x, y, 60, 40)) {
      // moves turtle back to the start
      TurtleChar.TurtleX = TurtleStartingXpos;
      TurtleChar.TurtleY = TurtleStartingYpos;

      lives = lives - 1; // subtracts a life
    }
  }

  // car action: draws car
  void draw() {
    stroke(0); // black outline

    // wheels
    fill(190); // gray 
    ellipse(x + 10, y, 15, 15);
    ellipse(x + 50, y, 15, 15);
    ellipse(x + 10, y + 30, 15, 15);
    ellipse(x + 50, y + 30, 15, 15);

    // body
    fill(hue, 100, 100); // random color
    rect(x, y, 60, 30);

    // engine and window
    fill(0); // black
    triangle(x + 40, y + 5, x + 40, y + 25, x + 55, y + 15);
    rect(x + 10, y + 10, 5, 10);
    rect(x + 20, y + 10, 5, 10);
  }
}

// creates a van, moves the van, and updates the game when it intersects with the turtle
class Van {
  // van properties
  float x; // x position
  float y; // y position
  float hue; // color
  float speed; // speed

  //constructor that initializes the vans properties. It takes in a x and y coordinate, color, and speed
  Van(float xIn, float yIn, float speedIn, float hueIn) {
    x = xIn;
    y = yIn;
    hue = hueIn;
    speed = speedIn;
  }

  // van action: moves van according to speed
  void move() {
    x = x - speed;  // moves the van leftward

    // car starts at right side and moves to the left
    if (x < -80) {
      x = width + 50; // places car on right side
      hue = random(0, 255); // randomizes color of van
    }

    // checks to see if van intersects with turtle. takes in the turtles
    // and cars x and y coordinates, width and height of van
    if (hitTest(TurtleChar.TurtleX, TurtleChar.TurtleY, x, y, 80, 20)) {
      // moves the turtle back to the start
      TurtleChar.TurtleX = TurtleStartingXpos;
      TurtleChar.TurtleY = TurtleStartingYpos;

      lives = lives - 1; // subtracts a life
    }
  }

  // van action: draws van
  void draw() {
    stroke(0); // black outline

    // wheels
    fill(190); // gray
    ellipse(x + 10, y, 15, 15);
    ellipse(x + 70, y, 15, 15);
    ellipse(x + 10, y + 30, 15, 15);
    ellipse(x + 70, y + 30, 15, 15);

    // body
    fill(hue, 100, 110); // random color
    rect(x, y, 80, 30);

    // roof and window
    noFill();
    rect(x + 30, y + 5, 45, 20);

    fill(0); // black window
    quad(x + 5, y + 10, x + 5, y + 20, x + 25, y + 25, x + 25, y + 5);
  }
}

// draws the background for the game
void GameBackground() {
  noStroke();

  fill(#3DA244); // green
  rect(0, 535, width, 50); // starting zone for turtle
  rect(0, 245, width, 60); // safe zone (middle)
  rect(0, 0, width, 50); // end/winning zone

  fill(120); // dark gray
  rect(0, 290, width, 250);  // car road

  fill(250); // light gray
  rect(0, 585, width, 50); // score section

  fill(#4151DE); // blue
  rect(0, 50, width, 195);  // lake
}

// (USES BEST USE OF "RECTANGLE HIT TEST")
// calculates the distance from one object to another. takes in the first and second 
// objects x and y coordinates, and the width and height of the second object
boolean hitTest(float x, float y, float rx, float ry, float rw, float rh) {
  // the hit test checks to see if the object intersects with the other object
  if (x >= rx && x <= rx + rw && y >= ry && y <= ry + rh) {
    return true; // returns true in both objects collide
  } else {
    return false; 
  }
}

// creates a tree log, moves the log, and updates the game when it intersects with the turtle
class Log {
  // log properties
  float x; // x coordinate
  float y; // y coordinate
  float speed; // speed
  float size; // size

  // constructor that initializes the log properties. It takes in a x and y coordinate, speed, and size
  Log(float xIn, float yIn, float speedIn, float sizeIn) {
    x = xIn;
    y = yIn;
    speed = speedIn;
    size = sizeIn;
  }

  // log action: moves log according to speed
  void move() {
    x = x + speed; // move log rightward

    // updates log position if it hits the far right or left of the screen 
    if (x > width) {
      x = -150; // places log on left side
      size = random(minRandom, maxRandom); // randomizes size
    } else if (x < 0 - 150) {
      x = width; // places log on right side
      size = random(minRandom, maxRandom); // randomizes size
    }

    // checks to see if log intersects with turtle. takes in the turtles
    // and logs x and y coordinates, and logs width and height
    if (hitTest(TurtleChar.TurtleX, TurtleChar.TurtleY, x, y, size, 20)) {
      // moves the turtle back to the start
      TurtleChar.TurtleX = TurtleStartingXpos; 
      TurtleChar.TurtleY = TurtleStartingYpos;

      lives = lives - 1; // subtracts a life
    }
  }

  // log action: draws log
  void draw() {
    stroke(0); // black outline

    fill(#8B4513); // brown
    rect(x, y, size, 30, 7); // body of log

    // log indents
    line(x + 5, y + 5, x + size - 5, y + 5);
    line(x + 5, y + 15, x + size - 5, y + 15);
    line(x + 5, y + 25, x + size - 5, y + 25);
  }
}

/*
VIDEO
https://vimeo.com/193750044

INSTRUCTIONS
You are a turtle named Mr. Turtle and you must escape an obstacle course in order to 
get home safely. There are two sections that you must cross in each level. The first section
is a highway full of fast moving and speeding cars. The second section is a lake filled 
with tree logs that you must dodge. The water doesn't kill you in this game, rather you
use it to move through the lake. Don't jump onto the logs as they will kill you. 
You start at the bottom of the canvas and must complete each the sections 5 times in a row 
in order to win the game. You are given 3 lives to complete this goal. If you lose all 
three of your lives, the game ends and you must start over from the beginning.

Controls:
- Use the mouse and click on buttons to navigate through the main menu. Mouse is only used in the main menu
- Press the "W" key to move Mr. Turtle up
- Press the "S" key to move Mr. Turtle down
- Press the "A" key to move Mr. Turtle to the left
- Press the "D" key to move Mr. Turtle to the right
- Press the "Spacebar" to restart the game (only when you win or lose the game)

CODING QUALITY AND DESIGN
I believe that my coding quality and visual design are great because of many reasons. I was able 
to incorporate most of the concepts that we learned throughout the course into my program as well as create
a design that follows the flow of an old fashioned video game. I was able to expand off the basic concepts learned
in class, to enchance the overall design of my program. The part of code that I'm most the proud of would be my 
main menu section at the beginning of the program. The reason why I like this section so much is because I was able 
to fix a tedious problem that kept me from further progressing into my program. While coding this section, I ran 
into a problem that when the game started the menu buttons were still active and would freeze my game whenever 
the mouse clicked the screen. I remember trying many different strategies, but none of them worked. After taking 
the time to review my code I realized that I should've used a boolean for my menu buttons to turn them on and off. After 
implementing this strategy, my game didn't freeze and I was able to continue coding the rest of my game.

I also liked the section where I created 4 seperate functions for the turtles movement. In my opinion, the way 
I coded this area made my code look a lot more elegant. Instead of having it all clumped into a single "if" 
statement and having a bunch of random numbers everywhere, I was able to seperate each movement into an individual 
function with global variables. This made it look a lot better, and easier to interpret.

RELEASE
I Ryan Merkley grant permission to CS 105 course staff to use
my Assignment 9 program and video for the purpose of promoting CS 105.
(if you don't grant permission, erase the line above)
*/