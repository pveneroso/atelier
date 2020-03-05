class Tweet{
  
  JSONObject Json;
  String Text;
  ArrayList<String> All_words;
  ArrayList<String> Words;
  
  Tweet(JSONObject json){
    
    Json = json;
    Text = Json.getString("text");
    Text = Text.replaceAll("[^0-9\\p{L}\\s]", "");
    All_words = new ArrayList<String>();
    Words = new ArrayList<String>();
    prepareArrays();
  
  }
  
  void prepareArrays(){
    
    String s = "";
    for (int i = 0; i < Text.length(); i++){
      if(Text.charAt(i) != ' '){
        s += Text.charAt(i);
      }
      else {
        if(s != ""){
          All_words.add(s);
        }
        s = "";
      }
    }
    
    for(String word : All_words){
      if (!Words.contains(word)){
        Words.add(word);
      }
    }
  }
}
    
