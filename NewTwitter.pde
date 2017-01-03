twitterFeed twitter = new twitterFeed();
Arduino arduino;
int ledPin = 13;

void setup() {
  twitter.apiSetup();
println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[9], 57600);
  arduino.pinMode(13, Arduino.OUTPUT);
  delay(5000);
}
void draw() {
  twitter.displayTweets(); 
  twitter.getData();
  delay(20000);
}



 

 










