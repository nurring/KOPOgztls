<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출력쓰~</title>
</head>
<body>
	<h1>특정 일자 데이터 출력쓰!</h1>
	${time }
<hr>
${vo.get(0).getServer_time() } <br>
${vo.get(0).getData_type() } <br>
${vo.get(0).getData_content() } <br>
${vo.get(0).getDevice().getDevice_id() } <br>
</body>
</html>