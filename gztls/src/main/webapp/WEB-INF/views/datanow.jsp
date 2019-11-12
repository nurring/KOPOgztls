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
	obj.device_id = device;	
	$.ajax({
		url : "nowjsn",
		data : obj,
		type : "GET",
		error : function() {
			alert("err");
		}			
	}).done(function(results){		
		console.log("results",results);		
		html = "";	
		for(key in results[0].successList){
			$('#timeinsert').html(moment(results[0].successList[key].server_time).format('YYYY-MM-DD HH:mm'));
			$('#title').html(results[0].device_name+"의 데이터 현황")			
			if (results[0].successList[key].data_type == "H"){
				html += "<h3>"+results[0].successList[key].data_content+"</h3>"
				}
			if (results[0].successList[key].data_type == "T"){
				html += "<h3>"+results[0].successList[key].data_content+"</h3>"
				}
			if (results[0].successList[key].data_type == "D1"){
				html += "<h3>"+results[0].successList[key].data_content+"</h3>"
				}
			if (results[0].successList[key].data_type == "D2"){
				html += "<h3>"+results[0].successList[key].data_content+"</h3>"
				}
			}
			$('#datainsert').html(html);
			
			
	});
};
</script>
</head>
<body>
<div class="container-fluid">
	<h1 class="display-3" id="title">
		데이터 현황 <h5>기기를 선택하세요</h5>
	</h1>
	<div class="row">
	  <div class="col order-first">
		<h3>습도</h3>
		<h3>온도</h3>
		<h3>미세먼지</h3>
		<h3>초미세먼지</h3>
	  </div>
	  <div class="col" id="datainsert">
	  </div>  
	</div>
	<h3 align="right" id="timeinsert"></h3>
	<select id="deviceinfo" name="deviceinfo" onchange="deviceOne(this.value);"></select>
</div>

</body>
</html>