class General{
  
  ArrayList<Tweet> Tweets;
  ArrayList<String> All_texts;
  ArrayList<String> Text;
  Grafo grafo;
  Integer[][] strength;
  
  //Nodes[] nodes;
  //Links[] links;
  
  
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
  
  void createGraph(){ // grafo da palavra 
    grafo = new Grafo(Text.size());
    strength = new Integer[Text.size()][Text.size()];
    for (int i = 0; i < Text.size(); i++){
      for (int j = 0; j < Text.size(); j++){
        strength[i][j] = 0;
      }
    }
    for (String word : Text){
      for (Tweet tweet : Tweets){
        if (tweet.words.contains(word)){
          for (String w : tweet.words){
            if (Text.indexOf(word) != Text.indexOf(w)){
              if(!grafo.adj[Text.indexOf(word)].hasValue(Text.indexOf(w))){ 
                grafo.addEdge(Text.indexOf(word), Text.indexOf(w));
                strength[Text.indexOf(word)][Text.indexOf(w)] += 1;
              }
              else{
                strength[Text.indexOf(word)][Text.indexOf(w)] += 1;
              }
            }
          }
        }
      }
    }
  }
  
  void printTweetGraph(){
    println(Tweets.get(50).grafo);
  }
}
  
  
