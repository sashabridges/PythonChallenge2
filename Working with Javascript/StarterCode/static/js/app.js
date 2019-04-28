// from data.js
var tableData = data;

// YOUR CODE HERE!
var tbody = d3.select("tbody");
 
 // loop through tableData
 // use d3 to append tr 
 // use Object.entries to go through the ufoReports and select the key/value and print it to the console
 // append cells to each row
 // put the text values into the cells
data.forEach(function(ufoReport) {
  console.log(ufoReport);
  var row = tbody.append("tr");
  Object.entries(ufoReport).forEach(function([key, value]) {
    console.log(key, value);
    var cell = tbody.append("td");
	cell.text(value);
   });
 });

submit.on("click", function() {
  // Prevent the page from refreshing
  d3.event.preventDefault();

  // Select the input element and get the raw HTML node
  var inputElement = d3.select("#example-form-input");

  // Get the value property of the input element
  var inputValue = inputElement.property("value");
  
     // datetime
    //city
    //state
    //country
    // shape
  var filteredData = tableData.filter((sighting => sighting.datetime === inputValue) || (sighting => sighting.city === inputValue) || (sighting => sighting.state === inputValue) || (sighting => sighting.country === inputValue) || (sighting => sighting.shape === inputValue));
  
  filteredData.forEach(function (tableFilter){
	  var row = tbody.append("tr");
	  Object.entries(tableFilter).forEach(function([key, value]){
		  var cell = tbody.append("td");
		  cell.text(filteredData);
	  });
  });

  console.log(inputValue);
});