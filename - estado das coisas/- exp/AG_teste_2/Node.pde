class Node{
  ArrayList<Node> inlinks = new ArrayList<Node>();
  ArrayList<Node> outlinks = new ArrayList<Node>();
  String label;
  float x;
  float y;
  float r1;
  float r2;
  
  Node(String _label, float _x, float _y){
    label = _label;
    x=_x; 
    y=_y; 
    r1 =3;
    r2=3;
  }
  
  void addIncomingLink(Node n){
    if(!inlinks.contains(n)){
      inlinks.add(n);
    }
  }
  
  ArrayList<Node> getIncomingLinks(){
    return inlinks;
  }
  
  int getIncomingLinksCount(){
    return inlinks.size();
  }
  
  void addOutgoingLink(Node n){
    if (!outlinks.contains(n)){
      outlinks.add(n);
    }
  }
  
  ArrayList<Node> getOutgoingLinks(){
    return outlinks;
  }
  
  int getOutgoingLinksCount(){
    return outlinks.size();
  }
  
  float getShortestLinkLength(){
    if(inlinks.size() == 0 && outlinks.size() == 0){
      return -1;
    }
    float l = 100;
    for (Node inode: inlinks){
      float dx = inode.x - x;
      float dy = inode.y - y;
      float il = sqrt(dx*dx + dy*dy);
      if(il<l){
        l = il;
      }
    }
    for (Node onode: outlinks){
      float dx = onode.x - x;
      float dy = onode.y - y;
      float ol = sqrt(dx*dx + dy*dy);
      if(ol<l){
        l = ol;
      }
    }
    return l;
  }
  
  boolean equals(Node other){
    if (this == other){
      return true;
    }
    return label.equals(other.label);
  }
  
  void setPosition(float _x, float _y){
    x = _x; y = _y;
  }
  
  void setRadii(float _r1, float _r2){
    r1 = _r1; r2 = _r2;
  }
  
  void draw(){
    for(Node o: outlinks){
      drawArrow(x,y,o.x,o.y);
    }
    //noStroke();
    fill(120);
    ellipse(x,y,r1*2,r2*2);
    fill(50,50,255);
    text(label,x+r1*2,y+r2*2);
  }
  
  void drawArrow(float x, float y, float ox, float oy){
    float dx = ox-x;
    float dy = oy-y;
    float angle = getDirection(dx,dy);
    float vl = sqrt(dx*dx+dy*dy) - sqrt(r1*r1+r2*r2)*1.5;
    float[] end = rotateCoordinate(vl, 0, angle);
    stroke(50);
    strokeWeight(0.25);
    line(x,y,x+end[0],y+end[1]);
  }
}
