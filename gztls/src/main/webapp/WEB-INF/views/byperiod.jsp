<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/Chart.min.js"></script>
<script src="resources/js/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/Chart.min.css">
<head>
<meta charset="UTF-8">
<title>기간 변화 그래프</title>
</head>
<body>
<div style="width:800px">
    <canvas id="myChart"></canvas>
</div>
<script>
var set = new Object();
set.device_id = "00000000522291dbb827eb";
console.log("set",set);
var hlabels = [], hdata=[];
var tlabels = [], tdata=[];	

$(document).ready(function() {
	window.setInterval(function(){		
		$.ajax({
			url : "byperiodjsn",
			type : "GET",
			data : set,
			error : function() {
			}			
		}).done(function(results){
		hlabels = [], hdata=[];
		tlabels = [], tdata=[];			    
			for(key in results) {
				if (results[key].data_type == "H"){
					hdata.push(results[key].data_content);					
					hlabels.push(moment(results[key].server_time).format('YY/MM/DD h:mm:ss a'));}
				if (results[key].data_type == "T"){
					tdata.push(results[key].data_content);
					tlabels.push(moment(results[key].server_time).format('YY/MM/DD h:mm:ss a'));}
			}		
		});
		console.log("hlabels", hlabels);	
    	console.log("hdata", hdata);	
    	console.log("tlabels", tlabels);	
    	console.log("tdata", tdata);
	}, 5000);
});

function hoursEarlier(hours) {
	return moment().subtract(hours, 'h').toDate();};

var tempData = {
	labels: [hoursEarlier(10), hoursEarlier(9.4), 
	    hoursEarlier(8), hoursEarlier(7), hoursEarlier(6),
	    hoursEarlier(5), hoursEarlier(4)],
	    
	datasets: [
	    {
	        label: "H",	       
	        borderColor: "rgba(255,99,132,1)",
	        backgroundColor:'rgba(255, 99, 132, 0.2)',        
	        data: [10, 7],
	        fill: false
	     }
	]};

var chartOptions = {		
maintainAspectRatio: true, // false일 경우 포함된 div의 크기에 맞춰서 그려짐.
scales: {
	xAxes: [{
	      type: "time",
	      time: {
	        unit: 'hour',
	        unitStepSize: 0.5,
	        round: 'hour',
	        tooltipFormat: "h:mm:ss a",
	        displayFormats: {
	          hour: 'MMM D, h:mm A'
	        }
	      }
	    }],
	    yAxes: [{
	      gridLines: {
	        color: "black",
	        borderDash: [2, 5],
	      },
	      scaleLabel: {
	        display: true,
	        labelString: "Speed in Miles per Hour",
	        fontColor: "green"
	      }
	    }]

}
	    
}
	
var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
	type: 'line',
	data: tempData,
	options: chartOptions
	});
</script>

</body>
</html>