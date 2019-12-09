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
<meta charset="utf-8"/>
<style>
.container-fluid {
	color: gray;
}
</style>
<script type="text/javascript">
$(document).ready(function() {	
(function poll(){
	$.ajax({
		url : "errnowjsn",
		type : "GET",
		success: function(results){
			if(results.length != 0){
				alert("에러가 발생했습니다. 실시간 에러 확인 페이지로 이동합니다.");
				window.location.href="?contentPage=errnow.jsp";
			}
		},
		error : function() {
			alert("err");
		},
		complete: poll,
		timeout: 600000
	});
})();
});
</script>
<script>
var dname = new Array();
var month = new Array();
var dtset=new Array();
var lbl = new Array();
var dtsize=new Array();
var dtsetArr=new Array();
///////
var dnamem = new Array();
var lblm = new Array();
var dtsetm = new Array();
var lblm = new Array();
var dtsetArrm = new Array();
var lineChartData; var lineChartData2;

var colors = new Array();

colors = ["rgba(166, 3, 33, 0.8)","rgba(115, 2, 32, 0.8)","rgba(63, 137, 166, 0.8)","rgba(89, 75, 2, 0.8)","rgba(191, 180, 147, 0.8)",
	"rgba(140, 58, 88, 0.8)","rgba(7, 14, 38, 0.8)","rgba(13, 24, 38, 0.8)","rgba(191, 176, 170, 0.8)","rgba(140, 66, 66, 0.8)"];
$(document).ready(function() {	
	yearlist();	
	drawYearChart();
	drawMonthChart();
});
</script>
</head>
<body>
<div class="container-fluid">	
	<div class="row">
		<div class="col" style="width:50%;">
			<canvas id="myChart" width="400px" height="300px"></canvas>
			<select id="selectyear" onchange="yearChange(this.value);"></select>
			<p class="font-weight-light font-italic">연도를 선택하면 해당 연도 내 에러 발생 건수를 확인하실 수 있습니다.</p>			
		</div>
		<div class="col" style="width:50%;">
			<canvas id="myChartm" width="400px" height="300px"></canvas>
			<select id="selectmonth" onchange="monthChange(this.value);">
				<option value=''>월 선택</option>
				<option value="01">1</option><option value="02">2</option><option value="03">3</option>
				<option value="04">4</option><option value="05">5</option><option value="06">6</option>
				<option value="07">7</option><option value="08">8</option><option value="09">9</option>
				<option value="10">10</option><option value="11">11</option><option value="12">12</option>
			</select>
			<p class="font-weight-light font-italic">월을 선택하면 연도 별 해당 월 에러 발생 건수를 비교하실 수 있습니다.</p>
			
		</div>
	</div>
</div>

<script>
function yearlist(){
	$.ajax({
		url : "yearListjsn",
		type : "GET",
		error : function() {
			console.log(error);
		}
	}).done(function(results){
		$('#selectyear').find('option').remove();
		$('#selectyear').append("<option value=''>연도 선택</option>");
		for(key in results) {
			$('#selectyear').append("<option value="+results[key].year+">"+results[key].year+"</option>")
		}	
	});	
}

function yearChange(selection){
	var set = new Object();	
	set.year = selection;
	
	$.ajax({
		url : "cntbymonthjsn",
		type : "GET",
		data : set,
		error : function() {
			console.log(error);
		}
	}).done(function(results){
		console.log(results);
		dname=[];dtsize=[];dtsetArr=[];
		for(i in results){		
			dname.push(results[i].device_name);		
			dtset=[];lbl=[];	
			dtsize.push(results[i].errorList.length);		
			for(j in results[i].errorList){							
				dtset.push(results[i].errorList[j].count);	
				lbl.push(results[i].errorList[j].month+"월");		
			}
			dtsetArr.push(dtset);			
		}
///////////////////		
		lineChartData = { labels: lbl, datasets: [] },
		array = dtsetArr;
		label = dname;

		array.forEach(function (a, i) {
		  lineChartData.datasets.push({
		      backgroundColor: colors[i],
		      data: a,
		      label: dname[i]
		  });
		});		
		console.log("lineChartData",lineChartData);
////////////////////		
		updateYear();
	});
}

function monthChange(selection){
	var set = new Object();	
	set.month = selection;

	$.ajax({
		url : "cntbyyearjsn",
		type : "GET",
		data : set,
		error : function() {
			console.log(error);
		}
	}).done(function(results){
		console.log(results);
		dnamem=[]; dtsetArrm=[];
		for(i in results){	
			dnamem.push(results[i].device_name);
			dtsetm=[];lblm=[];
			for(j in results[i].errorList){							
				dtsetm.push(results[i].errorList[j].count);	
				lblm.push(results[i].errorList[j].year+"년");		
			}
			dtsetArrm.push(dtsetm);
			
		}
///////////////////		
		lineChartData2 = { labels: lblm, datasets: [] },
		array = dtsetArrm;
		label = dnamem;

		array.forEach(function (a, i) {
		  lineChartData2.datasets.push({
		      backgroundColor: colors[i],
		      data: a,
		      label: dnamem[i]
		  });
		});		
		console.log("lineChartData2",lineChartData2);
////////////////////
		updateMonth();
	});
}
function updateYear(){	
	//myChart.data.datasets = dtsetFin;
    //myChart.data.labels = lbl;
    myChart.data = lineChartData;
    //myChart.data.datasets.backgroundColor = "rgba(0, 123, 255, 0.6)";
	myChart.update();
};
function updateMonth(){	
	//myChartm.data.datasets = dtsetFinm;
    //myChartm.data.labels = lblm;
    myChartm.data = lineChartData2;
    //myChartm.data.datasets[0].fillColor = 'black';
	myChartm.update();
};

function drawYearChart(){
	//if(window.myChart && window.myChart !== null){
    //    window.myChart.destroy();
    //}    
	var ctx = document.getElementById('myChart').getContext('2d');
	
	window.myChart = new Chart(ctx, {
	    type: 'bar',
	    data: lineChartData,
	    options: {
		    title: {
			    display: true,
			    text: '연도 별 추이',
			    fontSize:25
			    },
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true
	                }
	            }]
	        }
	    }
	});
}

function drawMonthChart(){
	//if(window.myChart && window.myChart !== null){
    //    window.myChart.destroy();
    //}    
	var ctx = document.getElementById('myChartm').getContext('2d');
	
	window.myChartm = new Chart(ctx, {
	    type: 'bar',
	    data: lineChartData2,
	    options: {
	    	title: {
			    display: true,
			    text: '월 별 비교',
			    fontSize:25
			    },
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true
	                }
	            }]
	        }
	    }
	});
}
</script>
</body>
</html>