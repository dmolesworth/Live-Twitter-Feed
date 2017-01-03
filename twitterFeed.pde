import processing.serial.*;
import cc.arduino.*;

class twitterFeed {
  //importing libaries
  ConfigurationBuilder cb = new ConfigurationBuilder();
  Twitter twitterInstance;
  Query queryForTwitter;

  ArrayList tweets;
  String user;
  String status;
  int spos = 0;
  void apiSetup() {
    //the Setup of the API to call twitter
    cb.setOAuthConsumerKey("9N3fXe3gRcLJ82YkAnljrg");
    cb.setOAuthConsumerSecret("hx37OQZWT9xdsMBXzzQOLbuhqJD06DwRFMspTDTecY");
    cb.setOAuthAccessToken("573121689-WbSLbkdSpwt882Lw6YwOVRrtyT9ndLN0muWILgE5");
    cb.setOAuthAccessTokenSecret("SA2ZPdMhU4SbR291JELrGBU5AF0YTOZZEECPPt7TQRJr1");

    //searching twitter
    twitterInstance = new TwitterFactory(cb.build()).getInstance();
    queryForTwitter = new Query("@t_creatures");
    //displayTweets();
  }

  void getData() {
    //gathering twitter data
    try {
      //for (int i=0; i<tweets.size(); i++) {
      Status t = (Status) tweets.get(0);
      user = t.getUser().getName(); 
      status = t.getText(); 
      println(status.length());
      /*if (status.length() == 19)
       {
       spos = 1;
       println("true");
       arduino.analogWrite(13, spos);
       }
       else
       {
       spos = 179;
       println("false");
       
       arduino.analogWrite(13, spos);
       }
       */
      ArrayList<String> words = new ArrayList();
      String[] input = status.split(" ");
      for (int j = 0; j < input.length; j++) {
        words.add(input[j]);
      }

      for (int k = 0; k < input.length; k++)
      {
        if (input[k].equals("#happy") == true ||input[k].equals("#good"))
        {
          spos = 179;
          println("true");
          arduino.analogWrite(13, spos);
        } 
        else if (input[k].equals("#sad") == true)
        {
          spos = 1;
          println("false");
          arduino.analogWrite(13, spos);
        }
        else if ((input[k].equals("#okay") || input.equals("#ok")) && spos == 179)
        {
          for (int i = 0; i < 180; i++)
          {
            spos--;
            delay(3000/180);
            arduino.analogWrite(13, spos);
          }
        }
        else if (input[k].equals("#okay") || input.equals("#ok"))
        {
          for (int i = 0; i < 180; i++)
          {
            spos++;
            delay(3000/180);
            arduino.analogWrite(13, spos);
          }
        }
        else if (input[k].equals("#bored"))
        {
          for (int i = 0; i < 180; i++)
          {
            spos++;
            delay(15);
            arduino.analogWrite(13, spos);
          } 
          delay(3000);
          for (int i = 0; i < 180; i++)
          {
            spos--;
            delay(15);
            arduino.analogWrite(13, spos);
          }
        }
        else if (input[k].equals("#tired"))
        {
          for (int i = 0; i < 90; i++)
          {
            spos++;
            delay(15);
            arduino.analogWrite(13, spos);
          } 
          delay(1500);
          spos = 0;
          arduino.analogWrite(13, spos);
        }
      }
      //displaying the data
      println(status);
      arduino.digitalWrite(ledPin, Arduino.HIGH);
      delay(1000);
      arduino.digitalWrite(ledPin, Arduino.LOW);
      delay(1000);
      //}
    } 
    catch (Exception te) {
      println("No Tweets!");
    }
  }

  void displayTweets() {
    //fetch data attempt
    try {
      QueryResult result = twitterInstance.search(queryForTwitter);
      tweets = (ArrayList) result.getTweets();
    }
    catch(TwitterException te) {
      println("couldn't connect: " + te);
    }
  }
}

