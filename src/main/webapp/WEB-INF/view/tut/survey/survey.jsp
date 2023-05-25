<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
.single-item p {
	font-size: 2rem;
	font-weight: bold;
	line-height: 100px;
	color: #666;
	margin: 10px;
	text-align: center;
	background-color: #e0e0e0;
	width : 100%;
}

.slick-slide{
	width : 100%;
	height : 500px;
}

</style>


<script type="text/javascript">
	var list;
	$(function() {

		fn_surveyResult();


	});

	google.charts.load('current', {
		packages : [ 'bar' ],
	});
	google.charts.setOnLoadCallback(drawChart);

	function fn_surveyResult() {
		var param = "";

		var resultCallBack = function(data) {
			console.log(data.surveyResult);
			list = data.surveyResult;
			//drawChart(data.surveyResult);
		}
		callAjax("/tut/surveyResult.do", "post", "json", "false", param,
				resultCallBack)
	}

	google.charts.load('current', {
		packages : [ 'bar' ],
	});
	google.charts.setOnLoadCallback(drawChart);

	function fn_surveyResult() {
		var param = "";

		var resultCallBack = function(data) {
			console.log(data.surveyResult);
			list = data.surveyResult;
			//drawChart(data.surveyResult);
		}
		callAjax("/tut/surveyResult.do", "post", "json", "false", param,
				resultCallBack)
	}

	function drawChart() {
		var data = list;
		console.log(data);

		var question = [ '설문조사항목' ];
		var name = [];
		var index = -1;
		var servey = [ [], [ '매우만족' ], [ '만족' ], [ '보통' ], [ '불만족' ],
				[ '매우불만족' ] ];

		// 이름 저장
		for (var i = 0; i < data.length; i++) {
			if (question.indexOf(data[i].serveyitem_question) == -1) {
				question.push(data[i].serveyitem_question);
			}
			if (name.indexOf(data[i].name) == -1) {
				name.push(data[i].name);
			}
		}

		console.log(name);
		console.log(question);
		servey[0] = question;

		for (var i = 0; i < servey[0].length; i++) {
			for (var ii = 0; ii < data.length; ii++) {
				for (var a = 1; a < 6; a++) {
					if (a === data[ii].serveyitem_queno) {
						if (question[i] === data[ii].serveyitem_question) {
							console.log('이름이랑 데이터랑 같아');

							servey[1].push(data[ii].answer1);
							servey[2].push(data[ii].answer2);
							servey[3].push(data[ii].answer3);
							servey[4].push(data[ii].answer4);
							servey[5].push(data[ii].answer5);
						}
					}
				}
				if (servey[1].length === 6) {
					console.log('--------------------------');
					console.log('전  :: ' + servey);

					// 차트그리기
					index++;
					console.log(index);
					console.log(name[index]);
					makeBarChart(servey, name[index], index);

					// 배열 비우기
					arraySplit(servey);
					console.log('==========================');
					console.log('전  :: ' + servey);
				}
			}
		}

		$('.single-item').slick({
			dots : false, // 도트 라디오 버튼
			arrows : false,
			infinite : true, // 무한반복
			autoplay : true, // 자동 넘김 여부
			autoplaySpeed : 3000, // 자동 넘김시 슬라이드 시간
			pauseOnHover : true,// 마우스 hover시 슬라이드 멈춤
			speed : 500, // 넘김 속도
			slidesToShow : 1, // 보이는 슬라이드
			slidesToScroll : 1, // 넘어가는 슬라이드
		});

	}

	// 차트 그리기
	function makeBarChart(servey, name, index) {
		console.log('makeBarChart :: ' + index);
		console.log(servey);

		var chartasd = google.visualization.arrayToDataTable(servey);

		var options = {
			chart : {
				title : ' [ ' + name + ' ] ',
				subtitle : name,
			},
		};

		var index = makeSlideButton(name, index);

		console.log('makeSlideButton index return:: ' + index);

		var chart = new google.charts.Bar(document
				.getElementById('asd' + index));

		chart.draw(chartasd, google.charts.Bar.convertOptions(options));
	}

	// 디브 및 라벨 및 라디오 버튼 만들기
	function makeSlideButton(name, index) {
		console.log('makeSlideButton :: ' + index);
		console.log(name);

		var hDiv = document.getElementById('chartHolder');
		var charLi = document.createElement('li');
		var charDiv = document.createElement('div');

		index += 1;

		if (!!document.getElementById(name) == false) {
			console.log('해당 디브 없어');
			charLi.setAttribute('id', 'asd' + index);
			hDiv.appendChild(charLi);
		}

		return index;
	}

	// 배열 비우기
	function arraySplit(servey) {
		console.log('arraySplit');

		for (var i = 1; i < servey.length; i++) {
			servey[i].length = 1;
		}

		return servey;
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" name="action" id="action" value="">

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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">커뮤니티</span> <span
									class="btn_nav bold">설문 조사 관리</span> <a href="../tut/survey.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>설문 조사 관리</span>
							</p>

							<div id="slider">
								<div class="sliderwrap" id="sliderwrap">
									<div id="chartHolder" class="single-item"></div>
								</div>
							</div>

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>