<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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

</script>
</head>
<body>
<div class="container">
	<div id="map"></div>
	<div id="search" class="py-2 offset-md-1">	
		<c:forEach items="${list }" var="e">
		<button class='btn btn-dark' onclick="initMapEach(${e.device_latitude },${e.device_longitude });getdevice('${e.device_id }');">
			${e.device_name }</button>		
		</c:forEach>
		<input type="text" id="device_name" placeholder="기기명을 입력하세요">
		<button type="submit" class='btn btn-dark' id="submit" onclick="checking()">검색</button>
	</div>
	<div id="haha"></div>
</div>
<script>
function checking(){
	var device_name = $("#device_name").val();
	var obj = new Object();
	obj.device_name = device_name;
	console.log(obj);
	$.ajax({
		url : "bynamejsn",
		type : "GET",
		data : obj,
		error : function() {
			alert("err");
		}			
	}).done(function(results){
		alert(results);
		console.log(results);
		//검색어완성기능 넣을까...?
	});
}
<!--상세 날씨 정보 가져오기-->
function getdevice(d_id) {
	var set = new Object();
	set.device_id = d_id;
	console.log("set",set);
	var add = "";
	 $.ajax({
			url : "bymapjsn",
			type : "GET",
			data : set,
			error : function() {
				alert("err");
			}			
		}).done(function(results){
			add += "<table class='table'>";			
			for(i in results){
				add += "<tr><td colspan='4'>기기명: "+results[i].device_name+"</td><tr>";
				add += "<tr><td colspan='4'>주소: "+results[i].device_address+"</td><tr>";
				add += "<tr>";
				for(j in results[i].successList){
					add += "<td>"+results[i].successList[j].data_type+"</td>";
					}				
				add += "</tr>";
				for(j in results[i].successList){
					add += "<td>"+results[i].successList[j].data_content+"</td>";
					}
				}
			add += "</tr></table>"
			console.log(add);
			$('#haha').html(add);
		});
}

<!--지도 중점 찾기-->
var info = new Array();
var arr = new Array();
var avglat = 0;var avglng = 0;
<c:forEach items="${list}" var="e">
	info.lat = ${e.device_latitude };
	info.lng = ${e.device_longitude };
	avglat += ${e.device_latitude }
	avglng += ${e.device_longitude };
	arr.push(info);
	info = new Array();
</c:forEach>
console.log(arr);

avglat = avglat/${fn:length(list) }
avglng = avglng/${fn:length(list) }

function initMapEach(_lat, _lng) {
	var newlat = _lat;
	var newlng = _lng;
	var uluru = {lat: newlat, lng: newlng};
	var map = new google.maps.Map(
	document.getElementById('map'), {zoom: 10, center: {lat: avglat, lng: avglng}});
	var marker = new google.maps.Marker({position: uluru, map: map});

	var infoWindow = new google.maps.InfoWindow({
	      content: "위도: "+newlat+", 경도: "+newlng
	 });
    google.maps.event.addListener(marker, 'click', function(){
			infoWindow.open(map, marker)
    });    
}

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10,
      center: {lat: avglat, lng: avglng}
    });
    var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
    var markers = locations.map(function(location, i) {                
      return new google.maps.Marker({
          position: location,
          label: labels[i % labels.length]
        });
    });
   
    var markerCluster = new MarkerClusterer(map, markers,
        {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
  }
  var locations = arr;	
	
</script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
	<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHi_0s7mt5oQXhq27oqOIWylfbDJu7EWE&callback=initMap">
	</script>

</body>
</html>