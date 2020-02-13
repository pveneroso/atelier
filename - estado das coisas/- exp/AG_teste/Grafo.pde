class Grafo{
  
  int V;
  IntList[] adj;
  
  Grafo(int v){
    
    V = v;
    adj = new IntList[v];
    for (int i = 0; i < v; i++){
      adj[i] = new IntList();
    }
  }
  
  void addEdge(int v, int w){
    adj[v].append(w);
    adj[w].append(v);
  }
}
