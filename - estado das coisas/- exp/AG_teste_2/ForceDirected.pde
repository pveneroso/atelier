class ForceDirected{
  JSONObject JSON = new JSONObject();
  ArrayList<Node> Nodes = new ArrayList<Node>();
  //ArrayList<Link> Links = new ArrayList<Link>();
  float min_size = 80;
  float elasticity = 200.0;
  float repulsion = 15;
  
  ForceDirected(JSONObject json){
    JSON = json;
    
    for (int i = 0; i < JSON.getJSONArray("nodes").size(); i++){
      Node n = new Node(JSON.getJSONArray("nodes").getJSONObject(i).getString("name"),
      JSON.getJSONArray("nodes").getJSONObject(i).getFloat("x"),
      JSON.getJSONArray("nodes").getJSONObject(i).getFloat("y"));
      Nodes.add(n);
      
      //Link l = new Link();
      //for (int j = 0; JSON.getJSONArray("links").size(); j++){
      //  if(!l.Incoming.contains(JSON.getJSONArray("links").getJSONObject(j).getInt("source")){
      //    l.createLink(JSON.getJSONArray("links").getJSONObject(j).getInt("source"),
      //                 JSON.getJSONArray("links").getJSONObject(j).getInt("target")
      //                 JSON.getJSONArray("links").getJSONObject(j).getInt("strength"));
    }
    
    linkNodes();
    //Display();
      
  } 
  
  void linkNodes(){
    for(int i = 0; i < JSON.getJSONArray("links").size(); i++){
      Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("source")).addIncomingLink(Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("target")));
      Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("source")).addOutgoingLink(Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("target")));
      
      Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("target")).addIncomingLink(Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("source")));
      Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("target")).addOutgoingLink(Nodes.get(JSON.getJSONArray("links").getJSONObject(i).getInt("source")));
    }
  }
  
  void Display(){
    for(Node node: Nodes){
      //versão estática
      reflow(node);
      node.draw();
      
      
      //versão com movimento
      //node.flock(Nodes);
    }
  }
  
  void reflow(Node n){
    ArrayList<Node> incoming = n.getIncomingLinks();
    float dx = 0;
    float dy = 0;
    for(Node ni: incoming) {
      dx += (ni.position.x-n.position.x);
      dy += (ni.position.y-n.position.y);
    }
    //float len = sqrt(dx*dx + dy*dy);
    float angle = getDirection(dx, dy);
    float[] motion = rotateCoordinate(0.9*repulsion,0.0,angle);
    
    float px = n.position.x;
    float py = n.position.y;
    n.position.x += motion[0];
    n.position.y += motion[1];
    
    if(n.position.x<0){
      n.position.x=0;
    }
    else if(n.position.x>width){
      n.position.x=width;
    }
    if(n.position.y<0){
      n.position.y = 0;
    }
    else if(n.position.y>height){
      n.position.y = height;
    }
    float shortest = n.getShortestLinkLength();
    if(shortest<min_size || shortest> elasticity*2){
      n.position.x=px;
      n.position.y = py;
    }
  }
}
