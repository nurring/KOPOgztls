<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="resources/js/moment.min.js"></script>
<script src="resources/js/moment-timezone-with-data.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container-fluid {
	color: gray;
}
.inner {
  position: absolute;
  bottom: 0;
}
</style>
<script>
var obj = new Object();	
var dname = "";
var html = "";
$(document).ready(function() {		
	updateDev();
	
	function updateDev(){
		$.ajax({
			url : "dlistjsn",
			type : "GET",
			error : function() {
				console.log(error);
			}			
		}).done(function(results){
			$('#deviceinfo').find('option').remove();
			$('#deviceinfo').append("<option value=''>기기 선택</option>");
			for(key in results) {
				$('#deviceinfo').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
			}	
		});
	};

});

function deviceOne(device){
	var deviname =	"";
	obj.device_id = device;	
	window.setInterval(function(){	
	$.ajax({
		url : "nowjsn",
		data : obj,
		type : "GET",
		error : function() {
			alert("err");
		}			
	}).done(function(results){		
		console.log("results",results);		
		html = ""; deviname = "";	
		for(key in results[0].successList){
			$('#timeinsert').html(moment(results[0].successList[key].server_time).format('YYYY-MM-DD HH:mm'));			
			
			deviname = 	results[0].device_name;	
			if (results[0].successList[key].data_type == "H"){
				html += "<h3>"+results[0].successList[key].data_content+" %</h3>"
				}
			if (results[0].successList[key].data_type == "T"){
				html += "<h3>"+results[0].successList[key].data_content+" ℃</h3>"
				}
			if (results[0].successList[key].data_type == "D1"){
				html += "<h3>"+results[0].successList[key].data_content+" μm</h3>"
				}
			if (results[0].successList[key].data_type == "D2"){
				html += "<h3>"+results[0].successList[key].data_content+" μm</h3>"
				}
			}
			$('#datainsert').html(html);
			$('#title').html("현재 데이터 - "+deviname)	
			
			
	});
	}, 2000);
};
function reloading(){
	var device_id = $("#deviceinfo").val();
	deviceOne(device_id);
}
</script>
</head>
<body>
<div class="container-fluid">	
	<h1 class="display-4" id="title" style="margin-bottom:100px;">현재 데이터</h1>
	<div class="row align-items-end">
		<div class="col order-first">
			<h3>습도</h3>
			<h3>온도</h3>
			<h3>미세먼지</h3>
			<h3>초미세먼지</h3>
		</div>
		<div class="col" id="datainsert"></div> 	
		<div class="col">
			<h3 align="right" id="timeinsert"></h3>			
		</div>
	</div>
	<div style="margin-top:50px;">
		<select id="deviceinfo" name="deviceinfo" onchange="deviceOne(this.value);"></select>
		<button class="btn btn-dark" style="float: right;" onclick="reloading();">새로고침</button>
	</div>
	<p class="font-weight-light font-italic">기기를 선택하면 현재 데이터 현황을 확인하실 수 있습니다.</p>
</div>

</body>
</html>