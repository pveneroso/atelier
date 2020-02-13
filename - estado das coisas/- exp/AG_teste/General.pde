class General{
  
  ArrayList<Tweet> Tweets;
  ArrayList<String> All_texts;
  ArrayList<String> Text; // sem repetição
  
  General (){
    Tweets = new ArrayList<Tweet>();
    All_texts = new ArrayList<String>();
    Text = new ArrayList<String>();
  }
  
  void addTweet(Tweet tweet){
    Tweets.add(tweet);
  }
  
  void createStrings(){
    
    for (Tweet tweet : Tweets){
      for(int i = 0;i < tweet.all_words.size(); i++){
        All_texts.add(tweet.all_words.get(i));
      }
    }
    
    for(String word : All_texts){
      if (!Text.contains(word)){
        Text.add(word);
      }
    }
  }
}
  
  
