/**
 * 
 */
window.onload = function(){
	function checking(){
		var obj = new Object();
		var con = $("#con").val();
		var keyword = $("#keyword").val();
		var add = "";
		if (con == "device_name"){
			obj.device_name = keyword;
			}
		if (con == "device_address"){
			obj.device_address = keyword;
			}
		console.log(obj);
		$.ajax({
			url : "searchjsn",
			type : "GET",
			data : obj,
			error : function() {
				alert("err");
			}			
		}).done(function(results){
			add += "<table class='table table-striped'>";
			for(i in results){			
				add += "<tr><td><a href='javascript:void(0)' onclick='initMapEach("
						+results[i].device_latitude+","+results[i].device_longitude
						+"); getdevice(\""+results[i].device_id+"\");'>"
						+results[i].device_name+"</a></td>";
				add += "<td>"+results[i].device_address+"</td>";			
			}
			add += "</table>"
			$('#list').html(add);
		});
	}
}