<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>LmsRight</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
.aChart {
	width: 1000px; 
	height: 500px;
}

.slider {
	width: 100%;
    height: 33rem;
    position: relative;
    margin-top: 1.3%;
    overflow: hidden;
    z-index: 0;
}

.slider input[type="radio"] {
	display: none;
}

.slider .sliderwrap {
	margin: 0 auto;
	overflow: hidden;
	white-space : nowrap;
}

.slider .charts > li {
	display: inline-block;
	margin : 0 auto;
	vertical-align: middle;
	width: 100%;
	transition: all .5s;
}

.slider .charts > li > .aChart {
	display : block;
	position : relative;
}

.slider [id="slide1"]:checked ~ .sliderwrap .charts > li {
	transform: translateX(0%);
}

.slider [id="slide2"]:checked ~ .sliderwrap .charts > li {
	transform: translateX(-100%);
}

.slider [id="slide3"]:checked ~ .sliderwrap .charts > li {
	transform: translateX(-200%);
}
.slider [id="slide4"]:checked ~ .sliderwrap .charts > li {
	transform: translateX(-300%);
}
.slider [id="slide5"]:checked ~ .sliderwrap .charts > li {
	transform: translateX(-400%);
}

.bullets {
	position: absolute;
	left: 41%;
	bottom: 0%;
	z-index: 2;
}

.bullets label {
	display: inline-block;
	border-radius: 50%;
	background-color: lightgray;
	width: 12px;
	height: 12px;
	cursor: pointer;
	margin-left: 10px;
}

