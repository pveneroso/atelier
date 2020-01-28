JSONArray data_twitter;
Individual[] individual;

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
}
