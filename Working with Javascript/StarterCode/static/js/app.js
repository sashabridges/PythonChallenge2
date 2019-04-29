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
 
var submit = d3.select("#submit");

submit.on("click", function() {
  // Prevent the page from refreshing
  d3.event.preventDefault();
  
  d3.selectAll("tr").remove();

  // Select the input element and get the raw HTML node
  var inputElement = d3.select("#datetime");

  // Get the value property of the input element
  var inputValue = inputElement.property("value");
	
	// filter based on datetime
  var filteredData = tableData.filter(sighting => sighting.datetime === inputValue);
  
  // filter further based on city
  inputElement = d3.select("#city");
  inputValue = inputElement.property("value");
  filteredData = filteredData.filter(sighting => sighting.city === inputValue);
  
  // filter further based on state
  inputElement = d3.select("#state");
  inputValue = inputElement.property("value");
  filteredData = filteredData.filter(sighting => sighting.state === inputValue);  
  
  // filter further based on country
  inputElement = d3.select("#country");
  inputValue = inputElement.property("value");
  filteredData = filteredData.filter(sighting => sighting.country === inputValue);
  
  // filter further based on shape
  inputElement = d3.select("#shape");
  inputValue = inputElement.property("value");
  filteredData = filteredData.filter(sighting => sighting.shape === inputValue);
  
  filteredData.forEach(function (tableFilter){
	  var row = tbody.append("tr");
	  Object.entries(tableFilter).forEach(function([key, value]){
		  var cell = tbody.append("td");
		  cell.text(filteredData);
	  });
  });

  console.log(inputValue);
});