class Individual{
    
  JSONObject Json;
  int x;
  int y;
  int c;
  String tweet;
    
  Individual (JSONObject json) {
    
    Json = json;
    x = int(random(0,width));
    y = int(random(0,height));
    c = Json.getInt("id");
    tweet = Json.getString("text");
    
  }
  
  void Display() {
    
    fill(0);
    ellipse(x, y, 30, 30);
    fill(255);
    text(c, x, y);
  }
  
}
            
