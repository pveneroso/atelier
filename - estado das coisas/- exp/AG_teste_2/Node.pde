class Node{
  ArrayList<Node> inlinks = new ArrayList<Node>();
  ArrayList<Node> outlinks = new ArrayList<Node>();
  String label;
  float x;
  float y;
  float r1;
  float r2;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;    // Maximum steering force
  float maxspeed;  // Maximum speed
  float cohesion_factor = 0.5;
  
  Node(String _label, float _x, float _y){
    label = _label;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(_x,_y);
    maxspeed = 1;
    maxforce = 0.05;
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
      float dx = inode.position.x - position.x;
      float dy = inode.position.y - position.y;
      float il = sqrt(dx*dx + dy*dy);
      if(il<l){
        l = il;
      }
    }
    for (Node onode: outlinks){
      float dx = onode.position.x - position.x;
      float dy = onode.position.y - position.y;
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
    position.x = _x; position.y = _y;
  }
  
  void setRadii(float _r1, float _r2){
    r1 = _r1; r2 = _r2;
  }
  
  void draw(){
    for(Node o: inlinks){
      drawArrow(position.x,position.y,o.position.x,o.position.y);
    }
    //noStroke();
    fill(120);
    ellipse(position.x,position.y,r1*2,r2*2);
    fill(50,50,255);
    text(label,position.x+r1*2,position.y+r2*2);
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
  
  void flock(ArrayList<Node> nodes){
    PVector sep = separate(nodes);
    PVector coh = cohesion();
    
    sep.mult(1.0);
    coh.mult(0.2);
    
    applyForce(sep);
    applyForce(coh);
    
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    
    position.add(velocity);
    
    acceleration.mult(0);
    
     if (position.x < 0) {
      position.x = width;
    } else if (position.x > width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = height;
    } else if (position.y > height) {
      position.y = 0;
    }
    
    draw();
  }
  
  
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  PVector seek(PVector target){
    PVector desired = PVector.sub(target,position);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }  
  PVector cohesion(){
    float neighbordist_cohesion = 1000;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Node node: inlinks){
      float d = PVector.dist(position, node.position);
      if ((d > 0) && (d < neighbordist_cohesion)){
        sum.add(node.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0,0);
    }
  }

  
  PVector separate(ArrayList<Node> nodes){
    float desiredseparation = 200;
    float desiredseparation_other = 500;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    
    for (Node node : inlinks){
      float d = PVector.dist(position,node.position);
      if ((d > 0) && (d < desiredseparation)){
        PVector diff = PVector.sub(position, node.position);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        count++;
      }
    }
    
    for (Node node : nodes){
      if(!nodes.contains(node)){
        float d = PVector.dist(position,node.position);
        if ((d > 0) && (d < desiredseparation_other)){
          PVector diff = PVector.sub(position, node.position);
          diff.normalize();
          diff.div(d);
          steer.add(diff);
          count++;
        }
      }
    }
    
    if (count > 0) {
      steer.div((float)count);
    }
    
    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    
    return steer;
  }
  
  void mouseDragged(){
    if(mouseX <= position.x + r1 && mouseX >= position.x - r1 && mouseY <= position.y + r1 && mouseY >= position.y - r1){
      position.x = mouseX;
      position.y = mouseY;
    }
  }
}
  
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
