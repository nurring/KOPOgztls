<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/Chart.min.js"></script>
<script src="resources/js/moment.min.js"></script>
<script type='text/javascript' src="resources/js/byperiod.js"></script>
<script src="resources/js/moment-timezone-with-data.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/Chart.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>기간 변화 그래프</title>
<script>
var set = new Object();	
function deviceSelect(device){
	console.log("deviceSect working!");
	set.device_id = device;		
	}
</script>
</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-body">
			</div>
			<div class="card-body">
				<canvas id="myChart"></canvas>
				<select id="device" name="device" onchange="deviceSelect(this.value);">
					
				</select>
			</div>
		</div>
	</div>
</body>
</html>