class Tweet{
  
  JSONObject Json;
  String Text;
  String Text_rough;
  ArrayList<String> All_words;
  ArrayList<String> Words;
  ArrayList<String> All_text = new ArrayList<String>();
  ArrayList<String> Users = new ArrayList<String>();
  ArrayList<String> Urls = new ArrayList<String>();
  
  Tweet(JSONObject json){
    
    Json = json;
    Text = Json.getString("text");
    Text_rough = Text.toLowerCase();
    //Text = Text.replaceAll("[^0-9\\p{L}\\s]", "");
    All_words = new ArrayList<String>();
    Words = new ArrayList<String>();
    prepareArrays();
  
  }
  
  void prepareArrays(){
    String[] temp;
    temp = split(Text_rough, ' ');
    for (String s : temp){
      All_text.add(s);
    }
    //separa os usuários e urls
    for (String word : All_text){
      if(word.contains("@")){
        Users.add(removePunctuations(word));
      }
      if(word.contains("http")){
        Urls.add(word);
      }
      if(!Users.contains(word) && !Urls.contains(word)){
        All_words.add(removePunctuations(word));
      }
    }
    
    
    //usuários
    //for (int i = 0; i < temp.length; i++){
    //  String[] m1 = match(temp[i], "@");
    //  if(m1 != null){
    //    String[] nm = Users;
    //    Users = new String[nm.length+1];
    //    for(int j = 0; j < Users.length; j++){
    //      if(j < Users.length-1){
    //        Users[j] = nm[j];
    //      }
    //      else {
    //        Users[Users.length-1] = temp[j];
    //      }
    //    }
    //  }
    //}
    //urls
    //for (int i = 0; i < temp.length; i++){
    //  String[] m1 = match(temp[i], "http");
    //  if(m1 != null){
    //    String[] nm = Urls;
    //    Urls = new String[nm.length+1];
    //    for(int j = 0; j < Urls.length; j++){
    //      if(j < Urls.length-1){
    //        Urls[j] = nm[j];
    //      }
    //      else {
    //        Urls[Urls.length-1] = temp[j];
    //      }
    //    }
    //  }
    //}  
    
    
    //String s = "";
    //for (int i = 0; i < Text.length(); i++){
    //  if(Text.charAt(i) != ' '){
    //    s += Text.charAt(i);
    //  }
    //  else {
    //    if(s != ""){
    //      All_words.add(s);
    //    }
    //    s = "";
    //  }
    //}
    
    for(String word : All_words){
      if (!Words.contains(word)){
        Words.add(word);
      }
    }
  }
  
  String removePunctuations(String word){
    String p = "! # % ( ) * + , . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~";
    String [] punctuations = split(p, ' ');
    for (String c : punctuations){
      word = word.replace(c, "");
    }
    return word;
  }
}
    
