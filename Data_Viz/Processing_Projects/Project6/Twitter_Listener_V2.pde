// a listener object function that receives twitter data continuously

StatusListener listener = new StatusListener() {
  void onStatus(Status status) {
    if (status.getText().indexOf(keywords[0])!= -1 || status.getText().indexOf(keywords[1])!= -1 )
    {
      gopCount++;
      img2 = loadImage(status.getUser().getMiniProfileImageURL());
      if(status.getText().indexOf(keywords[0])!= -1) {
        printTextForMatchingHashTag(keywords[0], status.getText());
      } else {
        printTextForMatchingHashTag(keywords[1], status.getText());
      }
    }
    if (status.getText().indexOf(keywords[2])!= -1 || status.getText().indexOf(keywords[3])!= -1 )
    {
      demsCount++;
      img1 = loadImage(status.getUser().getMiniProfileImageURL());
      if(status.getText().indexOf(keywords[2])!= -1) {
        printTextForMatchingHashTag(keywords[2],status.getText());
      } else {
        printTextForMatchingHashTag(keywords[3],status.getText());
      }
    }     
  }
  void onStallWarning(StallWarning stallwarning){}
  void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
  void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
  void onScrubGeo(long userId, long upToStatusId) 
  {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }
  void onException(Exception ex) {
    ex.printStackTrace();
  }
  
  void printTextForMatchingHashTag(String hashTag, String text)
  {
    System.out.println("------");
    System.out.println(hashTag + " : " + text);
  }
};
