<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="/static/jquery/jquery-1.11.2.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function(){   
        var server_time = 20190901000100;
        $.ajax({
			type : "GET",
			url : "test",
			dataType : 'json',
			data : server_time,
			success : function(data) {
				alert('성공');
			},
			error : function() {
				alert('실패');
			}
		});
    });
</script>
</head>
<body>
</body>
</html>