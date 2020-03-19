class ForceDirected{
  JSONObject JSON = new JSONObject();
  ArrayList<Node> Nodes = new ArrayList<Node>();
  //ArrayList<Link> Links = new ArrayList<Link>();
  float min_size = 5.0;
  float elasticity = 10.0;
  float repulsion = 5;
  
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
    Display();
      
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
      reflow(node);
      node.draw();
    }
  }
  
  void reflow(Node n){
    ArrayList<Node> incoming = n.getIncomingLinks();
    float dx = 0;
    float dy = 0;
    for(Node ni: incoming) {
      dx += (ni.x-n.x);
      dy += (ni.y-n.y);
    }
    //float len = sqrt(dx*dx + dy*dy);
    float angle = getDirection(dx, dy);
    float[] motion = rotateCoordinate(0.9*repulsion,0.0,angle);
    float px = n.x;
    float py = n.y;
    n.x += motion[0];
    n.y += motion[1];
    if(n.x<0){
      n.x=0;
    }
    else if(n.x>width){
      n.x=width;
    }
    if(n.y<0){
      n.y = 0;
    }
    else if(n.y>height){
      n.y = height;
    }
    float shortest = n.getShortestLinkLength();
    if(shortest<min_size || shortest> elasticity*2){
      n.x=px;
      n.y = py;
    }
  }
}
