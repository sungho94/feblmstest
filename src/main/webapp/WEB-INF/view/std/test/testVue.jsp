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

	// 수강중인 강의 목록
	var pageSize = 5;
	var pageBlockSize = 5;
	
	var testLectureSearch;
	var testLectureList;
	var question;
	
	/** OnLoad event */ 
	$(function() {
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		init();
		
		fn_testLectureList();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				/* case 'btnSearch' :
					testLectureList();
					break; */
			}
		});
	}
	
	function init(){
		
		testLectureSearch = new Vue({
			el : "#testSearch",
			data : {
				loginID : "",
				select : "",
				search : "",
			}
		});
		
		testLectureList = new Vue({
			el : "#testList",
			data : {
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
			}
		});
		
		
		question = new Vue({
			el : "#testQuestion",
			data : {
				lecture_seq : 0,
				listitem : [],
				testQuestionCnt : 0,
				test_no : 0,
				use_yn : {},
			}
		});
		
		comcombo("rm_seq", "rmseq", "all", "");
		
	}
	
	// 강의 목록 조회
	function fn_testLectureList(pageNum){
		
		testLectureSearch.loginID = '${loginID}';
		console.log("loginID = "+testLectureSearch.loginID); 
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				loginID : testLectureSearch.loginID,
				select : testLectureSearch.select,
				search : testLectureSearch.search
		}
		var testLectureListCallBack= function(data){
			
			console.log(data);
			
			testLectureList.cpage = pageNum;
			testLectureList.listitem = data.testLectureList;
			testLectureList.totalcnt = data.totalCnt;
			
			var paginationHtml = getPaginationHtml(pageNum, data.totalCnt, pageSize, pageBlockSize, 'fn_testLectureList');
			
			testLectureList.pagenavi = paginationHtml;
		}
		callAjax("/std/vueTestLectureList.do", "post", "json", "false", param, testLectureListCallBack);
	}
	
	// 시험 문제 불러오기
	function fn_test(lecture_seq){
		
		question.lecture_seq = lecture_seq;
		
		console.log("question.lecture_seq : "+question.lecture_seq);
		
		var param = {
				lecture_seq : question.lecture_seq,
		}
		
		var testCallBack = function(data){
			
			console.log(data);
			
			question.listitem = data.testQuestion;
			question.testQuestionCnt = data.testQuestionCnt;
			
			fn_modalPop(data.testQuestion);
			
		}
		callAjax("/std/vueTestQuestion.do", "post", "json", "false", param, testCallBack)
	}
	
	function fn_modalPop(data){
		
		console.log(data);
		
		console.log("question.test_no : "+question.test_no);
		if(data == 0 || data == "" || data == null || data == undefined){
			swal("준비중입니다.");
		}else{
			
			question.test_no = data[0].test_no;
	
			gfModalPop("#testQuestion");
		}
	}
	
	// 시험문제 저장
	function saveQuestion(){
		
		console.log("use_yn : "+question.use_yn);
		
		var param = {
				lecture_seq : question.lecture_seq,
					test_no : question.test_no,
					loginID : testLectureSearch.loginID,
					use_yn : question.use_yn,
				testQuestionCnt : question.testQuestionCnt,
		}
		
		console.log("param값 : "+JSON.stringify(param));
		
		var saveQuestionCallBack = function(data){
			
			console.log("saveQuestionCallBack : "+JSON.stringify(data));

			gfCloseModal();
			
			location.reload();
			
		}
		
		callAjax("/std/vueSaveQuestion.do", "post", "json", "false", param, saveQuestionCallBack)
	}
	 
</script>

</head>
<body>
<form id="myForm" action=""  method="">
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험 관리</span> 
								<a href="../std/test.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="testSearch">
							<span>시험 응시</span> <span class="fr"> 
								<select id="select" name="select" style="width: 100px;" v-model="select">
									<option value = "">전체</option>
									<option value = "lecture">강의명</option>
									<option value = "name">강사</option>
							    </select> 
		     	                <input type="text" style="width: 150px; height: 25px;" id="search" name="search" v-model="search">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn" @click.prevent="fn_testLectureList()"><span>검  색</span></a>
			                    </span> 
						</p>
						
						<div class="divComGrpCodList" id="testList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의 기간</th>
										<th scope="col">결과</th>
										<th scope="col">시험응시</th>
									</tr>
								</thead>
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr>
											<td>{{item.num}}</td>
											<td>{{item.lecture_name}}</td>
											<td>{{item.teacher_name}}({{item.loginID}})</td>
											<td>{{item.lecture_start}} ~ {{item.lecture_end}}</td>
											<td v-if="item.student_test === 'Y' && item.score >= 60">통과</td>
											<td v-else-if="item.student_test === 'Y' && 60 > item.score">과락</td>
											<td v-if="item.student_test === 'N'">미응시</td>
											<td v-if="item.student_test === 'Y'">응시완료</td>
											<td v-else-if="item.student_test === 'N'"><a href="" class="btnType blue" @click.prevent="fn_test(item.lecture_seq)" name="modal"><span>시험응시</span></a></td>
										</tr>
									</tbody>
								</template>
							</table>
							<div class="paging_area"  id="lectureListPagination" v-html="pagenavi"> </div> 
						</div>
	
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	</form>

	<!-- 모달팝업 -->
	<form id="questionForm" action="" method="">	
		<div id="testQuestion" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>시험 문제</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="50%">
							<col width="50%">
						</colgroup>
						<template v-if="testQuestionCnt === 0">
							<tbody>
								<tr>
									<td colspan="2">시험 문제가 없습니다.</td>
								</tr>
							</tbody>
						</template>
						<template v-else>
							<tbody v-for="(item,index) in listitem">
								<tr>
									<th scope="row">Q{{item.question_no}}. {{item.question_ex}}</th> 
									<td><input type="radio" id="radio"
											name="use_yn" v-model="use_yn[index+1]" value="1" /> <label
											for="radio1">{{item.question_one}}</label><br> <input
											type="radio" id="radio" name="use_yn" v-model="use_yn[index+1]"
											value="2" /> <label for="radio2">{{item.question_two}}</label><br>
											<input type="radio" id="radio" name="use_yn" v-model="use_yn[index+1]"
											value="3" /> <label for="radio3">{{item.question_three}}</label><br>
											<input type="radio" id="radio" name="use_yn" v-model="use_yn[index+1]"
											value="4" /> <label for="radio4">{{item.question_four}}</label><br></td>
								</tr>
							</tbody>
						</template>
					</table>
			
					<!-- e : 여기에 내용입력 -->
			
					<div class="btn_areaC mt30">
						<a href="javascript:saveQuestion()" class="btnType blue" id="" name="btn"><span>저장</span></a> 
						<a href="javascript:gfCloseModal()" class="btnType gray" id="" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop" @click.prevent="gfCloseModal()"><span class="hidden">닫기</span></a>
		</div>
	<!--// 모달팝업 -->
	</form>
</body>
</html>