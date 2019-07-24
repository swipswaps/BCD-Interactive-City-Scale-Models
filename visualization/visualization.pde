String[] data;
String dataString;
int start;
int end;

Table table;

//String openTag = "<table>";
String tableOpen = "<table class=\"table table-hover\">";
String tableClosed = "</table>";
String trOpen = "<tr>";
String trClosed = "</tr>";
String thOpen = "<th>";
String thClosed = "</th>";
String tdOpen = "<td>";
String tdClosed = "</td>";

void setup() {
  table = new Table();
  //Ranelagh Luas status url
  String ranelagh = "http://luasforecasts.rpa.ie/analysis/view.aspx?id=27";
  data = loadStrings(ranelagh);
  dataString = join(data, "");
  start = 0;

  start = dataString.indexOf(tableOpen);
  while (start != -1) {
    start += tableOpen.length();
    end = dataString.indexOf(tableClosed, start);
    //println(dataString.substring(start, end)); // Nest child loop here!!!!
    start = dataString.indexOf(tableClosed, start);
    start += tableClosed.length();
    end += tableClosed.length();
    start = dataString.indexOf(tableOpen, start);
  }

  start = dataString.indexOf(trOpen, start);
  while (start != -1) {
    start += trOpen.length();
    end = dataString.indexOf(trClosed, start);
    //println(dataString.substring(start, end));
    start = dataString.indexOf(trClosed, start);
    start += trClosed.length();
    end += trClosed.length();
    start = dataString.indexOf(trOpen, start);
  }

  start = dataString.indexOf(thOpen, start);
  while (start != -1) {
    start += thOpen.length();
    end = dataString.indexOf(thClosed, start);
    println(dataString.substring(start, end)); /// Table Header
    start = dataString.indexOf(thClosed, start);
    start += thClosed.length();
    end += thClosed.length();
    start = dataString.indexOf(thOpen, start);
  }

  start = dataString.indexOf(tdOpen, start);
  while (start != -1) {
    start += tdOpen.length();
    end = dataString.indexOf(tdClosed, start);
    println(dataString.substring(start, end)); ///Table contents
    start = dataString.indexOf(tdClosed, start);
    start += tdClosed.length();
    end += tdClosed.length();
    start = dataString.indexOf(tdOpen, start);
  }
}
