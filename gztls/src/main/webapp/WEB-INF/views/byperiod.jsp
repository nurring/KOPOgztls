<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>기간 변화 그래프</title>
<script>

</script>
</head>
<body>
	<div class="container">
	
		<div>
			<canvas id="myChart"></canvas>
			<select id="device" name="device" onchange="deviceSelect(this.value);"></select>
		</div>
	<p class="font-weight-light font-italic" >기기를 선택하면 최근 24시간 내 데이터 추이를 보여줍니다.</p>
	</div>
<script type="text/javascript">
var set = new Object();	
function deviceSelect(device){
	set.device_id = device;		
	}
var hlabels = "", hdata="";
var tdata="", d1data="", d2data="";	
var hdataArray, hlabelsArray, tdataArray, d1dataArray, d2dataArray;
	
console.log("set",set);	

$(document).ready(function() {		
    updateDevice();    
	window.setInterval(function(){			
		$.ajax({
			url : "byperiodjsn",
			type : "GET",
			data : set,
			error : function() {
				alert("err");
			}			
		}).done(function(results){
		hlabels = "", hdata="";
		tdata="", d1data="", d2data="";
					    
			for(key in results) {
				if (results[key].data_type == "H"){
					hdata += results[key].data_content;
					hdata += ",";
					hlabels += moment(results[key].server_time).tz("Europe/London").format('YYMMDD HH:mm:ss');
					hlabels +=","}
				if (results[key].data_type == "T"){
					tdata += results[key].data_content;
					tdata += ",";
					}
				if (results[key].data_type == "D1"){
					d1data += results[key].data_content;
					d1data += ",";
					}
				if (results[key].data_type == "D2"){
					d2data += results[key].data_content;
					d2data += ",";
					}
			}							
			hlabels = hlabels.substr(0, hlabels.length - 1);
			hlabelsArray = hlabels.split(",");
			
			hdata = hdata.substr(0, hdata.length - 1);
			tdata = tdata.substr(0, tdata.length - 1);
			d1data = d1data.substr(0, d1data.length - 1);
			d2data = d2data.substr(0, d2data.length - 1);	
			
			hdataArray = hdata.split(",");
			tdataArray = tdata.split(",");
			d1dataArray = d1data.split(",");
			d2dataArray = d2data.split(",");
		});
//		console.log("hlabelsArray", hlabelsArray);
//		console.log("hdataArray", hdataArray);
//    	console.log("tdataArray", tdataArray);
//    	console.log("d1dataArray", d1dataArray);
//   	console.log("d2dataArray", d2dataArray);
		if(window.testchart && window.testchart !== null){
	        window.testchart.destroy();
	    }
    	updateChart();
	}, 2000); //1초마다

function updateDevice(){
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			console.log(error);
		}			
	}).done(function(results){
//		console.log("results",results);
		$('#device').find('option').remove();
		$('#device').append("<option value=''>기기 선택</option>");
		for(key in results) {
			$('#device').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
		}	
	});
};

function updateChart(){
    tempData.datasets[0].data = hdataArray;
    tempData.datasets[1].data = tdataArray;
    tempData.datasets[2].data = d1dataArray;
    tempData.datasets[3].data = d2dataArray;
    tempData.labels = hlabelsArray;
    testChart.update();
};

let tempData = {
        labels: hlabelsArray,
        datasets:[{
            label: 'H:습도',
            data: hdataArray,
            borderColor: "rgba(0, 123, 255, 0.6)",
            backgroundColor: "rgba(0, 123, 255, 0.6)",
            hoverBorderWidth:4,
            fill: false
        },{
            label: 'T:온도',
            data: tdataArray,
            borderColor:"rgba(220, 53, 69, 0.6)",
            backgroundColor:"rgba(220, 53, 69, 0.6)",
            hoverBorderWidth:4,
            fill: false
        },{
            label: 'D1:미세먼지',
            data: d1dataArray,
            borderColor:"rgba(255, 193, 7, 0.6)",
            backgroundColor:"rgba(255, 193, 7, 0.6)", 
            hoverBorderWidth:4,
            fill: false
        },{
            label: 'D2:초미세먼지',
            data: d2dataArray,
            borderColor:"rgba(23, 162, 184, 0.6)",
            backgroundColor:"rgba(23, 162, 184, 0.6)", 
            hoverBorderWidth:4,
            fill: false
        }]
    }
let chartOptions = {
    title:{
        display:true,
        text:'24h data',
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
    	mode: 'index',
		intersect: false
    }
}
let myChart = document.getElementById('myChart').getContext('2d');

//Global Options
//Chart.defaults.global.defaultFontFamily='Lato';
Chart.defaults.global.defaultFontSize=15;
Chart.defaults.global.defaultFontColor='Gray';


window.testChart = new Chart(myChart, {
    type: 'line',//bar horizontalBar, pie line doughnut radar polarArea
    data: tempData,
    options: chartOptions
});

});
</script>
</body>
</html>