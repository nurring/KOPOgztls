<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<style>
#navi {
  background-color: #eee;
}
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc;
}

.panel {
  padding: 0 18px;
  background-color: #ccc;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}
</style>
<title>Insert title here</title>
</head>
<body>
<div id="navi">
<button class="accordion" onclick="location.href='?contentPage=dashboard.jsp'">대시보드</button>
<button class="accordion">정상 데이터 리포트</button>
	<div class="panel">
		<a href="?contentPage=datanow.jsp">현재 데이터</a><br>
		<a href="?contentPage=byperiod.jsp">24시간 그래프</a><br>
		<a href="?contentPage=avgbycon.jsp">기간 별 평균 통계</a><br>
		<a href="?contentPage=bymap.jsp">디바이스 위치 확인</a>
	 </div>

<button class="accordion">에러 데이터 리포트</button>
	<div class="panel">
		<a href="/gztls/">현재 데이터</a><br>
		<a href="/gztls/">24시간 그래프</a><br>
		<a href="/gztls/">기간 별 평균 통계</a><br>
		<a href="/gztls/">디바이스 위치 확인</a>	
	</div>

<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i+1].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  });
}
</script>
</div>
</body>
</html>