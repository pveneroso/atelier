class Graph{
  
  int V;
  IntList[] adj;
  Integer[][] Strength;
  ArrayList<Tweet> Tweets;
  ArrayList<String> Words;
  JSONArray Links;
  
  Graph (int v, ArrayList<Tweet> tweets, ArrayList<String> words){
    
    Tweets = new ArrayList<Tweet>();
    Tweets.addAll(tweets);
    Words = new ArrayList<String>();
    Words.addAll(words);
    Links = new JSONArray();
    V = v;
    adj = new IntList[V];
    for (int i = 0; i < V; i++){
      adj[i] = new IntList();
    }
    
    createGraph();
  }
  
  void addEdge(int v, int w){
    adj[v].append(w);
    adj[w].append(v);
  }
  
  void createGraph(){
    
    Strength = new Integer[Words.size()][Words.size()];
    for (int i = 0; i < Words.size(); i++){
      for (int j = 0; j < Words.size(); j++){
        Strength[i][j] = 0;
      }
    }
    
    for (String word : Words){
      for (Tweet tweet : Tweets){
        if (tweet.Words.contains(word)){
          for (String w : tweet.All_words){
            if (Words.indexOf(word) != Words.indexOf(w)){
              if (!adj[Words.indexOf(word)].hasValue(Words.indexOf(w))){
                addEdge(Words.indexOf(word), Words.indexOf(w));
                Strength[Words.indexOf(word)][Words.indexOf(w)] += 1;
              }
              else{
                Strength[Words.indexOf(word)][Words.indexOf(w)] += 1;
              }
            }
          }
        }
      }
    }
    
    int index = 0;
    for (int i = 0; i < Words.size(); i++){
      for (int j = i+1; j < Words.size(); j++){
        if (Strength[i][j] > 0){
          JSONObject link = new JSONObject();
          link.setInt("id", index);
          link.setInt("source", i);
          link.setInt("target", j);
          link.setInt("strength", Strength[i][j]);
          Links.setJSONObject(index, link);
          index++;
        }
      }
    }
  }
}
  
