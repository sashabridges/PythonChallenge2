var queryUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
var layerz = [];
d3.json(queryUrl, function(data) {
  // Once we get a response, send the data.features object to the createFeatures function
  createFeatures(data.features);
});

function createFeatures(earthquakeData) {

  // Define a function we want to run once for each feature in the features array
  // Give each feature a popup describing the place and time of the earthquake
  function onEachFeature(feature, layer) {
	  layer.bindPopup("<h3>" + feature.properties.place + "</h3><hr><p>" + new Date(feature.properties.time) + "</p>");
	  if (feature.properties.mag < 2){
		layerz.push(
		L.circle((feature.geometry.coordinates.slice(0,2)).reverse(),{
			color: "white",
			fillColor: "white",
			fillOpacity: 0.75,
			radius: 2000
		}));
	} else if (2 <= feature.properties.mag <= 4) {
	  	  layerz.push(
		  L.circle((feature.geometry.coordinates.slice(0,2)).reverse(),{
				color: "pink",
				fillColor: "pink",
				fillOpacity: 0.75,
				radius: 4000
			}));
	} else if (4 <= feature.properties.mag <= 6) {
		layerz.push(
		L.circle((feature.geometry.coordinates.slice(0,2)).reverse(),{
			color: "yellow",
			fillColor: "yellow",
			fillOpacity: 0.75,
			radius: 6000
		}));
	} else if (6 <= feature.properties.mag <= 8) {
	  layerz.push(
	  L.circle((feature.geometry.coordinates.slice(0,2)).reverse(),{
			color: "orange",
			fillColor: "orange",
			fillOpacity: 0.75,
			radius: 8000
		}));
	} else if (8 <= feature.properties.mag <= 10) {
	 layerz.push(
	 L.circle((feature.geometry.coordinates.slice(0,2)).reverse(),{
		color: "red",
		fillColor: "red",
		fillOpacity: 0.75,
	 radius: 1000}));
	}
 }
 

  // Create a GeoJSON layer containing the features array on the earthquakeData object
  // Run the onEachFeature function once for each piece of data in the array
  var earthquakes = L.geoJSON(earthquakeData, {
    onEachFeature: onEachFeature
  });
  
   /* layerz = L.geoJSON(layerz, {
	  onEachFeature: onEachFeature
  });  */

  // Sending our earthquakes layer to the createMap function
  createMap(earthquakes);
}

function createMap(earthquakes) {
var streetmap = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox.streets",
  accessToken: API_KEY
});

  var darkmap = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.dark",
    accessToken: API_KEY
  });

  // Define a baseMaps object to hold our base layers
  var baseMaps = {
    "Dark Map": darkmap,
	"Street Map": streetmap
  };
  
  var quakez = L.layerGroup(layerz);

  // Create overlay object to hold our overlay layer
  var overlayMaps = {
    "Earthquakes": earthquakes,
	"quakez": quakez
  };

  // Create our map, giving it the streetmap and earthquakes layers to display on load
  var myMap = L.map("map", {
    center: [
      15.5994, -28.6731
    ],
    zoom: 4,
    layers: [darkmap, streetmap, earthquakes, quakez]
  });

  // Create a layer control
  // Pass in our baseMaps and overlayMaps
  // Add the layer control to the map
  L.control.layers(baseMaps, overlayMaps, {
    collapsed: false
  }).addTo(myMap);
}