String[] texts = {"ahsha hashgufs hcjbcka @diajsid sjjakdjhasj djskaskd jcdksjnc",
                  "ksajdj kdlasjkd jlascjkas jckanjc jcdj jdnkas cjnakc",
                "ksjlad @sjadl jsdkasd",
              "gdsa dhgasda hjadhs @ttttt sahjsgj",
            "jksakjs jasjs @hhhhhh" };
                
void setup(){
  String[] names = new String[0];
    for(int i = 0; i < texts.length; i++){
      String[] temp;
      temp = split(texts[i], ' ');
      for(int j = 0; j < temp.length; j++){
        String[] m1 = match(temp[j],"@");
        if(m1 != null){
          String[] nm = names;
          names = new String[nm.length+1];
          for(int w = 0; w < names.length; w++){
            if(w < names.length-1){
              names[w] = nm[w];
            }
            else{
              names[names.length-1] = temp[j];
            }
          }
        }
      }
    }  
    println(names);
}
