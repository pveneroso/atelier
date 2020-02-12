

JSONArray data_twitter;
Tweet[] tweet;
String tweets = "";

                  
void setup(){
  size(500,500);
  data_twitter = loadJSONArray("C:/xampp/htdocs/atelier/- estado das coisas/- proto/bussola_descompassada_0_0_2/tmp/data_1.json");
  tweet = new Tweet[data_twitter.size()];
  for (int i = 0; i < data_twitter.size(); i++){
    tweet[i] = new Tweet(data_twitter.getJSONObject(i));
  }
  print(tweet[1].words);
}

void draw(){
  for (int i = 0; i < data_twitter.size(); i++){
    tweet[i].Display();
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
