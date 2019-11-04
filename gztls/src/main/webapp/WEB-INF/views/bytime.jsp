<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function checking() {
		var server_time = $("#server_time").val();
		var set = {'server_time': server_time};
		console.log("server_time", server_time);
		console.log("set", set);
		$.ajax({
			url : "bytimejsn/"+server_time,
			type : "GET",
			data : set,
			success : function(data) {
				console.log("data", data);
				alert("good");				
			},
			error : function() {
				alert("err");
			}
		});
		 //<- 이 문장으로 새로고침(reload)이 방지됨
	};
</script>
</head>
<body>
<body>
	<form method="GET" id="timeform" onsubmit="return false;">
		<input type="text" id="server_time">
		<input type="submit" id="submit" onclick="checking()">
	</form>
	<div></div>
</body>
</body>
</html>