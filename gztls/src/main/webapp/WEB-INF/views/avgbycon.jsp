<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/Chart.min.js"></script>
<script src="resources/js/moment.min.js"></script>
<script src="resources/js/moment-timezone-with-data.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/Chart.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>조건검색</title>
<script type="text/javascript">
	var dlabels = "";
	var hdt="", tdt="", d1dt="", d2dt="";	
	var dlabelsArray;
	var hdtArray, hlabelsArray, tdtArray, d1dtArray, d2dtArray;	
	let avgData;
	let avgChart;
	
	function checking() {
		var device_id = $("#device_id").val();
		var server_time = $("#server_time").val();
		var to_date = $("#to_date").val();
		var data_type = $("#data_type").val();	
		var obj = new Object();	
		if (device_id){	obj.device_id = device_id;}
		if (server_time){ obj.server_time = server_time;}
		if (to_date){ obj.to_date = to_date;}
		if (data_type){	obj.data_type = data_type;}
		console.log("obj",obj);	
		
		$.ajax({
			url : "avgbyconjsn",
			type : "GET",
			data : obj,		
			error : function() {
				alert("err");
			}
		}).done(function(results){		
			console.log("results", results);
			dlabels = "";
			hdt="", tdt="", d1dt="", d2dt="";	
			for(i in results) {
				console.log('i:' + i + ' / ' + 'value:' + results[i].successList[0].average);
				dlabels += results[i].device_name;
				dlabels += ",";
				for(j in results[i].successList){
					if(results[i].successList[j].data_type == "H"){
						hdt += results[i].successList[j].average;
						hdt += ",";
					}
					if(results[i].successList[j].data_type == "T"){
						tdt += results[i].successList[j].average;
						tdt += ",";
					}
					if(results[i].successList[j].data_type == "D1"){
						d1dt += results[i].successList[j].average;
						d1dt += ",";
					}
					if(results[i].successList[j].data_type == "D2"){
						d2dt += results[i].successList[j].average;
						d2dt += ",";
					}
				}
			}			
			dlabels = dlabels.substr(0, dlabels.length - 1);
			dlabelsArray = dlabels.split(",");

			hdt = hdt.substr(0, hdt.length - 1);
			tdt = tdt.substr(0, tdt.length - 1);
			d1dt = d1dt.substr(0, d1dt.length - 1);
			d2dt = d2dt.substr(0, d2dt.length - 1);
			hdtArray = hdt.split(",");
			tdtArray = tdt.split(",");
			d1dtArray = d1dt.split(",");
			d2dtArray = d2dt.split(",");
			console.log("hdtArray", hdtArray);
	    	console.log("tdtArray", tdtArray);
	    	console.log("d1dtArray", d1dtArray);
	    	console.log("d2dtArray", d2dtArray);
			
			updateChart();
		});
	};	
	
	function updateChart(){
		avgData.datasets[0].data = hdtArray;
        avgData.datasets[1].data = tdtArray;
        avgData.datasets[2].data = d1dtArray;
        avgData.datasets[3].data = d2dtArray;		
		avgData.labels = dlabelsArray;
	    avgChart.update();
	};	
$(document).ready(function() {	
	avgData = {
		    labels: dlabelsArray,
		    datasets: [
		        {
		            label: "H:습도",
		            backgroundColor: "rgba(0, 123, 255, 0.6)",
		            borderColor: "gray",
		            data: hdtArray
		        },
		        {
		            label: "T:온도",
		            backgroundColor: "rgba(220, 53, 69, 0.6)",
		            data: tdtArray
		        },
		        {
		            label: "D1:미세먼지",
		            backgroundColor: "rgba(255, 193, 7, 0.6)",
		            data: d1dtArray
		        },
		        {
		            label: "D2:초미세먼지",
		            backgroundColor: "rgba(23, 162, 184, 0.6)",
		            data: d2dtArray
		        }
		    ]
		};

	let avgOptions = {
		    title:{
		        display:true,
		        text:'average data',
		        fontSize:25
		    },
		    legend:{
		        position:'right',
		        labels:{
		            fontColor:'grey'
		        }
		    },
		    layout:{
		        padding:{
		            left:50
		        }
		    },
		    tooltips:{
		        enabled:true
		    },
		    barValueSpacing: 20,
		    scales: {
		        yAxes: [{
		            ticks: {
		            	beginAtZero:false,
		            }
		        }]
		    }
		}
	
	let myAvgChart = document.getElementById('myAvgCanvas').getContext('2d');
	//Global Options
	Chart.defaults.global.defaultFontSize=15;
	Chart.defaults.global.defaultFontColor='Gray';	

	avgChart = new Chart(myAvgChart, {
	    type: 'bar',
	    data: avgData,
	    options: avgOptions
	});

	checking();
});
</script>
</head>
<body>
<div>
	<div>
		<canvas id="myAvgCanvas"></canvas>
	</div>
	<div>
		<form method="GET" id="conditionform" onsubmit="return false;">
			<input type="text" id="device_id" placeholder="device_id">
			<input type="date" id="server_time" placeholder="fromdate">
			<input type="date" id="to_date" placeholder="todate">
			<input type="text" id="data_type" placeholder="data_type">
			<button type="submit" id="submit" class="btn btn-dark" onclick='checking()'>조회</button>
		</form>
	</div>	
	<p class="font-weight-light font-italic" >조건을 부여하여 기간 내 평균 데이터를 확인하세요.<br>
	첫 화면에는 해당 기기에 데이터가 기록 된 전체 기간의 평균이 제시됩니다.</p>
</div>

</body>
</html>