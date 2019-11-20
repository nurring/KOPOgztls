<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="row" style="padding: 10px; margin: 0px;">
	<div class="col-md-6">
		<jsp:include page="datanow.jsp" />		
	</div>
	<div class="col-md-6">			
		<jsp:include page="byperiod.jsp" />
	</div>
</div>
<div class="row" style="padding: 10px; margin: 0px;">
	<div class="col-md-6">
	<jsp:include page="avgbycon.jsp" />
	</div>
	<div class="col-md-6">
		<jsp:include page="bymap2.jsp" />
	</div>
</div>
</body>
</html>