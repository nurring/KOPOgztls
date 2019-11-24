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
<style>
.container {
	color: gray;
}
</style>
</head>
<body>
<div class="container">	
	<div id="map" class="mx-auto" style="width:90%;height:550px;"></div>
	<h3>24시간 내 에러 발생 목록 (전체)</h3>
	<div id="errtable"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b0046eb968ae938c420eab6c01f02df4&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
var html="";
var arr = new Array();
var set = new Object();		
var centerlat=0; var centerlng=0; var lnth=0;
$(document).ready(function() {				
	//updateDevice(); 
	$.ajax({
		url : "err24jsn",
		type : "GET",
		error : function() {
			alert("err");
		}
	}).done(function(results){		
		function temp(lat, lng){
			return "new kakao.maps.LatLng("+lat+", "+lng+")";
			}
		html="";
		html+="<table class='table'>"
		html+="<thead><tr><td>기기명</td><td>에러 타입</td><td>에러 메시지</td><td>발생 시각</td></thead>";
		console.log("results",results);
		lnth=results.length;
		for(i in results){
			set=[];
			html+="<tr><td rowspan="+results[i].errorList.length+">";
			html+=results[i].device_name;
			html+="</td>"
				
			centerlat+=results[i].device_latitude;
			centerlng+=results[i].device_longitude;
			console.log("centerlat",centerlat);
			console.log("centerlng",centerlng);
			console.log("lnth",lnth);
			
			set.content=results[i].device_name+"<br>건수 :"+results[i].errorList.length+"건";
			set.latlng= temp(results[i].device_latitude,results[i].device_longitude);
			arr.push(set);
			
			for(j in results[i].errorList){
			html+="<td>"+results[i].errorList[j].err_type+"</td>";
			html+="<td>"+results[i].errorList[j].err_message+"</td>";
			html+="<td>"+moment(results[i].errorList[j].server_time).format('YYYY/MM/DD HH:mm:ss')+"</td></tr>";			
			}
		}

		centerlat = centerlat/lnth;
		centerlng = centerlng/lnth;
		console.log("centerlat",centerlat);
		console.log("centerlng",centerlng);

		html+="</table>"
		$('#errtable').html(html);

		console.log("arr",arr);

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(centerlat, centerlng), // 지도의 중심좌표
	        level: 10 // 지도의 확대 레벨
	    };
		
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다///////////////////
	var mapTypeControl = new kakao.maps.MapTypeControl();		
	// 지도 타입 컨트롤을 지도에 표시합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


	// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	var positions="[";
	for (i=0; i<arr.length; i++){
		positions += "{content: '"+arr[i].content+"', latlng: "+arr[i].latlng+"},"
		}
	positions+="]";
	console.log("positions",positions);
	positions= eval(positions);
	

	for (var i = 0; i < positions.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].content // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
	});
	
});
//function updateDevice(){
//	$.ajax({
//		url : "dlistjsn",
//		type : "GET",
//		error : function() {
//			console.log(error);
//		}			
//	}).done(function(results){
//		$('#device').find('option').remove();
//		$('#device').append("<option value=''>기기 선택</option>");
//		for(key in results) {
//			$('#device').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
//		}	
//	});
//};
//function deviceSelect(did){
//	
//}
	
</script>
</div>
</body>
</html>