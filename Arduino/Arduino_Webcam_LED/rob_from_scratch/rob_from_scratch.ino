void setup(){
  Serial.begin(9600);

  pinMode(13, OUTPUT);
  digitalWrite(13,LOW);

  }
  
  
  char valx; 
  int ledPin = 13; // Set the pin to digital I/O 13


void loop(){
  
  if (Serial.available() > 0) {
    
    valx = Serial.read(); // read it and store it in val
    if (valx == '1') 
   { // If 1 was received
     digitalWrite(ledPin, LOW); // turn the LED on
   } else {
     digitalWrite(ledPin, HIGH); // otherwise turn it off
   }
   delay(10); // Wait 10 milliseconds for next reading
  
  }
}
