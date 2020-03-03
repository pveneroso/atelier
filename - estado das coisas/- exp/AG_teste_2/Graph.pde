class Graph{
  
  int V;
  IntList[] adj;
  
  Graph(int v){
    
    V = v;
    adj = new IntList[V];
    for (int i = 0; i < V; i++){
      adj[i] = new IntList();
    }
  }
  
  void addEdge(int v, int w){
    adj[v].append(w);
    adj[w].append(v);
  }
}
  
