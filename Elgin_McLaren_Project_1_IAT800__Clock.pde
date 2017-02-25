//   ______      _                        _   _____       _                        _    _____ _            _    
//  |  ____|    | |                      | | |_   _|     | |                      | |  / ____| |          | |   
//  | |__  __  __ |_ ___ _ __ _ __   __ _| |   | |  _ __ | |_ ___ _ __ _ __   __ _| | | |    | | ___   ___| | __
//  |  __| \ \/ / __/ _ \ '__| '_ \ / _` | |   | | | '_ \| __/ _ \ '__| '_ \ / _` | | | |    | |/ _ \ / __| |/ /
//  | |____ >  <| |_  __/ |  | | | | (_| | |  _| |_| | | | |_  __/ |  | | | | (_| | | | |____| | (_) | (__|   < 
//  |______/_/\_\\__\___|_|  |_| |_|\__,_|_| |_____|_| |_|\__\___|_|  |_| |_|\__,_|_|  \_____|_|\___/ \___|_|\_\

// By Elgin-Skye McLaren 
// IAT 800
// Sept 22, 2016

/*** README: The External Internal Clock requires the processing.sound library. To install, please click Sketch -> Import Library -> Add Library.  
 Search for "processing.sound", the author is "The Processing Foundation". If you do not wish to install the sound library, please simply comment out
 the 3  sections of code labelled "Audio Code"***/

/*  The External Internal Clock is intended to immerse viewers in a manifestation of stress related to the passage of time throughout the day.
     The experience is meant to be challenging to watch. If you do not wish to look for more than a few seconds, the following are the processes that take place 
     as time progresses:
     -"Thoughts" flash on the screen every 8 seconds, as well as at random (5 frames out of every 100)
     -The nature of "thoughts" change depending on the time of day (defined as morning/afternoon/evening/night)
     -The randomness of the "thoughts" background colour changes depending on the time of day
     -Red "news ticker" style bands of text appear regularly on the top and bottom of screen
     -The upper "news ticker" appears every other minute, reminding viewers that "Time is Precious"
     -The lower "news ticker" appears once every 3 minutes, reminding viewers to "Make every second count" and "Don't be Lazy"
     -For 5 seconds at the end of every minute, viewers are reminded "Don't stop"
     -The passage of time is punctuated by a pulsing Triangle Wave beat (like a second hand on a clock)
     -A sine wave steadily increases as each minute passes
 */



import processing.sound.*; //Processing library to enable the sound

//Define Variables
PFont font; //Used to include a more "digital-looking" font
float redRand, greenRand, blueRand, rand; //Used for randomizing color and flashing text
int mornings, afternoons, evenings, nights, s, m, h, x; //Used for determining the words displayed, what time it is, and the position of the news ticker text


//Begin Audio Code 1 - based on examples from https://processing.org/tutorials/sound/
// Oscillator and envelope 
TriOsc triOsc;
SinOsc sine;
Env env; 

// Times and levels for the Audio Envelope
float attackTime = .0004;
float sustainTime = 0.004;
float sustainLevel = 0.6;
float releaseTime = 0.01;
int duration = 100 ;
int note = 0; 

//End Audio Code


void setup() {
  size(800, 800);
  background(0);
  fill(0);
  font  = loadFont("KellySlab-Regular-48.vlw");
  textFont(font);
  textAlign(CENTER);
  frameRate(6);
  x=width;

  //Begin Audio Code 2
  triOsc = new TriOsc(this);//Define Triangle Wave
  sine = new SinOsc(this); //Define Sine Wave
  env  = new Env(this); //Envelope makes the Triangle Wave pulse
  sine.play(); //Begins the sustained Sine Wave
  //End Audio Code 2
}


