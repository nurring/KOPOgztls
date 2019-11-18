<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="resources/js/Chart.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/Chart.min.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<canvas id="tempChart"></canvas>
	<select id="deviceinfo" name="deviceinfo" onchange="getChart(this.value);"></select>
</div>
<script>
var obj = new Object();	
var lbl2, cnt2;
var lblarr2, cntarr2;
$(document).ready(function() {
	updateDev();	
	function updateDev(){
		$.ajax({
			url : "dlistjsn",
			type : "GET",
			error : function() {
				console.log(error);
			}			
		}).done(function(results){
			$('#deviceinfo').find('option').remove();
			$('#deviceinfo').append("<option value=''>기기 선택</option>");
			for(key in results) {
				$('#deviceinfo').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
			}	
		});
	};
	
});
function getChart(did){
	obj.device_id = did;
	console.log("did", did);
	console.log("obj", obj);
	$.ajax({
		url : "errcntbyidjsn",
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log(results);
		lbl2 = ""; cnt2 = "";
		for(key in results[0].errorList){
			lbl2 += results[0].errorList[key].err_type;
			lbl2 += ",";
			cnt2 += results[0].errorList[key].count;
			cnt2 += ",";
		}		
		lbl2 = lbl2.substr(0, lbl2.length - 1);
		lblarr2 = lbl2.split(",");
		cnt2 = cnt2.substr(0, cnt2.length - 1);
		cntarr2 = cnt2.split(",");
		console.log("lbl2",lbl2);
		console.log("cnt2",cnt2);
		console.log("lblarr2",lblarr2);
		console.log("cntarr2",cntarr2);

		updateChart();
		
		function updateChart(){
			if (deviceChart!=null){
				deviceChart.destroy();
				}
			deviceData.datasets[0].data = cntarr2;
		    deviceData.labels = lblarr2;
		    testChart.update();
		};
		
		let deviceData = {
		        labels: lblarr2,
		        datasets:[{
		            data: cntarr2,
		            borderColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            backgroundColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    }
			let deviceChartOptions = {
			    title:{
			        display:true,
			        text:'항목 별(대분류 - 에러 타입 별)',
			        fontSize:25
			    },
			    legend:{
			        position:'right',
			        labels:{
			            fontColor:'grey'
			        }
			    },
			    layout:{
			        padding:{left:150}
			    },
			    tooltips:{
			    	mode: 'index',
					intersect: false
			    },
			    cutoutPercentage: 40,
			    rotation: 1 * Math.PI,
		        circumference: 1 * Math.PI
			}

			let tempChart = document.getElementById('tempChart').getContext('2d');
			window.deviceChart = new Chart(tempChart, {		
				type: 'doughnut',
				data: deviceData,
				options: deviceChartOptions
				});
	});
	
}
</script>
</body>
</html>