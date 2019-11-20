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
<script type="text/javascript">
var html="";
$(document).ready(function() {	
	updateDevice(); 
	$.ajax({
		url : "err24jsn",
		type : "GET",
		error : function() {
			alert("err");
		}
	}).done(function(results){
		html="";
		html+="<table border=1>"
		console.log("results",results);
		for(i in results){
			html+="<tr><td>기기명</td><td>에러 타입</td><td>에러 메시지</td><td>발생 시각</td>";
			html+="<tr><td rowspan="+results[i].errorList.length+">";
			html+=results[i].device_name;
			html+="</td>"
			for(j in results[i].errorList){
			html+="<td>"+results[i].errorList[j].err_type+"</td>";
			html+="<td>"+results[i].errorList[j].err_message+"</td>";
			html+="<td>"+moment(results[i].errorList[j].server_time).format('YYYY/MM/DD HH:mm:ss')+"</td></tr>";			
			}
		}
		html+="</table>"
		$('#errtable').html(html);
		});

});
function updateDevice(){
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			console.log(error);
		}			
	}).done(function(results){
//		console.log("results",results);
		$('#device').find('option').remove();
		$('#device').append("<option value=''>기기 선택</option>");
		for(key in results) {
			$('#device').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
		}	
	});
};
</script>
</head>
<body>
<div class="container-fluid">
	<h3>24H 에러 발생 목록</h3>
	<div>
		<select id="device" name="device" onchange="deviceSelect(this.value);"></select>
	</div>
	<div id="errtable"></div>
</div>
</body>
</html>