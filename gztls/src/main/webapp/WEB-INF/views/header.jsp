<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
<script language="javascript" type="text/javascript">  
function openWin(){  
    window.open("http://35.213.20.175:8080/gztls/insertsuccessdata", "샘플 데이터 넣기", "width=600, height=200, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
}  
</script> 
<div style="background-color: black; padding: 10px;">
<button class="btn btn-primary" onclick='javascript:openWin();'>샘플 데이터 넣기</button>
</div>
</body>
</html>