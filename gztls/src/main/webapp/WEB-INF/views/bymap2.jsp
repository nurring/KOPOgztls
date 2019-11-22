<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/moment.min.js"></script>
<meta charset="UTF-8">
</head>
<body>
<div class="container">	
<div id="map" class="mx-auto" style="width:90%;height:450px;"></div>
<div id="search">			
	<form onsubmit="return false;">
		<select id="con" name="con">
			<option value='device_name'>기기명</option>
			<option value='device_address'>주소</option>
		</select>
		<input type="text" id="keyword" placeholder="입력">
		<button type="submit" class='btn btn-dark' id="submit" onclick="searching()">검색</button>
	</form>
	<p class="font-weight-light font-italic" >기기명 또는 주소를 검색하여 지도 상 위치를 확인하세요.</p>
</div>
<div id="list"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b0046eb968ae938c420eab6c01f02df4&libraries=services,clusterer,drawing"></script>
<script>
var arr = new Array();
var arr2 = new Array();
var set = new Object();
var centerlat=0; var centerlng=0; var lnth=0;
var add = "";
$(document).ready(function() {
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			alert("err");
		}
	}).done(function(results){
		console.log(results);
		lnth=results.length;

		add = "<table class='table table-bordered'>";
		for(i in results){
			//지도
			set=[];
			set.content=results[i].device_name;
			set.latlng= temp(results[i].device_latitude,results[i].device_longitude);
			arr.push(set);						
			centerlat+=results[i].device_latitude;
			centerlng+=results[i].device_longitude;		

			//테이블		
			add += "<tr><td><a href='javascript:void(0)' onclick=\"getOne(\'"+results[i].device_name+"\',"+results[i].device_latitude+","+results[i].device_longitude+");\">"+results[i].device_name+"</a></td>";
			add += "<td>"+results[i].device_address+"</td></tr>";
		}
		//지도
		centerlat = centerlat/lnth;
		centerlng = centerlng/lnth;
		getmap(arr,centerlat,centerlng);

		//테이블
		add += "</table>"
		$('#list').html(add);
	});	
});

function getmap(arr, clat, clng){
	console.log("getarr",arr);
	console.log("getclat",clat);
	console.log("getclng",clng);
	
	var mapContainer = document.getElementById('map'), 
	mapOption = { 
	    center: new kakao.maps.LatLng(clat, clng),
	    level: 11 // 지도의 확대 레벨
	};		
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var mapTypeControl = new kakao.maps.MapTypeControl();	
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	var positions="[";
	for (i=0; i<arr.length; i++){
		positions += "{content: '"+arr[i].content+"', latlng: "+arr[i].latlng+"},"
	}
	positions+="]";
	console.log("positions",positions);
	positions= eval(positions);		
	
	for (var i = 0; i < positions.length; i ++) {
		var marker = new kakao.maps.Marker({
		    map: map,
		    position: positions[i].latlng
		});		
		
		var infowindow = new kakao.maps.InfoWindow({
		    content: positions[i].content
		});		
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}		
	function makeOverListener(map, marker, infowindow) {
		return function() {
		    infowindow.open(map, marker);
		};
	}		
	function makeOutListener(infowindow) {
		return function() {
		    infowindow.close();
		};
	}
}

function searching(){
	var obj = new Object();
	var con = $("#con").val();
	var keyword = $("#keyword").val();
	var html = "";
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
		console.log(results);
		lnth=results.length;
		
		html += "<table class='table table-bordered'>";
		for(i in results){		
			//테이블
			html += "<tr><td><a href='javascript:void(0)' onclick=\"getOne(\'"+results[i].device_name+"\',"+results[i].device_latitude+","+results[i].device_longitude+");\">"+results[i].device_name+"</a></td>";
			html += "<td>"+results[i].device_address+"</td></tr>";	


			//지도
			set=[];
			set.content=results[i].device_name;
			set.latlng= temp(results[i].device_latitude,results[i].device_longitude);
			arr2.push(set);						
			centerlat+=results[i].device_latitude;
			centerlng+=results[i].device_longitude;	
		}
		html += "</table>"
		$('#list').html(html);
		$('#keyword').val('');

		//지도
		centerlat = centerlat/lnth;
		centerlng = centerlng/lnth;
		console.log("arr2",arr2);
		console.log("centerlat",centerlat);
		console.log("centerlng",centerlng);
		//getmap(arr2,centerlat,centerlng);왜안되냐..이전 객체를 remove?destroy?하는 방법 뭘까
	});
}


function getOne(con, lat, lng){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 마커를 표시할 위치입니다 
	var position =  new kakao.maps.LatLng(lat, lng);

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	  position: position
	});

	// 마커를 지도에 표시합니다.
	marker.setMap(map);

	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div style="padding:5px;">'+con+'</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    content : iwContent
	});

	// 마커에 마우스오버 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseover', function() {
	  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
	    infowindow.open(map, marker);
	});

	// 마커에 마우스아웃 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseout', function() {
	    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
	    infowindow.close();
	});
}
function temp(lat, lng){
	return "new kakao.maps.LatLng("+lat+", "+lng+")";
	}
</script>
</div>
</body>
</html>