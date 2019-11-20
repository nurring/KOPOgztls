<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
	<button class="btn btn-primary" role="button" onclick="servertimeinsert()">서버시간 랜덤 데이터 넣기</button>
	<button class="btn btn-primary" role="button" onclick="deviceinsert()">디바이스 추가</button>
	<button class="btn btn-primary" role="button" onclick="servertimeerror()">서버시간 에러 데이터 넣기1</button>
	<button class="btn btn-primary" role="button" onclick="servertimeerror2()">서버시간 에러 데이터 넣기2</button>
</body>
<script>
	function servertimeinsert(){
		$.ajax({
			url : "servertimeinsert",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
		}
	
	function deviceinsert(){
		$.ajax({
			url : "deviceinsert",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
		}
	
	function servertimeerror() {
		$.ajax({
			url : "errorinsert",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
	}
	
	function servertimeerror2() {
		$.ajax({
			url : "errorinsert2",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
	}
</script>
</html>