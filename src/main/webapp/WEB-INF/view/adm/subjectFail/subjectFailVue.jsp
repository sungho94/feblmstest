<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>LmsRight :: 과락비율</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- billboard.js import -->
<link rel="stylesheet" href="https://naver.github.io/billboard.js/release/latest/dist/theme/datalab.min.css">
<script src="https://naver.github.io/billboard.js/release/latest/dist/billboard.pkgd.min.js"></script>

<style type="text/css">
/* 타이핑 효과 */
.wrapper {
	height: 2.3rem;
	display: grid;
	place-items: flex-start;
	background-color: rgb(224 224 224/ 40%);
	border-radius: 24px;
	margin: 1% 1% 1% 1%;
}

.typing {
	width: 26.5rem;
 	animation: typing 4s steps(50), blink 0.5s step-end infinite alternate;
	white-space: nowrap;
	overflow: hidden;
	border-right: 3px solid;
	margin-top: 9px;
	margin-left: 2%;
	font-family: monospace;
	font-size: 1.5em;
}

@keyframes typing {
	from { 
		width : 0;
	}
}

/* 테이블 바디영역 tr에 마우스를 올렸을때 td 폰트 속성 변경 */
tbody tr:hover td{
	background-color : lightskyblue;
	color : white;
	font-size: 1rem;
	font-weight : bold;
    cursor: auto;
}

/* 그래프 속성 변경 */
.bb-legend-item text{
	font-size: 0.9rem;
    font-weight: bold;
    }
</style>

<script type="text/javascript">

	var searcharea;
	var failureTable;
	var subjectFailChart;
	
	/** OnLoad event */ 
	$(function() {
		
		/* Vue 등록 */
		init();
		
		/* 초기화면 목록 */
		searchsubjectFailList();
		
	});
	
	/* new Vue 모음 */
	function init(){
		
		/* 강의명으로 검색 */
		searcharea = new Vue({
			
								el : "#searcharea",
								data : {
									
									lectureName : "",
								    lectureStart : "",
								    lectureEnd : ""
								}
			
		});
		
		
		/* 강의 목록 */
		failureTable = new Vue({
			
								el : "#failureTable",
								data : {
									
									listitem : [],
									totalcnt : 0,
									currentpage : 0,
									pagesize : 5,
									blocksize : 10,
									pagenavi : ""
									
								},
								
								methods : {
									
									detailRatio : function(lectureSeq){
										
										console.log(lectureSeq);
										
										detailRatio(lectureSeq);
										
									}
									
								}
			
		});
		
		subjectFailChart = new Vue({
			
									el : "#subjectFailChart",
									data : {
										
										hidden : false
										
									}
			
		});
	};
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				//등록 버튼
				case 'btnSaveempstudent':
					fn_saveempstudent();
					break;
				//검색 버튼
				case 'btnempstuSearch':
					employclasssearchlist();
					break;
				//삭제버튼
				case 'btnDeleteempstudent':
					stuModify.action ="D";
					fn_saveempstudent();
					break;
				//닫기 버튼
				case 'btnCloseGrpCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	/* 강의 목록 */
	function searchsubjectFailList(pagenum){
		
		if(searcharea.lectureStart > searcharea.lectureEnd){
			
			return swal("올바른 종강일을 선택해주세요.");
			
		}
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				listCount : failureTable.pagesize,
				lectureName : searcharea.lectureName,
				lectureStart : searcharea.lectureStart,
				lectureEnd : searcharea.lectureEnd
				
		}
		
		
		console.log(param);
		
		var resultCallBack = function(data) {
			
			/* 현재 페이지 값 */
			failureTable.currentpage = pagenum;
			
			console.log(JSON.stringify(data));
			
			/* 목록, 전체 페이지 수 */
			failureTable.listitem = data.subjectFailList;
			failureTable.totalcnt = data.totalcnt;
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, failureTable.totalcnt, failureTable.pagesize, failureTable.blocksize, 'searchsubjectFailList');
			
			/* 페이지 네비 */
			failureTable.pagenavi = paginationHtml;
		};
		
		callAjax("/adm/vuesubjectFailList.do", "post", "json", "false", param, resultCallBack);
		
	};
	
	/* 특정 과목별 그래프 보기 */
	function detailRatio(lectureSeq) {
		
		var param = {
				
				lectureSeq : lectureSeq,
				
		};
		
		var resultCallBack = function(data) {
			
			console.log(data.ratioInfo);
			
			makesubjectFailChart(data.ratioInfo);
			
		};
		
		callAjax("/adm/subjectFailRatio.do", "post" , "json", "false", param, resultCallBack);
	}
	
	/* 차트 그리기 */
	function makesubjectFailChart(data) {
		
		if(data.total == 0){
			
			subjectFailChart.hidden = false;
			
			return swal("조회된 데이터가 없습니다.");
			
		} else {
			
			subjectFailChart.hidden = true;
			
		}
		
		var chart = bb.generate({
			  data: {
			    columns: [
				["통과", data.pass],
				["과락", data.fail]
			    ],
			    type: "donut",
			  },
			  donut: {
			    title: "과락비율"
			  },
			  bindto: "#subjectFailChart"
			});
	} 

	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				</li>
				<li class="contents">
					<div class="content" style="height: 47.3rem;">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">통계</span> 
							<span class="btn_nav bold">과락 비율</span> 
						</p>


						<!-- 제목 + 서치바 -->
						<p class="conTitle" id="searcharea">
							<span>과락 비율</span>
							<span class="fr">
								<span>강 의 명&nbsp;&nbsp;&nbsp;</span>
								<input type = "text" id = "lectureName" class = "searchKeyWord" v-model="lectureName"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span>개 강 일&nbsp;&nbsp;&nbsp;</span>
								<input type = "date" id = "lectureStart" style="width: 125px; height: 24px;" v-model="lectureStart" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span>종 강 일&nbsp;&nbsp;&nbsp;</span>
								<input type = "date" id = "lectureEnd" style="width: 125px; height: 24px;" v-model="lectureEnd" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:searchsubjectFailList()" class="btnType blue" >
									<span>검 색</span>
								</a> 
							</span>
						</p>
						
						
						<div class="wrapper">
							<div class="typing">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
									<path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
								</svg>
							  	관리자가 강의 종료 처리한 강의만 조회됩니다......
							</div>
						</div>
						
						<!-- 테이블 -->
						<div id = "failureTable">
							<table class = "col">
								<!-- 테이블간 간격 조정 전체 :: 100% -->
								<colgroup>
									<col width="30%">
									<col width="25%">
									<col width="25%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">과정 일수</th>
										<th scope="col">수강 인원</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=5>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for="(item, index) in listitem">
										<tr @click="detailRatio(item.lectureSeq)">
											<td>{{ item.lectureName }}</td>
											<td>{{ item.lectureStart }}</td>
											<td>{{ item.lectureEnd }}</td>
											<td>{{ item.days }} 일</td>
											<td>{{ item.lectureTotal }} 명</td>
										</tr>
									</tbody>
								</template>
								
							</table>
							<div class="paging_area"  id="failurePaging" v-html="pagenavi"></div>
						</div>
						
						<!-- 차트 영역 -->
						<div style="margin-top: 3.1rem; width: 100%; display: flex; justify-content: center;">
							<span id = "subjectFailChart" style="width: 10rem;" v-show="hidden"></span>
						</div>
					</div> 
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>