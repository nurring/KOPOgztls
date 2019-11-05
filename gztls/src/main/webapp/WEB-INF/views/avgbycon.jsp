<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<head>
<meta charset="UTF-8">
<title>조건검색</title>
<script type="text/javascript">
	function checking() {
		var device_id = $("#device_id").val();
		var server_time = $("#server_time").val();
		var to_date = $("#to_date").val();
		var data_type = $("#data_type").val();
		
		var obj = new Object();
		
		if (device_id){
			obj.device_id = device_id;}
		if (server_time){
			obj.server_time = server_time;}
		if (to_date){
			obj.to_date = to_date;}
		if (data_type){
			obj.data_type = data_type;}

		console.log("obj",obj);
		
		$.ajax({
			url : "avgbyconjsn",
			type : "GET",
			data : obj,
			success : function(data) {
				console.log("data", data);
				alert("good");				
			},
			error : function() {
				alert("err");
			}
		});
	};
</script>
</head>
<body>
	<form method="GET" id="conditionform" onsubmit="return false;">
		<input type="text" id="device_id" placeholder="device_id">
		<input type="text" id="server_time" placeholder="fromdate">
		<input type="text" id="to_date" placeholder="todate">
		<input type="text" id="data_type" placeholder="data_type">
		<input type="submit" id="submit" onclick="checking()">
	</form>
</body>
</html>