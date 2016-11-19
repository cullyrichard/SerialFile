 String readString = "";

void parseCommand(String command)
{
  if (command == "r")
  {
    delay(500);
    for (size_t i = 0; i < 100; i++) {
      delay(4);
      Serial.println("Waddup "+String(millis()));
    }
    delay(2);
    Serial.println("EOF");
  }
}

void setup()
{
  Serial.begin(9600);
  strip.begin();
}

void loop()
{

  while (Serial.available()) // While receiving characters over serial...
  {
    delay(3); // Necessary delay
    char c = Serial.read(); // Read the character
    readString += c; // Add the character to the string
  }

  readString.trim();

  if (readString.length() > 0) // If a string has been read...
  {
    parseCommand(readString); // Do something with the string...
    readString = ""; // Clear the string
  }

}
