

JSONArray data_twitter;
General general;

                  
void setup(){
  size(500,500);
  data_twitter = loadJSONArray("C:/xampp/htdocs/atelier/- estado das coisas/- proto/bussola_descompassada_0_0_2/tmp/data_1.json");
  general = new General();
  for (int i = 0; i < data_twitter.size(); i++){
    Tweet tweet = new Tweet(data_twitter.getJSONObject(i));
    general.addTweet(tweet);
    
  }
  general.createStrings();
  general.createGraph();
  //print(general.strength[0][1]);
  
  for (int i = 0; i < general.Text.size(); i++){
    print(i + ": " +  general.strength[1][i] + "  ");
  }
}

void draw(){
  for (int i = 0; i < data_twitter.size(); i++){
    //tweet[i].Display();
  }
  
  //prepareString();
  //print(tweets);
}

//void prepareString(){
//  for (int i = 0; i < data_twitter.size(); i++){
//    tweets += tweet[i].text + " ";
//  }
//  tweets = tweets.replaceAll("[^0-9\\p{L}\\s]", " ");
//}
