

JSONArray data_twitter;
General general;

JSONArray Nodes;
JSONArray Links;
JSONObject JSON;


                  
void setup(){
  size(1900,1000);
  ellipseMode(CENTER);
  
  Nodes = new JSONArray();
  Links = new JSONArray();
  JSON = new JSONObject();
  data_twitter = loadJSONArray("data_1.json");
  general = new General();
  for (int i = 0; i < data_twitter.size(); i++){
    Tweet tweet = new Tweet(data_twitter.getJSONObject(i));
    general.addTweet(tweet);
    
  }
  
  general.createStrings();
  general.createGraph();
  general.printTweetGraph();
  createJSON();
  //for(int i = 0; i < general.Text.size(); i++){
  //  println(i + " : " + general.Text.get(i));
  //}
  //println(general.All_texts);
  //print(general.strength[0][1]);
  
  //for (int i = 0; i < general.Text.size(); i++){
  //  print(i + ": " +  general.strength[1][i] + "  ");
  //}
}

void draw(){
  for (int i = 0; i < data_twitter.size(); i++){
    //tweet[i].Display();
  }
   display();
  
  //prepareString();
  //print(tweets);
}

//void prepareString(){
//  for (int i = 0; i < data_twitter.size(); i++){
//    tweets += tweet[i].text + " ";
//  }
//  tweets = tweets.replaceAll("[^0-9\\p{L}\\s]", " ");
//}

void createJSON(){
  for (int i = 0; i < general.Text.size();i++){
    
    JSONObject node = new JSONObject();
    node.setInt("id", i);
    node.setString("name", general.Text.get(i));
    node.setFloat("x",random(0,width));
    node.setFloat("y",random(0,height));
    Nodes.setJSONObject(i,node);
  }
  
  //saveJSONArray(Nodes, "nodes.json");
  
  int index = 0;
  for (int i = 0; i < general.Text.size(); i++){
    for (int j = i+1; j < general.Text.size(); j++){
      if (general.strength[i][j] > 0){
        JSONObject link = new JSONObject();
        link.setInt("id", index);
        link.setInt("source", i);
        link.setInt("target", j);
        link.setInt("strength", general.strength[i][j]);
        Links.setJSONObject(index,link);
        index++;
      }
    }
  }
  //saveJSONArray(Links, "links.json");
  JSON.setJSONArray("nodes",Nodes);
  JSON.setJSONArray("links",Links);
  
  saveJSONObject(JSON, "JSON.json");
  
  
}

void display(){
  for (int i = 0; i < JSON.getJSONArray("links").size(); i++){
    int strength = JSON.getJSONArray("links").getJSONObject(i).getInt("strength");
    stroke(255/strength);
    int source = JSON.getJSONArray("links").getJSONObject(i).getInt("source");
    int target = JSON.getJSONArray("links").getJSONObject(i).getInt("target");
    line(JSON.getJSONArray("nodes").getJSONObject(source).getInt("x"), JSON.getJSONArray("nodes").getJSONObject(source).getInt("y"),JSON.getJSONArray("nodes").getJSONObject(target).getInt("x"), JSON.getJSONArray("nodes").getJSONObject(target).getInt("y"));
  }
  for (int i = 0; i < JSON.getJSONArray("nodes").size(); i ++){
    fill(0);
    ellipse(JSON.getJSONArray("nodes").getJSONObject(i).getInt("x"),JSON.getJSONArray("nodes").getJSONObject(i).getInt("y"), 8,8);
  }
  
}
  
