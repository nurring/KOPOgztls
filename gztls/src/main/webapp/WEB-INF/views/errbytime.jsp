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
<script>
var dname = new Array(); var dnameArr;
var month = new Array(); var monthArr;
var cnt; var cntArr;
var dtset=new Array();
var lbl = new Array();
var dtsize=new Array();
var dtsetArr=new Array();
var dtsetArr2 = new Object();
var dtsetFin=new Array();
var colors = new Array();
colors = ["rgba(0, 123, 255, 0.6)","rgba(220, 53, 69, 0.6)","rgba(255, 193, 7, 0.6)",'rgba(23, 162, 184, 0.6)','blue','pink','purble','gray','black','red','orange','yellow'];
$(document).ready(function() {	
	yearlist();	
	drawChart(lbl,dtset);
});

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
			console.log("lbl",lbl);//라벨
		}
		console.log("dtsize",dtsize);
		console.log("dtsetArr",dtsetArr);
		console.log("dname",dname);
		console.log(Math.max.apply(null, dtsize));
		console.log("colors[0]",colors[0]);
		dtsetFin=[];
		for (i=0; i<dname.length; i++){
			dtsetArr2=[];
			dtsetArr2.label=dname[i];	
			dtsetArr2.data=dtsetArr[i];
			//dtsetArr2.backgroundColor=colors[i];
			console.log("dtsetArr2",dtsetArr2);		
			dtsetFin.push(dtsetArr2);
		}console.log("dtsetFin",dtsetFin);//데이터셋
		
		updateChart();
	});
}
function yearChange(selection){
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
		
	});
}
</script>
</head>
<body>
<div class="container-fluid">	
	<div class="row">
		<div class="col" style="width:50%;">
			<select id="selectyear" onchange="yearChange(this.value);"></select>
			<canvas id="myChart" width="400px" height="300px"></canvas>
		</div>
		<div class="col" style="width:50%;">
			<select id="selectmonth" onchange="monthChange(this.value);">
				<option value=''>월 선택</option>
				<option value="1">1</option><option value="2">2</option><option value="3">3</option>
				<option value="4">4</option><option value="5">5</option><option value="6">6</option>
				<option value="7">7</option><option value="8">8</option><option value="9">9</option>
				<option value="10">10</option><option value="11">11</option><option value="12">12</option>
			</select>
		</div>
	</div>
</div>

<script>
function updateChart(){	
	myChart.data.datasets = dtsetFin;
    myChart.data.labels = lbl;
    //myChart.data.datasets.backgroundColor = "rgba(0, 123, 255, 0.6)";
	myChart.update();
};

function drawChart(lbl,dtset){
	//if(window.myChart && window.myChart !== null){
    //    window.myChart.destroy();
    //}
    
	var ctx = document.getElementById('myChart').getContext('2d');
	
	window.myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: lbl,
	        datasets: dtsetFin
	    },
	    options: {
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