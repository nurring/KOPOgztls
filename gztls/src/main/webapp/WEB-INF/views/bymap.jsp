<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/Chart.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="resources/css/Chart.min.css">
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#map {	height: 50%;}
html, body {
	height: 100%;
	margin: 0;
	padding: 0;}
</style>
</head>
<body>
	<div id="map"></div>
	<script type="text/javascript">
	var str = "";
	var arr = new Array();
		$(document).ready(function() {
			window.setInterval(function(){		
				$.ajax({
					url : "bymapjsn",
					type : "POST",				
					error : function() {
						alert("err");
					}
				}).done(function(data){		
					arr = new Array();	
					arr.push(data);
					str = "";
					console.log("arr", typeof(arr));
					str += "[";
					for (var i = 0; i < data.length; i++) {
						str += "{lat: " + data[i].device_latitude + ",";
						str += " lng: " + data[i].device_longitude + "}, "
					}
					str = str.substr(0, str.length - 2);
					str += "]";
					console.log("str", str);
					initMap()
					});
			}, 1000);
		});

		function initMap() {

	        var map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 3,
	          center: {lat: -28.024, lng: 140.887}
	        });

	        // Create an array of alphabetical characters used to label the markers.
	        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	        // Add some markers to the map.
	        // Note: The code uses the JavaScript Array.prototype.map() method to
	        // create an array of markers based on a given "locations" array.
	        // The map() method here has nothing to do with the Google Maps API.
	        var markers = locations.map(function(location, i) {
	          return new google.maps.Marker({
	            position: location,
	            label: labels[i % labels.length]
	          });
	        });

	        // Add a marker clusterer to manage the markers.
	        var markerCluster = new MarkerClusterer(map, markers,
	            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
	      }
	      var locations = [
	        {lat: -31.563910, lng: 147.154312},
	        {lat: -33.718234, lng: 150.363181},
	        {lat: -33.727111, lng: 150.371124},
	        {lat: -33.848588, lng: 151.209834},
	        {lat: -33.851702, lng: 151.216968},
	        {lat: -34.671264, lng: 150.863657},
	        {lat: -35.304724, lng: 148.662905},
	        {lat: -36.817685, lng: 175.699196},
	        {lat: -36.828611, lng: 175.790222},
	        {lat: -37.750000, lng: 145.116667},
	        {lat: -37.759859, lng: 145.128708},
	        {lat: -37.765015, lng: 145.133858},
	        {lat: -37.770104, lng: 145.143299},
	        {lat: -37.773700, lng: 145.145187},
	        {lat: -37.774785, lng: 145.137978},
	        {lat: -37.819616, lng: 144.968119},
	        {lat: -38.330766, lng: 144.695692},
	        {lat: -39.927193, lng: 175.053218},
	        {lat: -41.330162, lng: 174.865694},
	        {lat: -42.734358, lng: 147.439506},
	        {lat: -42.734358, lng: 147.501315},
	        {lat: -42.735258, lng: 147.438000},
	        {lat: -43.999792, lng: 170.463352}
	      ]		
	</script>
	<script
		src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHi_0s7mt5oQXhq27oqOIWylfbDJu7EWE&callback=initMap">
    </script>
</body>
</html>