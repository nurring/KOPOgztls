<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style='display:inline;'><!--빨간 부분-->

<div style="display:inline; float:left; width:50%;">
	<jsp:include page="byperiod.jsp"/>
</div>

<div style="display:inline; float:left;width:50%;" >
	<jsp:include page="bymap.jsp"/>
</div>
	
</div>
</body>
</html>