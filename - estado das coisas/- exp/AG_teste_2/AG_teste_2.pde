JSONArray data_twitter;
Graph Graph;
ArrayList<Tweet> Tweets;
ArrayList<String> All_words;
ArrayList<String> Words;
JSONArray Nodes;
JSONObject JSON;

void setup(){
  size(1900,1000);
  Tweets = new ArrayList<Tweet>();
  All_words = new ArrayList<String>();
  Words = new ArrayList<String>();
  Nodes = new JSONArray();
  JSON =  new JSONObject();
  
  data_twitter = loadJSONArray("data_1.json");
  for (int i = 0; i < data_twitter.size(); i++){
    Tweet tweet = new Tweet(data_twitter.getJSONObject(i));
    Tweets.add(tweet);
  }
  
  createWordArray();
  Graph = new Graph(Words.size(), Tweets, Words);
  JSON.setJSONArray("nodes", Nodes);
  JSON.setJSONArray("links", Graph.Links);
  saveJSONObject(JSON, "JSON.json");
}

void draw(){
}

void createWordArray(){
  
  for(Tweet tweet : Tweets){
    for (int i = 0; i < tweet.All_words.size(); i++){
      All_words.add(tweet.All_words.get(i));
    }
  }
  
  for (String word: All_words){
    if (!Words.contains(word) && word != " "){
      Words.add(word);
      JSONObject node = new JSONObject();
      node.setInt("id", Words.indexOf(word));
      node.setString("name",word);
      node.setFloat("x", random(0,width));
      node.setFloat("y", random(0,height));
      Nodes.setJSONObject(Words.indexOf(word),node);
    }
  }
}

  
  


    
