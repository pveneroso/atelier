

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
  print(general.Text.size());
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
