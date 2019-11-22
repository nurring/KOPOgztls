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
var dname = new Array();
var month = new Array();
var dtset=new Array();
var lbl = new Array();
var dtsize=new Array();
var dtsetArr=new Array(); var dtsetArr2 = new Object(); var dtsetFin=new Array();
///////
var dnamem = new Array();
var lblm = new Array();
var dtsetm = new Array();
var lblm = new Array();
var dtsetArrm = new Array(); var dtsetArrm2 = new Array(); var dtsetFinm = new Array();


var colors = new Array();

colors = ["rgba(0, 123, 255, 0.6)","rgba(220, 53, 69, 0.6)","rgba(255, 193, 7, 0.6)",'rgba(23, 162, 184, 0.6)','blue','pink','purble','gray','black','red','orange','yellow'];
$(document).ready(function() {	
	yearlist();	
	drawYearChart(lbl,dtset);
	drawMonthChart(lblm,dtsetm);
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
			<p class="font-weight-light font-italic">월를 선택하면 연도 별 해당 월 에러 발생 건수를 비교하실 수 있습니다.</p>
			
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
		console.log("lbl",lbl);//라벨
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
		}
		console.log("dtsetFin",dtsetFin);//데이터셋		
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
		console.log("lblm",lblm);//라벨
		console.log("dtsetArrm",dtsetArrm);
		console.log("dnamem",dnamem);

		dtsetFinm=[];
		for (i=0; i<dnamem.length; i++){
			dtsetArrm2=[];
			dtsetArrm2.label=dnamem[i];
			dtsetArrm2.data=dtsetArrm[i];
			dtsetArrm2.backgroundColor=colors[i];
			console.log("dtsetArrm2",dtsetArrm2);		
			dtsetFinm.push(dtsetArrm2);
		}
		console.log("dtsetFinm",dtsetFinm);//데이터셋
		updateMonth();
	});
}
function updateYear(){	
	myChart.data.datasets = dtsetFin;
    myChart.data.labels = lbl;
    //myChart.data.datasets.backgroundColor = "rgba(0, 123, 255, 0.6)";
	myChart.update();
};
function updateMonth(){	
	myChartm.data.datasets = dtsetFinm;
    myChartm.data.labels = lblm;
    //myChartm.data.datasets[0].fillColor = 'black';
	myChartm.update();
};

function drawYearChart(lbl,dtset){
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

function drawMonthChart(lbl,dtset){
	//if(window.myChart && window.myChart !== null){
    //    window.myChart.destroy();
    //}    
	var ctx = document.getElementById('myChartm').getContext('2d');
	
	window.myChartm = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: lbl,
	        datasets: dtsetFin
	    },
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