JSONArray data_twitter;

void setup(){
  data_twitter = loadJSONArray("./././- proto/bussola_descompassada_0_0_2/tmp/data_1.json");
  for (int i = 0; i < data_twitter.size(); i++){
    JSONObject data = data_twitter.getJSONObject(i);
    println(data);
  }
}
void draw(){

}
