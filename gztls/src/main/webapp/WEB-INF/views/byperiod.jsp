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
	var set = new Object();	
	
	function deviceSelect(device){
		set.device_id = device;		
		}	
	console.log("set",set);
	var hlabels = "", hdata="";
	var tlabels = [], tdata="";	
	var hdataArray; var hlabelsArray; var tdataArray;
	$(document).ready(function() {
		window.setInterval(function(){		
			$.ajax({
				url : "byperiodjsn",
				type : "GET",
				data : set,
				error : function() {
				}			
			}).done(function(results){
			hlabels = "", hdata="";
			tlabels = [], tdata="";			    
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
				}
				hdata = hdata.substr(0, hdata.length - 1);				
				hlabels = hlabels.substr(0, hlabels.length - 1);
				tdata = tdata.substr(0, tdata.length - 1);
				hdataArray = hdata.split(",");
				hlabelsArray = hlabels.split(",");
				tdataArray = tdata.split(",");
			});
			console.log("hlabels", hlabelsArray);
			console.log("hdata", hdataArray);
	    	console.log("tdata", tdataArray);
	    	updateChart();
		}, 1000); //1초마다
	});
    function updateChart(){
        tempData.datasets[0].data = hdataArray;
        tempData.datasets[1].data = tdataArray;
        tempData.labels = hlabelsArray;
        testChart.update();
    };
</script>
</head>

<body>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h1>
					24시간 데이터 
				</h1>
			</div>
			<div class="card-body">
				<canvas id="myChart"></canvas>
				<select id="device" name="device" onchange="deviceSelect(this.value);">
			    	<option value="">기기 선택</option>  
				<c:forEach items="${devices }" var="e">					                                                   
				    <option value="${e.device_id }">${e.device_name }</option>
				</c:forEach>
				</select>
			</div>
		</div>
	</div>

	<script>
    let tempData = {
            labels: hlabelsArray,
            datasets:[{
                label: 'H:습도',
                data: hdataArray,
                borderWidth:2,
                borderColor:'blue',
                hoverBorderWidth:3
            },{
                label: 'T:온도',
                data: tdataArray,
                borderWidth:2,
                borderColor:'pink',
                hoverBorderWidth:3
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
            enabled:true
        }
    }
    let myChart = document.getElementById('myChart').getContext('2d');
    
    //Global Options
    Chart.defaults.global.defaultFontFamily='Lato';
    Chart.defaults.global.defaultFontSize=15;
    Chart.defaults.global.defaultFontColor='Gray';
    
    
    let testChart = new Chart(myChart, {
        type: 'line',//bar horizontalBar, pie line doughnut radar polarArea
        data: tempData,
        options: chartOptions
    });


</script>    

</body>
</html>