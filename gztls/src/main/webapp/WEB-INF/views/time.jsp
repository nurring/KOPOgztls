<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출력쓰~</title>
<style>
	#map {
	  width: 100%;
	  height: 400px;
	  background-color: grey;
	}
</style>
<script type="text/javascript">
var list = new Array();
<c:forEach items="${list}" var="e">
list.push("${e.device_latitude}");
list.push("${e.device_longitude}")
</c:forEach>
</script>
</head>
<body>
	<h1>특정 일자 데이터 출력쓰!</h1>
	<hr>
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>위도</td>
			<td>경도</td>
			<td>측정종류</td>
			<td>측정값</td>
			<td>서버날짜</td>
		</tr>
		<c:forEach items="${list }" var="e">
			<tr>
				<td rowspan="${fn:length(e.successList) }">${e.device_id }</td>
				<td rowspan="${fn:length(e.successList) }">${e.device_latitude }</td>
				<td rowspan="${fn:length(e.successList) }">${e.device_longitude }</td>
				<c:forEach items="${e.successList }" var="f">
					<td>${f.data_type }</td>
					<td>${f.data_content }</td>
					<td>${f.server_time }</td>
				
			</tr>
				</c:forEach>
		</c:forEach>

	</table>
	<br>
<div id="map"></div>
<script>

function initMap() {

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10,
      center: {lat: 37.385847, lng: 127.121260}
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
    {lat: 37.385847, lng: 127.121260},
    {lat: 37.385847, lng: 127.121260},
    {lat: 37.385847, lng: 127.121260}
  ]
</script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
	<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHi_0s7mt5oQXhq27oqOIWylfbDJu7EWE&callback=initMap">
	</script>
</body>
</html>