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
<script>
var obj = new Object();	
var lbl; var cnt;
var lblarr; var cntarr;
var server_time; var to_date;
let tempData;
let chartOptions;

$(document).ready(function() {	
	updateDev();
	dateSelect();
	getChart();	
	getChart2();
});
function dateSelect(){
	server_time = $("#server_time").val();
	to_date = $("#to_date").val();
	if (server_time){ obj.server_time = server_time;}
	if (to_date){ obj.to_date = to_date;}
	console.log("obj",obj);
}
function newDateSelect(){
	dateSelect();
	getChart();
}

function getChart(){	
	console.log("obj",obj);	
	//-을 구분자로 연,월,일로 잘라내어 배열로 반환
    var startArray = server_time.split('-');
    var endArray = to_date.split('-');   

    console.log("startArray",startArray);
    console.log("endArray",endArray); 
    //배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
    var end_date = new Date(endArray[0], endArray[1], endArray[2]);
         //날짜를 숫자형태의 날짜 정보로 변환하여 비교한다.
    if(start_date.getTime() > end_date.getTime()) {
        alert("종료 일자보다 시작 일자가 앞서야 합니다.");
        return false;
    }
	$.ajax({
		url : "errcntjsn", //날짜조건에 맞는 
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("results",results);
		lbl = ""; cnt = "";
		for(key in results){
			lbl += results[key].err_type;
			lbl += ",";
			cnt += results[key].count;
			cnt += ",";
		}
		lbl = lbl.substr(0, lbl.length - 1);
		lblarr = lbl.split(",");
		cnt = cnt.substr(0, cnt.length - 1);
		cntarr = cnt.split(",");
		console.log("lblarr",lblarr);
		console.log("cntarr",cntarr);


		chartOptions = {
			    title:{
			        display:true,
			        text:'기간 내 에러 건수(에러 타입 별)',
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
			    cutoutPercentage: 40,
			    rotation: 1 * Math.PI,
	            circumference: 1 * Math.PI
			}
		
		if(window.testChart && window.testChart !== null){
	        window.testChart.destroy();
	    } 
			
		let myChart = document.getElementById('myChart').getContext('2d');

		//Global Options
		Chart.defaults.global.defaultFontSize=15;
		Chart.defaults.global.defaultFontColor='Gray';

		window.testChart = new Chart(myChart, {
		    type: 'doughnut',
		    data: {
		        labels: lblarr,
		        datasets:[{
		            data: cntarr,
		            backgroundColor: ["rgba(166, 3, 33, 0.8)","rgba(115, 2, 32, 0.8)","rgba(63, 137, 166, 0.8)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: chartOptions
		});	
		testChart.data.datasets[0].data = cntarr;	
		testChart.labels = lblarr;
		testChart.update();
	});
};
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
///////////////////////////
var set = new Object();	

function yearSelect2(){
	var device_id = $("#deviceinfo").val();
	server_time = $("#server_time2").val();
	to_date = $("#to_date2").val();
	set.device_id = device_id;
	if (server_time){ set.server_time = server_time;}
	if (to_date){ set.to_date = to_date;}
	console.log("set",set);
}
function newYearSelect2(){
	yearSelect2();
	getChart2();
}


function getChart2(){
	console.log("set",set);	
	//-을 구분자로 연,월,일로 잘라내어 배열로 반환
    var startArray = server_time.split('-');
    var endArray = to_date.split('-');  
    console.log("startArray",startArray);
    console.log("endArray",endArray); 
    //배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
    var end_date = new Date(endArray[0], endArray[1], endArray[2]);
    console.log("start_date",start_date); 
    console.log("end_date",end_date); 
         //날짜를 숫자형태의 날짜 정보로 변환하여 비교한다.
    if(start_date.getTime() > end_date.getTime()) {
        alert("종료 일자보다 시작 일자가 앞서야 합니다.");
        return false;
    }
	$.ajax({
		url : "errcntbyidjsn",
		type : "GET",
		data : set,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log(results);

		lbl2 = ""; cnt2 = ""; dname = "";
		
		if(results.length == 0){
			lbl2 = "TLS(SSL) 오류,X509(인증서) 오류,데이터 오류,";
			cnt2 = "0,0,0,";
			dname = "기간 내 ";
			dname += $('#deviceinfo option:checked').text();
			dname += "의 에러 건수(에러 타입 별)";
		}		
		else{
			dname = "기간 내 ";
			dname += results[0].device_name;
			dname += "의 에러 건수";
			for(key in results[0].errorList){
				lbl2 += results[0].errorList[key].err_type;
				lbl2 += ",";
				cnt2 += results[0].errorList[key].count;
				cnt2 += ",";
			}		
		}
		
		lbl2 = lbl2.substr(0, lbl2.length - 1);
		lblarr2 = lbl2.split(",");

		//아예 오류가 없었던 기기인지 체크
		if(cnt2.length != 0){
			cnt2 = cnt2.substr(0, cnt2.length - 1);
			cntarr2 = cnt2.split(",");
			}
		else {
			cntarr2 = "";
			}	
		
		console.log("lblarr2",lblarr2);
		console.log("cntarr2",cntarr2);
		console.log("dname",dname);		

		deviceData = {
		        labels: lblarr2,
		        datasets:[{
		            data: cntarr2,
		            backgroundColor: ["rgba(166, 3, 33, 0.8)","rgba(115, 2, 32, 0.8)","rgba(63, 137, 166, 0.8)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    }
		deviceChartOptions = {
		    title:{
		        display:true,
		        text: dname,
		        fontSize:25
		    },
		    legend:{
		        position:'right',
		        labels:{
		            fontColor:'grey'
		        }
		    },
		    tooltips:{
		    	mode: 'index',
				intersect: false
		    },
		    cutoutPercentage: 40
		}
		if(window.deviceChart && window.deviceChart !== null){
	        window.deviceChart.destroy();
	    } 

		let tempChart = document.getElementById('tempChart').getContext('2d');
		window.deviceChart = new Chart(tempChart, {		
			type: 'polarArea',
			data: deviceData,
			options: deviceChartOptions
		});
	});
   
	deviceData.datasets[0].data = cntarr2;
    deviceData.labels = lblarr2;
    deviceChart.update();
};

</script>
<div class="container-fluid">
	<div class="row">
		<div class="col" style="width:50%;">
			<canvas id="myChart" style="max-width:900px; min-width:300px;"></canvas>
		</div>
		<div class="col" style="width:50%;">
			<canvas id="tempChart" style="max-width:900px; min-width:300px;"></canvas>
		</div>
	</div>
	<div class="row" style="padding-top:20px;">
		<div class="col" style="width:50%;">
			시작 일자:<input type="date" id="server_time">
			종료 일자:<input type="date" id="to_date">
			<button type="submit" id="submit" class="btn btn-dark" onclick='newDateSelect()'>조회</button>
			<p class="font-weight-light font-italic">조건 조회 시 기간 내 누적 에러 건수를 확인하실 수 있습니다.<br>날짜를 선택하지 않을 시 전체 기간으로 조회됩니다.</p>
			
		</div>
		<div class="col" style="width:50%;">
			<select id="deviceinfo" name="deviceinfo"></select>
			시작 일자:<input type="date" id="server_time2">
			종료 일자:<input type="date" id="to_date2">
			<button type="submit" id="submit" class="btn btn-dark" onclick='newYearSelect2()'>조회</button>		
			<p class="font-weight-light font-italic">조건 조회 시 기간 내 해당 기기의 누적 에러 건수를 확인하실 수 있습니다.<br>날짜를 선택하지 않을 시 전체 기간으로 조회됩니다.</p>
		</div>
	</div>
</div>
</body>
</html>