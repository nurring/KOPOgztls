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
<style>
.container-fluid {
	color: gray;
}
</style>
</head>
<body>
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
		timeout: 100000
	});
})();
});
</script>
<script type="text/javascript">
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
var dtdvname; var xdvname; var tdvname;
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
	obj = {};
	if (device_id){ obj.device_id = device_id;}
	if (server_time){ obj.server_time = server_time;}
	if (to_date){ obj.to_date = to_date;}
	console.log("obj",obj);
	$('#deviceinfo').val('');
}
function dateSelect2(){
	var err_type = $("#errinfo").val();
	var server_time = $("#server_time2").val();
	var to_date = $("#to_date2").val();
	obj = {};
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
				dtdvname = " ";
				dtlbl += results[i].err_code + " " + results[i].err_message + "," ;
				dtdt += results[i].count + "," ;
			} else{
				dtdvname = results[i].device_name+" ";
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
		            backgroundColor: ["rgba(115, 2, 32, 0.6)","rgba(63, 137, 166, 0.6)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text: dtdvname +'에러 타입 분석 - \'데이터 오류\'',
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
				xdvname = " ";
				xlbl += results[i].err_code + " " + results[i].err_message + "," ;
				xdt += results[i].count + "," ;
			} else{
				xdvname = results[i].device_name+" ";
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
		            backgroundColor: "rgba(17, 122, 101, 0.8)",
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text: xdvname +'에러 타입 분석 - \'X509(인증서) 오류\'',
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
				tdvname = " ";
				tlbl += results[i].err_code + " " + results[i].err_message + "," ;
				tdt += results[i].count + "," ;
			} else{
				tdvname = results[i].device_name+" ";
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
		            backgroundColor: ["rgba(166, 3, 33, 0.6)","rgba(115, 2, 32, 0.6)","rgba(63, 137, 166, 0.6)","rgba(89, 75, 2, 0.6)","rgba(191, 180, 147, 0.6)",
		            	"rgba(140, 58, 88, 0.6)","rgba(7, 14, 38, 0.6)","rgba(13, 24, 38, 0.6)","rgba(191, 176, 170, 0.6)","rgba(140, 66, 66, 0.6)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: {
			    title:{
			        display:true,
			        text: tdvname + '에러 타입 분석 - \'TLS(SSL) 오류\'',
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

</script>
<div class="container-fluid">
			<select id="deviceinfo" name="deviceinfo"></select>
			시작일자:<input type="date" id="server_time">
			종료일자:<input type="date" id="to_date">
			<button type="submit" id="submit" class="btn btn-dark" onclick='periodSelect()'>조회</button>
			<p class="font-weight-light font-italic">기기와 기간을 선택하여 조회 시 에러 타입별 누적 횟수를 확인할 수 있습니다.<br>
													첫 화면에는 데이터가 기록 된 전체 기간, 전체 기기의 누적 횟수가 제시됩니다.</p>
	<div class="row">
		<div class="col" style="width:50%;">

			<canvas id="dataerrChart" height="200"></canvas>
		</div>
		<div class="col" style="width:50%;">
			<canvas id="tlserrChart" height="200"></canvas>
		</div>
	</div>
	
	<div class="container" style="width:70%; padding-top:60px;">
		<canvas id="x509errChart" height="200"></canvas>	
	</div>	
</div>

</body>
</html>