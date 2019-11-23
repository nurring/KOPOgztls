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
<script type="text/javascript">
//errbymsgjsn
var obj = new Object();
var set = new Object();
var dtlbl; var dtlblarr=new Array();
var dtdt; var dtdtarr=new Array();
var xlbl; var xlblarr=new Array();
var xdt; var xdtarr=new Array();
var tlbl; var tlblarr=new Array();
var tdt; var tdtarr=new Array();
var totlbl; var totlblarr = new Array();
var totcnt; var totcntarr = new Array();
var totlbls;
let dataerrChart; let x509errChart; let tlserrChart;
$(document).ready(function() {	
	updateDev();
	periodSelect();
	
});

function periodSelect(){
	dateSelect();
	getDataChart();
	getX509Chart();
	getTlsChart();
}
function errSelect(){
	dateSelect2();
	getTotalStatsChart();
}
function updateDev(){
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			console.log(error);
		}			
	}).done(function(results){
		$('#deviceinfo').find('option').remove();
		$('#deviceinfo').append("<option value=''>선택 기기</option>");
		for(key in results) {
			$('#deviceinfo').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
		}	
	});
};
function dateSelect(){
	var device_id = $("#deviceinfo").val();
	var server_time = $("#server_time").val();
	var to_date = $("#to_date").val();
	if (device_id){ obj.device_id = device_id;}
	if (server_time){ obj.server_time = server_time;}
	if (to_date){ obj.to_date = to_date;}
	console.log("obj",obj);
}
function dateSelect2(){
	var err_type = $("#errinfo").val();
	var server_time = $("#server_time2").val();
	var to_date = $("#to_date2").val();
	if (err_type){ set.err_type = err_type;}
	if (server_time){ set.server_time = server_time;}
	if (to_date){ set.to_date = to_date;}
	console.log("set",set);
}
function getDataChart(){
	var url = "";
	obj.err_type = "데이터 오류";
	console.log("DataErrobj",obj);
	if (obj.device_id){	url = "errbymsgjsn"; }
	else{ url = "errallbymsgjsn"; }
	console.log("url", url);
	$.ajax({
		url : url,
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("dataResults",results);
		dtlbl=""; dtdt="";
		for(i in results){
			if (!results[i].device_id){
				dtlbl += results[i].err_code + " " + results[i].err_message + "," ;
				dtdt += results[i].count + "," ;
			} else{
				for(j in results[i].errorList){
					dtlbl += results[i].errorList[j].err_code + " " + results[i].errorList[j].err_message + "," ;
					dtdt += results[i].errorList[j].count + "," ;
				}
			}
		}
		dtlbl = dtlbl.substr(0, dtlbl.length - 1); dtlblarr = dtlbl.split(",");
		dtdt = dtdt.substr(0, dtdt.length - 1);	dtdtarr = dtdt.split(",");
		console.log("dtlblarr",dtlblarr);
		console.log("dtdtarr", dtdtarr);
		
		if(dataerrChart && dataerrChart !== null){
	        dataerrChart.destroy();
	    }	    
		let dtChart = document.getElementById('dataerrChart').getContext('2d');
	    
		dataerrChart = new Chart(dtChart, {
		    type: 'doughnut',
		    data: {
		        labels: dtlblarr,
		        datasets:[{
		            data: dtdtarr,
		            backgroundColor: ["rgba(169, 50, 38, 0.8)",
		            	"rgba(36, 113, 163, 0.8)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text:'에러 타입 분석 - \'데이터 오류\'',
			        fontSize:25
			    },
			    legend:{
			        position:'right',
			        labels:{
			            fontColor:'grey'
			        }
			    },
			    layout:{
			        padding:{left:30}
			    },
			    tooltips:{
			    	mode: 'index',
					intersect: false
			    },
			    cutoutPercentage: 40
			}
		});

		dataerrChart.data.datasets[0].data = dtdtarr;	
		dataerrChart.labels = dtlblarr;
		dataerrChart.update();
		
	});
}
function getX509Chart(){
	var url = "";
	obj.err_type = "X509(인증서) 오류";
	console.log("X509Errobj",obj);	
	if (obj.device_id){	url = "errbymsgjsn"; }
	else{ url = "errallbymsgjsn"; }
	console.log("url", url);
	$.ajax({
		url : url,
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("x509Results",results);
		xlbl=""; xdt="";
		for(i in results){
			if (!results[i].device_id){
				xlbl += results[i].err_code + " " + results[i].err_message + "," ;
				xdt += results[i].count + "," ;
			} else{
				for(j in results[i].errorList){
					xlbl += results[i].errorList[j].err_code + " " + results[i].errorList[j].err_message + "," ;
					xdt += results[i].errorList[j].count + "," ;
				}
			}
		}
		xlbl = xlbl.substr(0, xlbl.length - 1); xlblarr = xlbl.split(",");
		xdt = xdt.substr(0, xdt.length - 1); xdtarr = xdt.split(",");
		console.log("xlblarr",xlblarr);
		console.log("xdtarr", xdtarr);
		
		if(x509errChart && x509errChart !== null){
			x509errChart.destroy();
	    }	    
		let xChart = document.getElementById('x509errChart').getContext('2d');
	    
		x509errChart = new Chart(xChart, {
		    type: 'horizontalBar',
		    data: {
		        labels: xlblarr,
		        datasets:[{
		            data: xdtarr,
		            backgroundColor: "#117A65",
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text:'에러 타입 분석 - \'X509(인증서) 오류\'',
			        fontSize:25
			    },
			    legend:{
		            display:false
			    },
			    layout:{
			        padding:{left:30}
			    },
			    tooltips:{
			    	mode: 'index',
					intersect: false
			    },
			    cutoutPercentage: 40
			}
		});

		x509errChart.data.datasets[0].data = xdtarr;	
		x509errChart.labels = xlblarr;
		x509errChart.update();
	});
}
function getTlsChart(){
	var url = "";
	obj.err_type = "TLS(SSL) 오류";
	console.log("TlsErrobj",obj);	
	if (obj.device_id){	url = "errbymsgjsn"; }
	else{ url = "errallbymsgjsn"; }
	console.log("url", url);
	$.ajax({
		url : url,
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("tlsResults",results);
		tlbl=""; tdt="";
		for(i in results){
			if (!results[i].device_id){
				tlbl += results[i].err_code + " " + results[i].err_message + "," ;
				tdt += results[i].count + "," ;
			} else{
				for(j in results[i].errorList){
					tlbl += results[i].errorList[j].err_code + " " + results[i].errorList[j].err_message + "," ;
					tdt += results[i].errorList[j].count + "," ;
				}
			}
		}
		tlbl = tlbl.substr(0, tlbl.length - 1); tlblarr = tlbl.split(",");
		tdt = tdt.substr(0, tdt.length - 1); tdtarr = tdt.split(",");
		console.log("tlblarr",tlblarr);
		console.log("tdtarr", tdtarr);

		if(tlserrChart && tlserrChart !== null){
			tlserrChart.destroy();
	    }	    
		let tChart = document.getElementById('tlserrChart').getContext('2d');
	    
		tlserrChart = new Chart(tChart, {
		    type: 'doughnut',
		    data: {
		        labels: tlblarr,
		        datasets:[{
		            data: tdtarr,
		            backgroundColor: ["rgba(166, 3, 33, 0.8)","rgba(115, 2, 32, 0.8)","rgba(63, 137, 166, 0.8)","rgba(89, 75, 2, 0.8)","rgba(191, 180, 147, 0.8)",
		            	"rgba(140, 58, 88, 0.8)","rgba(7, 14, 38, 0.8)","rgba(13, 24, 38, 0.8)","rgba(191, 176, 170, 0.8)","rgba(140, 66, 66, 0.8)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text:'에러 타입 분석 - \'TLS(SSL) 오류\'',
			        fontSize:25
			    },
			    legend:{
			        position:'right',
			        labels:{
			            fontColor:'grey'
			        }
			    },
			    layout:{
			        padding:{left:30}
			    },
			    tooltips:{
			    	mode: 'index',
					intersect: false
			    },
			    cutoutPercentage: 40
			}
		});

		tlserrChart.data.datasets[0].data = tdtarr;	
		tlserrChart.labels = tlblarr;
		tlserrChart.update();
	});
}
function getTotalStatsChart(){
	console.log("set",set);
	$.ajax({
		url : "errbymsgjsn",
		type : "GET",
		data : set,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("getTotalStatsChartresults",results);
		totlbl="";
		for(i in results){
			totlbl += results[i].device_name+",";
			totcnt="";totlbls="";
			for(j in results[i].errorList){
				totcnt += results[i].errorList[j].count+",";
				totlbls += results[i].errorList[j].err_code + " " + results[i].errorList[j].err_message + "," ;
			}
			console.log("totlbls",totlbls);
		}
		totlbl = totlbl.substr(0, totlbl.length - 1); totlblarr = totlbl.split(",");
		totcnt = totcnt.substr(0, totcnt.length - 1); totcntarr = totcnt.split(",");
		console.log("totlblarr",totlblarr);
		console.log("totcntarr",totcntarr);
		
	});
	
}
var lineChartData = { labels:
	 ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
	 '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'], 
	 datasets: [] },
array = ["[0,0,0,0,0,0,0,0,0,0,0,0,0,58,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]", 
   "[0,0,53,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]", 
   "[0,0,381,0,0,649,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]"];

array.forEach(function (a, i) {
   lineChartData.datasets.push({
       label: 'Label ' + i,
       fillColor: 'rgba(220,220,220,0.2)',
       data: JSON.parse(a)
   });
});

console.log("lineChartData",lineChartData);
</script>
<div class="container-fluid">
			<select id="deviceinfo" name="deviceinfo"></select>
			<input type="date" id="server_time">
			<input type="date" id="to_date">
			<button type="submit" id="submit" class="btn btn-dark" onclick='periodSelect()'>조회</button>
	<div class="row">
		<div class="col" style="width:50%;">

			<canvas id="dataerrChart" height="200"></canvas>
		</div>
		<div class="col" style="width:50%;">
			<canvas id="tlserrChart" height="200"></canvas>
		</div>
	</div>
	
	<div class="container" style="width:70%;">
		<canvas id="x509errChart" height="200"></canvas>	
	</div>	
	
	<div>
		<select id="errinfo" name="errinfo">
			<option value='데이터 오류'>데이터 오류</option>
			<option value='X509(인증서) 오류'>X509(인증서) 오류</option>
			<option value='TLS(SSL) 오류'>TLS(SSL) 오류</option>
		</select>
		<input type="date" id="server_time2">
		<input type="date" id="to_date2">
		<button type="submit" id="submit2" class="btn btn-dark" onclick='errSelect()'>조회</button>
		<canvas id="totalerrChart" height="200"></canvas>	
	</div>

</div>

</body>
</html>