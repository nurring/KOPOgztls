<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<style>
div.container-fluid {
	padding-left: 0px;
	padding-right: 0px;
}
</style>
<body>
<div class="container-fluid">
	<div id="div1">
		<%@include file="header.jsp" %>
	</div>
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
			<jsp:include page="bymap.jsp" />
		</div>
	</div>	
</div>
</body>
</html>