#chartHolder {
	height: fit-content;
    margin-bottom: 0;
}
</style>
<script type="text/javascript">

	// 강사목록 페이징 설정
	var pageSizeTeacher = 5;
	var pageBlockSizeTeacher = 5;
	
	// 강의목록 페이징 설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5;
	
	
	/** OnLoad event */ 
	$(function() {
		
		surveyTeacherList();
		
		$("#divLectureList").hide();
		
		$("#bulletsDiv").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchTeacher':
					surveyTeacherList();
					break;
				case 'btnSearchLecture':
					surveyLectureList();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	// 설문조사 강사 목록 조회
	function surveyTeacherList(pageNum) {
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizeTeacher,
				search : $("#search").val()
		}
		
		var teacherListCallBack = function(data) {
			
			$("#surveyTeacherList").empty().append(data);
			
			var totalCnt = $("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizeTeacher, pageBlockSizeTeacher, 'surveyTeacherList');
			
			$("#surveyTeacherListPagination").empty().append(paginationHtml);
			
		}
		
		callAjax("/adm/surveyTeacherList.do", "post", "text", "false", param, teacherListCallBack);
	}
	
	// 강의목록 들어가기전 로그인ID 백업
	function fn_lectureList(loginID){
		
		$("#bloginID").val(loginID);
		
		$("#slider").hide();
		
		surveyLectureList();
		
		console.log(loginID);
		
	}
	
	// 강사별 강의목록 조회
	function surveyLectureList(pageNum){
		
		$("#divLectureList").show();
		
		$("#slider").hide();
		
		pageNum = pageNum || 1;
		
		var param = {
				
				pageNum : pageNum,
				pageSize : pageSizeLecture,
				loginID : $("#bloginID").val(),
				lsearch : $("#lsearch").val()
		}
		
		var lectureListCallBack = function(data){
			
			$("#surveyLectureList").empty().append(data);
			
			var totalCnt = $("#ltotalCnt").val();
			
			var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizeLecture, pageBlockSizeLecture, 'surveyLectureList');
			
			$("#surveyLectureListPagination").empty().append(paginationHtml);
			
		} 
		callAjax("/adm/surveyLectureList.do", "post", "text", "false", param, lectureListCallBack);
	}
	
	// 설문조사 그래프 전 I값 넣어주기
	function fn_Result(lecture_seq){
		for(var i = 1; i <= 5; i++){
			surveyResult(lecture_seq, i);
		}
	}
	
	// 설문조사 페이지
	function surveyResult(lecture_seq,i){
		
		var param = {
				lecture_seq : lecture_seq,
				serveyitem_queno : i
		}
		console.log(param);
		var surveyResultCallBack = function(data){
			console.log(data);
			  /* $("#asd"+i).dxChart({
			        dataSource   : data.surveyResult.answer1,
			        palette      : "Material",
			        title: {
			            text     : " [ "+ i + "번 문항 ]",
			            subtitle : data.surveyResult.serveyitem_question
			        },
			        commonSeriesSettings: { 
			            type             : "bar",
			            valueField       : "ivalue",
			            argumentField    : "svalue",
			            ignoreEmptyPoints: true
			        },
			        seriesTemplate: {
			            nameField : "svalue"
			        }
			    }); */
			drawChart(data.surveyResult, i);
		}
		callAjax("/adm/surveyResult.do", "post", "json", "false", param, surveyResultCallBack);
	}
	
	
	
	google.charts.load('current', {'packages':['bar']});
	google.charts.setOnLoadCallback(drawChart);
	
	 function drawChart(data, i) {
		 
		 $("#slider").show();
		 	
	        var chartasd = google.visualization.arrayToDataTable([
	          ['만족도', '명'],
	          ['매우만족', data.answer1 ],
	          ['만족', data.answer2 ],
	          ['보통', data.answer3 ],
	          ['불만족', data.answer4 ],
	          ['매우불만족', data.answer5 ],
	        ]);

	        var options = {
	          chart: {
	            title: " [ "+ i + "번 문항 ]",
	            subtitle: data.serveyitem_question,
	          }
	        };

	        var chart = new google.charts.Bar(document.getElementById('asd' + i));

	        chart.draw(chartasd, google.charts.Bar.convertOptions(options));
	        
	        $("#bulletsDiv").show();
	   }
	
	
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="bloginID" id="bloginID" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">설문 조사 관리</span> 
								<a href="../adm/survey.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>설문 조사 관리</span> <span class="fr">
								강 사 명 
		     	                <input type="text" style="width: 200px; height: 25px;" id="search" name="search">                    
			                    <a href="" class="btnType blue" id="btnSearchTeacher" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divTeacherList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강사ID</th>
										<th scope="col">강사명</th>
										<th scope="col">강사 전화번호</th>
										<th scope="col">강사 이메일</th>
										<th scope="col">강사가입일</th>
									</tr>
								</thead>
								<tbody id="surveyTeacherList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="surveyTeacherListPagination"> </div>
						
						<br><br><br><br><br><br>
					
					
					<div id="divLectureList">
					
						<p class="conTitle">
							<span>강의목록</span> <span class="fr">
								강 의 명
		     	                <input type="text" style="width: 200px; height: 25px;" id="lsearch" name="lsearch">                    
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의 시작일</th>
										<th scope="col">강의 종료일</th>
										<th scope="col">설문인원/수강인원</th>
									</tr>
								</thead>
								<tbody id="surveyLectureList"></tbody>
							</table>
	
						<div class="paging_area"  id="surveyLectureListPagination"> </div>
					</div>
					<br><br><br>
					
					<div class="slider" id = "slider">
						<input type = "radio" name="slide" id="slide1" checked>
						<input type = "radio" name="slide" id="slide2">
						<input type = "radio" name="slide" id="slide3">
						<input type = "radio" name="slide" id="slide4">
						<input type = "radio" name="slide" id="slide5">
						<div class ="sliderwrap">
							<ul id = "chartHolder" class="charts">
								<li>
									<div id ="asd1" class="aChart"></div>
								</li>
								<li>	
									<div id ="asd2" class="aChart"></div>
								</li>
								<li>
									<div id ="asd3" class="aChart"></div>
								</li>
								<li>
									<div id ="asd4" class="aChart"></div>
								</li>
								<li>
									<div id ="asd5" class="aChart"></div>
								</li>
							</ul>
							<div class="bullets" id = "bulletsDiv">
								<label for ="slide1">&nbsp;</label>
								<label for ="slide2">&nbsp;</label>
								<label for ="slide3">&nbsp;</label>
								<label for ="slide4">&nbsp;</label>
								<label for ="slide5">&nbsp;</label>
							</div>	
						</div>
					</div>
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>