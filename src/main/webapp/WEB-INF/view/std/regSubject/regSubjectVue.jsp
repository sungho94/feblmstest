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

<script type="text/javascript">
	
	var searcharea;
	var regSubarea;
	var lecturePlan;
	var layer1;
	
	/** OnLoad event */
	$(function() {
		
		init();
		
		//수강목록 가져오기
		regSubjetList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function init(){
		//검색 부분
		searcharea = new Vue({
			el : "#searcharea",
			data : {
				select : "",
				search : "",
			}
		})
		//상단 수강목록부분
		regSubarea = new Vue({
			el : "#sregSubarea",
			data : {
				listitem : [],
				totalcnt : 0,
				pageSize : 5,
				pageBlockSize : 10,
				pagenavi : "",
				goal : "",
				survey : "",
			},
			methods : {
				//상단 수강 목록에서 강의명 눌렀을 때
				fn_lecturePlan : function (logID, lecseq, goal, survey){
					console.log("vue 부분 : "+ logID, lecseq, goal, survey);
					fn_lecturePlan(logID, lecseq, goal, survey); //강사아이디와 lecseq, goal를 가져온다.
				}
			}
		})
		//하단 강의계획 부분
		lecturePlan = new Vue({
			el : "#lecturePlan",
			data : {
				logID : "",
				lecseq : "",
				listitem : [],
				totalCnt : 0,
			}
		})
		//설문조사 모달창
		layer1 = new Vue({
			el : "#layer1",
			data : {
				listitem : [],
 				answer : {}
				
			}
		})
		
	};
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');

				switch (btnId) {
				case 'btnInsert':
					fn_Insert();
					break;
				case 'btnSearch':
					regSubjetList();
					break;
				case 'btnCloseModal' :
					gfCloseModal();
					break;
				}
			});
		}
	
	//상단 강의목록
	function regSubjetList(pageNum){
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : regSubarea.pageSize,
				loginID : '${loginId}', //현재 로그인한 값 넣어준다.
				select : searcharea.select,
				search : searcharea.search,
		}
		
		console.log(param);
		
		var regSubjectListCallBack = function(data) {
			console.log("강의목록 상단 data : " + JSON.stringify(data));
			
			regSubarea.cpage = pageNum;
			regSubarea.listitem = data.regSubjectList;
			regSubarea.totalcnt = data.totalCnt;
			
			var paginationHtml = getPaginationHtml(pageNum, regSubarea.totalcnt, regSubarea.pageSize, regSubarea.pageBlockSize, 'regSubjetList');
			regSubarea.pagenavi = paginationHtml;
			
		}
		callAjax("/std/vueregSubjectList.do", "post", "json", "false", param, regSubjectListCallBack);
	}
	
	//강의명 클릭했을 때 logID와 lecseq 를 백업해준다.
	function fn_lecturePlan(logID, lecseq, goal, survey){
		console.log(logID, lecseq, goal, survey); //강사 ID와 lecseq, goal, survey를 가져옴
		
		lecturePlan.logID = logID;
		lecturePlan.lecseq = lecseq;
		regSubarea.goal = goal;
		regSubarea.survey = survey;
		
		lecturePlanList();
	}
	//하단 강의목표 주차 데이터
	function lecturePlanList(){

		var param = {
			loginID : lecturePlan.logID,
			sloginID : '${loginId}',
			lecture_seq : lecturePlan.lecseq,
		}
		console.log(param); //가져옴
		
		var lecturePlanListCallBack = function(data) {
			console.log(JSON.stringify(data));
			lecturePlan.listitem = data.lecturePlanList;
		}
		callAjax("/std/vuelecturePlanList.do", "post", "json", "false", param, lecturePlanListCallBack);
	}
	
	//설문조사 문항 조회
	function surveyQuestion(){
		console.log("lecseq : "+ lecturePlan.lecseq); //가져옴
		
		var param = {
				lecseq : lecturePlan.lecseq,
		}
		
		console.log(param); //가져오는거 확인
		
		var surveyQuestionCallBack = function(data){
			console.log(JSON.stringify(data));
			
			layer1.listitem = data.surveyQuestionList;
			
			gfModalPop("#layer1");
		}
		callAjax("/std/vuesurveyQuestionList.do", "post", "json", "false", param, surveyQuestionCallBack);
	}
	
	
	// 설문 조사 답변 저장
	function saveSurvey(){
		
		
		console.log("들어왔다02");
	 	
		console.log(layer1.answer);    
		
	 	console.log("surveyForm : " + JSON.stringify($("#surveyForm").serialize()));
	 	
	 	var param = {
	 			bslecture_seq : lecturePlan.lecseq,
	 			use_yn0 : layer1.answer.use_yn0,
	 			use_yn1 : layer1.answer.use_yn1,
	 			use_yn2 : layer1.answer.use_yn2,
	 			use_yn3 : layer1.answer.use_yn3,
	 			use_yn4 : layer1.answer.use_yn4,
	 			loginID : '${loginId}',
	 			
	 	}
	 	console.log(param);
	 	//servey_no
		 var saveSurveyCallBack = function(){
	 		
			gfCloseModal();
			
			location.reload();
			
		}
	 	
		callAjax("/std/saveSurvey.do" ,"post", "json", "false", param, saveSurveyCallBack); 
	}
	
	
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" name="bloginID" id="bloginID" value="">
		<input type="hidden" name="blecture_seq" id="blecture_seq" value="">


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
								<span class="btn_nav bold">학습관리</span> <span
									class="btn_nav bold">수강목록</span> <a href="../std/regSubject.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>수강 목록</span><span class="fr"> 
								<select id="select" name="select" style="width: 100px;" v-model="select" >
									<option value = "">전체</option>
									<option value = "lecture">강의명</option>
									<option value = "name">강사</option>
							    </select> 
		     	                <input type="text" style="width: 150px; height: 25px;" id="search" name="search" v-model="search">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
			                    </span>
							</p>

							<div class="divComGrpCodList" id="sregSubarea">

								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="15%">
										<col width="15%">
										<col width="30%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">강의명</th>
											<th scope="col">강사명</th>
											<th scope="col">강의 기간</th>
											<th scope="col">강의실</th>
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
											<tr>
												<td>{{item.num}}</td>
												<td>
													<a href="" @click.prevent="fn_lecturePlan(item.loginID, item.lecture_seq, item.lecture_goal, item.student_survey)">
													[{{item.lecture_name}}]
													</a>
												</td>
												<td>{{item.teacher_name}}</td>
												<td>{{item.lecture_start}}  &#126; {{item.lecture_end}}</td>
												<td>{{item.room_name}}</td>
											</tr>
										</tbody>
									</template>
								</table>
								<div class="paging_area" id="lectureListPagination" v-html="pagenavi"></div>
							</div>

							<br> <br> <br> <br> <br>
							
							<div id="lecturePlan">
							
							<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="15%">
							</colgroup>
							<div v-if=" regSubarea.survey === 'N' ">
								<span class="fr">
									<a class="btnType blue" href="javascript:surveyQuestion()" name="modal" ><span>설문조사</span></a>
								</span>
							</div>
								<thead>
									<tr>
										<th>강의 목표</th>
										<td colspan=2>&nbsp;&nbsp;{{regSubarea.goal}}</td>
									</tr>
									<tr>
										<th scope="col">주차</th>
										<th scope="col">학습목표</th>
										<th scope="col">학습내용</th>
									</tr>
								</thead>
								<tbody v-for="(item, index) in listitem">
									<tr>
										<td>{{item.plan_week}}</td>
										<td>{{item.plan_goal}}</td>
										<td>{{item.plan_content}}</td>
									</tr>
								</tbody>
							</table>
							</div> <!-- 하단 list의 목록 -->
							
							</div><!--// content -->
						</div> 
						
	
						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		<!-- 모달팝업 -->


	<!--// 모달팝업 -->

		<div id="layer1" class="layerPop layerType2" style="width: 800px;">
			<dl>
			<dt>
				<strong>설문 조사</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					
					<tbody v-for="(item, index) in listitem" :key="index">
						<tr>
							<th>{{item.serveyitem_queno}}. {{item.serveyitem_question}}</th>
							<td>
								 
								<input type="radio" :name="'use_yn' + index" v-model="answer['use_yn' + index]" :value="1"/><label :for="'use_yn' + index">{{item.serveyitem_que_one}}</label><br>
								
								<input type="radio" :name="'use_yn' + index" v-model="answer['use_yn' + index]" :value="2"/>{{item.serveyitem_que_two}}<br>
								
								<input type="radio" :name="'use_yn' + index" v-model="answer['use_yn' + index]" :value="3"/>{{item.serveyitem_que_three}}<br>
								
								<input type="radio" :name="'use_yn' + index" v-model="answer['use_yn' + index]" :value="4"/>{{item.serveyitem_que_four}}<br>
								
								<input type="radio" :name="'use_yn' + index" v-model="answer['use_yn' + index]" :value="5"/>{{item.serveyitem_que_five}}
							</td>
						</tr>
					</tbody>
					
				</table>
								
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType blue"  id="" name="btn" @click.prevent="saveSurvey()"><span>저장</span></a>
					<a href=""	class="btnType gray"  id="btnCloseModal" name="btn"><span>취소</span></a>
				</div>
			</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>