JSONArray data_twitter;
Graph Graph;
ArrayList<Tweet> Tweets;
ArrayList<String> All_words;
ArrayList<String> Words;
JSONArray Nodes;
JSONObject JSON;
String [] Text;
ForceDirected FD;

void setup(){
  //size(1900,1000);
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
  Text = new String[data_twitter.size()];
  createWordArray();
  Graph = new Graph(Words.size(), Tweets, Words);
  JSON.setJSONArray("nodes", Nodes);
  JSON.setJSONArray("links", Graph.Links);
  //saveJSONObject(JSON, "JSON.json");
  //for (int i = 0; i < Tweets.size();i++){
  //  Text[i] = Tweets.get(i).Text_rough;
  //}
  
  //saveStrings("text.txt", Text);
  //FD = new ForceDirected(JSON);
  println(Tweets.get(4).All_words);
}

void draw(){
  background(255);
  //FD.Display();
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

void mouseDragged(){
  for (Node node : FD.Nodes){
    if(mouseX <= node.position.x + node.r1 && mouseX >= node.position.x - node.r1 && mouseY <= node.position.y + node.r1 && mouseY >= node.position.y - node.r1){
      node.setPosition(mouseX,mouseY);
    }
  }
}



  
  


    
