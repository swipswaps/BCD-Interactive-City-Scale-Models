/*
This sketch retrieves and parses html data for LUAS station info, like here:
http://luasforecasts.rpa.ie/analysis/view.aspx?id=27
Parsing is based on this:
https://processing.org/tutorials/data/
Indices are found for opening and closing tags (start and end variables) treated as strings of characters. 
A substring is returned that consists of content between start and end indices. The sketch crawls trhough the document until it finds no more tag matches.

Mark Linnane 2019
*/


/* Data input & prep variables*/
String[] data;
String dataString;

/*html parsing variables*/
// html tags
String tableOpen = "<table class=\"table table-hover\">";
String tableClosed = "</table>";
String trOpen = "<tr>";
String trClosed = "</tr>";
String thOpen = "<th>";
String thClosed = "</th>";
String tdOpen = "<td>";
String tdClosed = "</td>";

/*substring variables*/
//substring indices
int start;
int end;

//substring variable
String tableElement;

/*table variables*/
Table table;
int columnCount;
int rowNumber;

void setup() {
  //table to store parsed html table
  table = new Table();
  //Ranelagh Luas station status url
  String ranelagh = "http://luasforecasts.rpa.ie/analysis/view.aspx?id=27";
  //load entire webpage as string array 
  data = loadStrings(ranelagh);
  //convert string array to one space separated string
  dataString = join(data, "");
  //call function to update data from server
  updateData();
}

void updateData() {
  /* crawl through html, looking for table tags */
  //assign <table class=\"table table-hover\"> to start variable
  start = dataString.indexOf(tableOpen);
  //while <table class=\"table table-hover\"> is found
  while (start != -1) {
    //move start index to end of <table class=\"table table-hover\">
    start += tableOpen.length();
    //assign index of next </table> to end variable
    end = dataString.indexOf(tableClosed, start);
    //assign index of current </table> to start variable
    start = dataString.indexOf(tableClosed, start);
    //move start index to end of current </table>
    start += tableClosed.length();
    //move end index to end of current </table>
    end += tableClosed.length();
    //find index of next <table class=\"table table-hover\">
    start = dataString.indexOf(tableOpen, start);
  }
  
  /* crawl through table, looking for row elements */
  start = dataString.indexOf(trOpen, start);
  while (start != -1) {
    start += trOpen.length();
    end = dataString.indexOf(trClosed, start);
    start = dataString.indexOf(trClosed, start);
    start += trClosed.length();
    end += trClosed.length();
    start = dataString.indexOf(trOpen, start);
  }

    /* crawl through rows, looking for table header */
    start = dataString.indexOf(thOpen, start);
    while (start != -1) {
    start += thOpen.length();
    end = dataString.indexOf(thClosed, start);
    
    //write header substring to table object
    tableElement = dataString.substring(start, end); 
    table.addColumn(tableElement);
    
    start = dataString.indexOf(thClosed, start);
    start += thClosed.length();
    end += thClosed.length();
    start = dataString.indexOf(thOpen, start);
  }
  
    /* crawl through rows, looking for table data elements */
    start = dataString.indexOf(tdOpen, start);
    while (start != -1) {
    start += tdOpen.length();
    end = dataString.indexOf(tdClosed, start);
    
    //write table elements substring to table object cells
    tableElement = dataString.substring(start, end);
    table.setString(rowNumber, columnCount, tableElement);
    
    start = dataString.indexOf(tdClosed, start);
    start += tdClosed.length();
    end += tdClosed.length();
    start = dataString.indexOf(tdOpen, start);
    
    //count iteration to wrap data into rows
    columnCount = (columnCount += 1) % 13;
    if (columnCount == 0) {
      rowNumber += 1;
    }
  }
  
  //save table to csv for debugging
  saveTable(table, "table.csv");
  //print a table value for debugging
  print(table.getString(0, 0));
}
