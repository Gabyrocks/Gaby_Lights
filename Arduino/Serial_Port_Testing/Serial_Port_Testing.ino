

void setup()
{
  Serial.begin(115200);
 pinMode(13, OUTPUT);
 digitalWrite(13, LOW); 

}

void loop()
{
String content = "";
if (Serial.available()) {
  
  while (Serial.available()) {
    content += Serial.read();
  }
}
long data[16]; //The results will be stored here
for(int i = 0; i < 16; i++){
  int index = content.indexOf(":"); //We find the next comma
  data[i] = atol(content.substring(0,index).c_str()); //Extract the number
  content = content.substring(index+1); //Remove the number from the string
}

//if(data [0] > 16){ 
digitalWrite(13, HIGH); 

//}

}0
