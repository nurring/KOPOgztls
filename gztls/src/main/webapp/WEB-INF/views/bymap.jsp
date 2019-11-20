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
	  width: 80%;
	  background-color: grey;
	  margin: 10px;
	}
</style>
<script type="text/javascript">
var lat, lng, id, name, address;
var html = "";
$(document).ready(function() {	
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			alert("err");
		}			
	}).done(function(results){
		console.log("results",results);
		html += "<table class='table table-bordered'>";
		for(key in results) {
			html += "<tr><td><a href='javascript:void(0)' ";
			html += "onclick='initMapEach("+results[key].device_latitude+","+results[key].device_longitude+");getdevice(\""+results[key].device_id+"\");'>"
			html += results[key].device_name+"</a></td>"
			html += "<td>"+results[key].device_address+"</td></tr>";
		}
		html +="</table>"
		$('#list').html(html);
	});
});
</script>
</head>
<body>
<div>
	
	<div id="map" class="mx-auto"></div>
	<div id="search">			
		<form onsubmit="return false;">
			<select id="con" name="con">
				<option value=''>검색 조건</option>
				<option value='device_name'>기기명</option>
				<option value='device_address'>주소</option>
			</select>
			<input type="text" id="keyword" placeholder="입력">
			<button type="submit" class='btn btn-dark' id="submit" onclick="searching()">검색</button>
			<button class="btn btn-dark" style="float: right;" onclick='initMap();searching();'>전체보기</button>
		</form>
		<p class="font-weight-light font-italic" >기기명과 주소를 검색하여 지도 상 위치를 확인하세요.</p>
	</div>
	<div id="list"></div>
</div>
<script>
function searching(){
	var obj = new Object();
	var con = $("#con").val();
	var keyword = $("#keyword").val();
	var add = "";
	if (con == "device_name"){
		obj.device_name = keyword;
		}
	if (con == "device_address"){
		obj.device_address = keyword;
		}
	console.log(obj);
	$.ajax({
		url : "searchjsn",
		type : "GET",
		data : obj,
		error : function() {
			alert("err");
		}			
	}).done(function(results){
		add += "<table class='table table-bordered'>";
		for(i in results){			
			add += "<tr><td><a href='javascript:void(0)' onclick='initMapEach("
					+results[i].device_latitude+","+results[i].device_longitude
					+"); getdevice(\""+results[i].device_id+"\");'>"
					+results[i].device_name+"</a></td>";
			add += "<td>"+results[i].device_address+"</td>";			
		}
		add += "</table>"
		$('#list').html(add);
		$('#keyword').val('');
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
			console.log(results);
			add += "<table class='table table-bordered'>";
			if (results.length != 0){
				for(i in results){
					add += "<tr><td colspan='4'>"+results[i].device_name+"</td><tr>";
					add += "<tr><td colspan='4'>"+results[i].device_address+"</td><tr>";
					add += "<tr>";
					for(j in results[i].successList){
						add += "<td>"+results[i].successList[j].data_type+"</td>";
					}				
					add += "</tr>";
					for(j in results[i].successList){
						add += "<td>"+results[i].successList[j].data_content+"</td>";
					}
				}
			}			
			else {add += "<tr><td>현재 시각 데이터 없음</td>"}
			add += "</tr></table>"
			console.log(add);
			$('#list').html(add);
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
console.log("arr",arr);
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
console.log("avglat",avglat);
console.log("avglng",avglng);
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