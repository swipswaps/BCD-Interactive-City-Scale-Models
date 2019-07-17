void setup() {
  size(200, 200);
  //Ranelagh Luas XML
  String ranelagh = "https://luasforecasts.rpa.ie/xml/get.ashx?action=forecast&stop=ran&encrypt=false";
  //local dummy data
  String data = "dummyData.xml";
  XML stopInfo = loadXML(data);
  XML stopChild = stopInfo.getChild("direction/tram");
  int childContent = stopChild.getInt("dueMins");
  
  print(childContent);
}


void draw() {

}










/*
// Grab the data from Luas API
void loadData() {
  // Get the raw HTML source into an array of strings
  // (each line is one element in the array)
  String url = "https://luasforecasts.rpa.ie/xml/get.ashx?action=forecast&stop=try&encrypt=false";
  String[] lines = loadStrings(url);
  //Turn array into one long String
  String html = join(lines, "");
  
  // Search for tram due time
  String start = "<tram dueMins>";
  String end = "</time>";
  runningtime = giveMeTextBetween(html, start, end);

  // Searching for poster image
  start = "<link rel='image_src' href=\"";
  end = "\">";
  String imgUrl = giveMeTextBetween(html, start, end);
  poster = loadImage(imgUrl);
}

// A function that returns a substring between two substrings
String giveMeTextBetween(String s, String before, String after) {
  String found = "";
  int start = s.indexOf(before);     // Find the index of the beginning tag
  if (start == -1) {
    return "";   // If we don't find anything, send back a blank String
  }    
  start += before.length();          // Move to the end of the beginning tag
  int end = s.indexOf(after, start); // Find the index of the end tag
  if (end == -1) {
    return "";          // If we don't find the end tag, send back a blank String
  }
  return s.substring(start, end);    // Return the text in between
}
*/
