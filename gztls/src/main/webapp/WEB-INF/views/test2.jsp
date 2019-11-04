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
	$(document).ready(function() {
		window.setInterval(function(){			
		var server_time = 20190901000100;
		$.ajax({
			url : "test2",
			type : "POST",
			data : server_time,
			success : function(data) {
				console.log("data", data);
				var str = "[";
				var html = "";
				for (var i = 0; i < data.length; i++) {
					str += "{lat: " + data[i].device_latitude + ",";
					str += " lng: " + data[i].device_longitude + "},"
				}
				str = str.substr(0, str.length - 1);
				str += "]";
				console.log("str", str);
				$("div").empty();
				html += "<table border=1>"
				for (var i = 0; i < data.length; i++) {
					html += "<tr>";
					html += "<td>" + data[i].device_latitude + "</td>";
					html += "<td>" + data[i].device_longitude + "</td>";
					html += "</tr>";
				}
				html += "</table>"
				$("div").append(html);
			},
			error : function() {
				alert("err");
			}
		});
		}, 1000);
	});
</script>
</head>
<body>
<body>
	<div></div>
</body>
</body>
</html>