void draw() {

  //Define Time Related Variables
  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23

  //Begin Audio Code 3
  sine.freq(s*3); //Makes the sinewave increase in value as the seconds progress
  triOsc.play(70, 0.5);  // Sets the frequency of the triangle wave at 70
  env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime); //Envelope makes the Triangle Wave pulse
  //End Audio Code 3

  // Arrays for Morning/Afternoon/Evening/Night text values
  String[] morning = { "Get up", "work", "sleep", "Go away", "I'm late", "late", "no", "warm bed", "Work", "you can do it", "Coffee", "Get Going", "Slept in", "Tomorrow will be different", "cold", "bus", "email", "facebook", "twitter", "reddit", "facebook", "pack textbook", "pack lunch", "sleep in", "I give up", "nope", "Today", "email", "email", "text", "hot shower", "10 more minutes", "read the news", "here I go", "hungry", "sleepy", "10 minutes", "20 minutes", "25 minutes", "coffee", "no food" };
  String[] afternoon = {"Back to work", "coffee", "hungry", "angry", "snack", "share", "snap", "what time is it", "10 more minutes", "How much time left", "concentrate", "focus", "back to work", "quick walk", "email", "facbeook", "instagram", "really?", "lots of time", "no time", "email", "later", "email", " got it", "stop it", "phony", "thinking", "focus", "read", "go", "stop", "google", "80%", "50%", "20%", "10%", "buzzfeed", "cats", "cats", "cats", "nap"};
  String[] evening = { "Netflix", "hot shower", "get up early", "like", "like", "share", "snap", "retweet", "like", "So tired", "tweet", "invite", "waste", "get it", "tomorrow", "lonely", "sick", "not tired", "tired", "bills", "heavy", "One more", "midnight", "email", "TV", "Nap", "dinner", "chips", "heache", "snack", "get back", "never", "lists", "focus", "power", "google"};
  String[] night = {"sleep", "email", "work", "move", "sleep", "quit", "why not", " sick", "work", "sleep", "tired", "fatigue", "ache", "sore", "bed", "work", "sleep", "noise", "sleep", "still", "stop", "lonely", "busy", "weak", "stress", "sleep", "heavy", "why", "rest", "deadline", "cellphone"};

  //Define Random Variables
  rand = random(1, 100); // "Thought flash" background occurs when this value is > 95
  redRand=random(0, 255); //Random Red Value for "thought flash" background
  greenRand=random(0, 255); //Random Gren Value for "thought flash" background
  blueRand=random(0, 255); //Random Blue Value for "thought flash" background
  mornings= int (random(0, morning.length));
  afternoons=int (random(0, afternoon.length));
  evenings=int  (random(0, evening.length));
  nights = int (random(0, night.length));

  textSize(40);
  background(0);

  // Write "External Internal Clock" in green for the first 5 seconds. 
  if (millis() < 5000) {
    textSize(50); 
    fill(0, 255, 0); //Green Text
    text("External Internal Clock", width/2, 300);
  }

  //Clock Numbers
  fill(255);//White Text
  textSize(40);
  text(h + " : " + m  + " : " + s, width/2, height/2);

  //News Tickers At Top & Bottom
  //Display upper news ticker if the minute is even
  if (m % 2 == 0) {
    fill(255, 0, 0);//Red Background
    rect(0, 0, 800, 100); //Background Shape
    fill(255, 255, 0); //Yellow Text
    text("Time is precious", x+100, 70);
    x=x-10; // moves 10px to the left per frame
    if (x<-200) {
      x =900; //When x is less than -200, reset the text to the other side of the screen
    }
  }

  //Display lower news ticker is minute is divisible by 3 with no remainder
  if (m % 3 == 0 ) {
    fill(255, 0, 0); //Red Background
    rect(0, 700, 800, 100); //Background Shape
    fill(255, 255, 0); //Yellow Text
    text("Make every second count", x, 770);
    text("Don't be lazy", x+600, 770);
    x=x-45;//moves 45px to the left per frame
    if (x<-800) {
      x =850; //When x is less than -500, reset the text to the other side of the screen
    }
  }

  //Thought Flashes
  //Flash if a random number between 1 and 100 is > 95, or once every 8 seconds
  if (rand > 95 || s % 8 == 0 ) {
    //Before 6AM Flash Night Thought Messages in Random Greyscale Color
    if (h<6) {
      fill(redRand, redRand, redRand); //All Values The Same to Create Greyscale colour
      rect(0, 0, 800, 800);    //Shape that takes up entire screen. I did this instead of changing the background color because I wanted to be able to fade between the flashes, and opacity can't change for background colours. I didn't get this working in the end.  
      fill(255);//Black Text
      text(night[nights], width/2, height/2);
    } 
    //After 6AM, before 12PM Flash Morning Thought Messages in a Random Color (Mostly Green)
    else if (h<9) {
      fill(redRand, 255, blueRand); //All Values The Same to Create Greyscale colour
      rect(0, 0, 800, 800);    //Shape that takes up entire screen. I did this instead of changing the background color because I wanted to be able to fade between the flashes, and opacity can't change for background colours. I didn't get this working in the end.  
      fill(255);//Black Text
      text(morning[mornings], width/2, height/2);
    }
    //After 12pm, before 4pm Flash Afternoon Thought Messages in a Random Color 
    else if (h < 16) {
      fill(redRand, greenRand, blueRand); //All Values The Same to Create Greyscale colour
      rect(0, 0, 800, 800);    //Shape that takes up entire screen. I did this instead of changing the background color because I wanted to be able to fade between the flashes, and opacity can't change for background colours. I didn't get this working in the end.  
      fill(255);//Black Text
      text(afternoon[afternoons], width/2, height/2);
    } 
    //After 4pm, before 9pm Flash Evening thought Messages in a Random Color (Mostly Red)
    else if (h<21) {
      fill(255, greenRand, blueRand); //All Values The Same to Create Greyscale colour
      rect(0, 0, 800, 800);    //Shape that takes up entire screen. I did this instead of changing the background color because I wanted to be able to fade between the flashes, and opacity can't change for background colours. I didn't get this working in the end.  
      fill(255);//Black Text
      text(evening[evenings], width/2, height/2);
    } 
    //After 9pm, before 12AM Flash Night Thought Messages in Random Greyscale Color
    else      if (h<25) {
      fill(redRand, redRand, redRand); //All Values The Same to Create Greyscale colour
      rect(0, 0, 800, 800);    //Shape that takes up entire screen. I did this instead of changing the background color because I wanted to be able to fade between the flashes, and opacity can't change for background colours. I didn't get this working in the end.  
      fill(255);//Black Text
      text(night[nights], width/2, height/2);
    }
    textSize(100); //Makes "Don't Stop" Also Flash Randomly
  }
  //For the last 5 seconds of every minute, flash "Don't Stop" on the screen
  if (s > 55) {
    fill(255, 255, blueRand);
    background (0, 255, 255);
    text("Don't Stop", width/2, height/2);
  }
}