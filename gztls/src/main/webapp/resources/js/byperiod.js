/**
 * 
 */
window.onload = function(){
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
			console.log("hlabelsArray", hlabelsArray);
			console.log("hdataArray", hdataArray);
	    	console.log("tdataArray", tdataArray);
	    	console.log("d1dataArray", d1dataArray);
	    	console.log("d2dataArray", d2dataArray);
	    	updateChart();
		}, 1000); //1초마다
	});
	function updateDevice(){
		$.ajax({
			url : "dlistjsn",
			type : "GET",
			error : function() {
				console.log(error);
			}			
		}).done(function(results){
			console.log("results",results);
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
                borderWidth:2,
                borderColor:'red',
                hoverBorderWidth:3
            },{
                label: 'T:온도',
                data: tdataArray,
                borderWidth:2,
                borderColor:'blue',
                hoverBorderWidth:3
            },{
                label: 'D1:미세먼지',
                data: d1dataArray,
                borderWidth:2,
                borderColor:'green',
                hoverBorderWidth:3
            },{
                label: 'D2:초미세먼지',
                data: d2dataArray,
                borderWidth:2,
                borderColor:'black',
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
    //Chart.defaults.global.defaultFontFamily='Lato';
    Chart.defaults.global.defaultFontSize=15;
    Chart.defaults.global.defaultFontColor='Gray';
    
    
    let testChart = new Chart(myChart, {
        type: 'line',//bar horizontalBar, pie line doughnut radar polarArea
        data: tempData,
        options: chartOptions
    });
}