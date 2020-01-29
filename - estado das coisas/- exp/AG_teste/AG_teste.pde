

JSONArray data_twitter;
Individual[] individual;
String tweets = "";

                  
void setup(){
  size(500,500);
  data_twitter = loadJSONArray("C:/xampp/htdocs/atelier/- estado das coisas/- proto/bussola_descompassada_0_0_2/tmp/data_1.json");
  individual = new Individual[data_twitter.size()];
  for (int i = 0; i < data_twitter.size(); i++){
    individual[i] = new Individual(data_twitter.getJSONObject(i));
  }
}

void draw(){
  for (int i = 0; i < data_twitter.size(); i++){
    individual[i].Display();
  }
  prepareString();
  print(tweets);
}

void prepareString(){
  for (int i = 0; i < data_twitter.size(); i++){
    tweets += individual[i].tweet + " ";
  }
  tweets = tweets.replaceAll("[^0-9\\p{L}\\s]", " ");
  //tweets = tweets.replaceAll("[^\\p{L}\\s]", " "); //sem os números
}
