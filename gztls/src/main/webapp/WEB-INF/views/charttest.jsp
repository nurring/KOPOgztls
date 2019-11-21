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
<canvas id="myChart" height="200"></canvas>
<script type="text/javascript">
var ctx = document.getElementById("myChart");

var randomColorPlugin = {

    // We affect the `beforeUpdate` event
    beforeUpdate: function(chart) {
        var backgroundColor = [];
        var borderColor = [];
        
        // For every data we have ...
        for (var i = 0; i < chart.config.data.datasets[0].data.length; i++) {
        
        	// We generate a random color
        	var color = "rgba(" + Math.floor(Math.random() * 255) + "," + Math.floor(Math.random() * 255) + "," + Math.floor(Math.random() * 255) + ",";
            
            // We push this new color to both background and border color arrays
            backgroundColor.push(color + "0.2)");
            borderColor.push(color + "1)");
        }
        
        // We update the chart bars color properties
        chart.config.data.datasets[0].backgroundColor = backgroundColor;
        chart.config.data.datasets[0].borderColor = borderColor;
    }
};

// We now register the plugin to the chart's plugin service to activate it
Chart.pluginService.register(randomColorPlugin);

var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["January", "February", "March", "April", "May", "June"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            borderWidth: 1
        }]
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
</script>
</body>
</html>