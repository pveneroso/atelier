class Tweet{ // importa e converte
    
  JSONObject Json;
  int x;
  int y;
  int c;
  String text;
  ArrayList<String> all_words;
  ArrayList<String> words;
  Grafo grafo; // não pode estar aqui dentro
    
  Tweet (JSONObject json) {
    
    Json = json;
    x = int(random(0,width));
    y = int(random(0,height));
    c = Json.getInt("id");
    text = Json.getString("text");
    //println(text);
    
    /*   necessário analisar e entender essa frase: "[^0-9\\p{L}\\s]".
         • remoção de quebra de linha não está funcionando
         • manter @nome_de_usuário e não quebrar urls
         
         checar a captura dos tweets: estão vindo quebrados (com …)
    */
    text = text.replaceAll("[^0-9\\p{L}\\s]", "");
    all_words = new ArrayList<String>();
    words = new ArrayList<String>();
    prepareArrays();
    grafo = new Grafo(words.size()); // ideal estar no código principal •
    wordsConnections();
    
  }
  
  void Display() {
    fill(0);
    ellipse(x, y, 30, 30);
    fill(255);
    text(c, x, y);
  }
  
  void prepareArrays(){
    /*  para reconhecer urls (e @user): escrever função
        identificar http
        guardar index do 'h'
        buscar próximo espaço ou fim da linha ou do tweet e
        guardar index imediatamente anterior
        salvar palavra com o respectivo tipo
        deleta palavra do tweet de ref que será usado para gerar a lista de palavras
    */
    
    // all_words = splitTokens(text, " ")
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
        // extração para JSON de nodes
      }
    }
  }
  
  void wordsConnections(){
    for (int i = 0; i < words.size(); i++){
      for (int j = i+1; j < words.size(); j++){
        grafo.addEdge(i,j);
        // extração de dados para o JSON de links
      }
    }
  }
}
            
