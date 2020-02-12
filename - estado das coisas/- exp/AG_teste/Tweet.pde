class Tweet{
    
  JSONObject Json;
  int x;
  int y;
  int c;
  String text;
  ArrayList<String> all_words;
  ArrayList<String> words;
    
  Tweet (JSONObject json) {
    
    Json = json;
    x = int(random(0,width));
    y = int(random(0,height));
    c = Json.getInt("id");
    text = Json.getString("text");
    text = text.replaceAll("[^0-9\\p{L}\\s]", " ");
    all_words = new ArrayList<String>();
    words = new ArrayList<String>();
    prepareArrays();
    
  }
  
  void Display() {
    fill(0);
    ellipse(x, y, 30, 30);
    fill(255);
    text(c, x, y);
  }
  
  void prepareArrays(){
      
      String s = "";
      for(int i = 0; i < text.length(); i++){
        if(text.charAt(i) != ' '){
          s += text.charAt(i);
          }
        else {
          if(s != ""){
            all_words.add(s);
          }
          s = "";
        }
      }
      
      for(String word : all_words){
        if (!words.contains(word)){
          words.add(word);
        }
      }
  }
}
            
