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

	// 그룹코드 페이징 설정
	var pageSizetestResultLecture = 5;
	var pageBlockSizetestResultLecture = 5;
	
	// 상세코드 페이징 설정
	var pageSizetestResultStudent = 5;
	var pageBlockSizetestResultStudent = 10;
	
	var testResult;
	var divtestResult;
	
	/** OnLoad event */ 
	$(function() {
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		init();
		testResultLectureList();
		
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnLectureSearch' :
					testResultLectureList();
					break;
			}
		});
	}
	
	function init(){
		
		searchArea =new Vue({
								el : "#searchArea",
								data : {
									lectureName : "",
								}
		});
		
		testResult = new Vue ({
								el : "#testResultList",
								data : {
									item : [],
									totalCnt : 0,
									cPage : 0,
									pageNav : "",
									lectureNo : 0,
								},
								/* methods : {
									fn_testStudentLists : function(lectureNo){
										testResult.lectureNo=lectureNo;
										alert("testResult.lectureNo"); 
									}
								}, */
							
		});
		
		divtestResult = new Vue ({
									el : "#divtestResultStudent",
									data : {
											item : [],
											stotalCnt : 0,
											cPage : 0,
											pageNav : "",
											show : false,
									}	
		});
		
	
		comcombo("lecture_no", "lectureName", "all", ""); 
	}
	
	
	function testResultLectureList(pagenum){ 
		
		pagenum = pagenum || 1;
		
		var param = {
					pagenum : pagenum,
					pageSize : pageSizetestResultLecture,
					lectureNameSearch : searchArea.lectureName,
		}
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			testResult.item=returndata.testResultLectureList;
			testResult.totalCnt=returndata.totalcnt;
			testResult.cPage=pagenum;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.totalcnt, pageSizetestResultLecture, pageBlockSizetestResultLecture, 'testResultLectureList');
			
			testResult.pageNav=paginationHtml;
			
		}
		callAjax("/tut/vueTestResultLectureList.do", "post", "json", "false", param, listcallback);
		
		divtestResult.show=false;
	}
	
	function fn_testStudentList(lectureNo){
		
		testResult.lectureNo=lectureNo;
		//alert("testResult.lectureNo : "+testResult.lectureNo); 
		fn_testStudentSelectList();
		
		divtestResult.show=true;
				
	}
	
	function fn_testStudentSelectList(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizetestResultStudent,
				lectureNo : testResult.lectureNo,
		}
		
		var listcallback = function(returndata){
			console.log("returndata0 : " + JSON.stringify(returndata));
			divtestResult.item=returndata.testStudentSelectList;
			divtestResult.stotalCnt=returndata.totalcnt;
			divtestResult.cPage=pagenum;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.totalcnt, pageSizetestResultStudent, pageBlockSizetestResultStudent, 'fn_testStudentSelectList');
			
			divtestResult.pageNav=paginationHtml;
			
		}
		callAjax("/tut/vueTestStudentSelectList.do", "post" , "json", "false", param, listcallback);
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lectureNo" id="lectureNo" value="">
	<input type="hidden" name="resultPagenum" id="resultPagenum" value="">
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험 결과</span> 
								<a href="../adm/testResult.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searchArea">
							<span>시험 결과</span> <span class="fr">
							    
								강의명
		     	                <select name="lectureName" id="lectureName" style="width: 150px;" v-model="lectureName"></select>                   
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divtestResultLecture" id="testResultList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">담당 강사</th>
										<th scope="col">시험번호</th>
										<th scope="col">대상자 수</th>
										<th scope="col">응시인원</th>
										<th scope="col">미응시인원</th>
									</tr>
								</thead>
								<template v-if="totalCnt == 0">
									<tbody>
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in item">
										<tr>
											<td>{{item.lecture_seq}}</td>
											<td><a href="" @click.prevent="fn_testStudentList(item.lecture_seq)">{{item.lecture_name}}</td>
											<td>{{item.name}}</td>
											<td>{{item.test_no}}</td>
											<td>{{item.lecture_person}}</td>
											<td>{{item.aft}}</td>
											<td>{{item.bef}}</td>
										</tr>
									</tbody>
								</template>
							</table>
	
						<div class="paging_area"  id="testResultLecturePagination" v-html="pageNav"> </div>
						</div>
						
						<br/>
						<br/>
						
						<div id="divtestResultStudent" v-show="show">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
							
									<tr>
										<th scope="col">학생 ID</th>
										<th scope="col">학생 이름</th>
										<th scope="col">총점</th>
										<th scope="col">합격상태</th>
									</tr>
								</thead>
								
									<template v-if="stotalCnt == 0">
									<tbody>
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in item">
										<tr>
											<td>{{item.loginID}}</td>
											<td>{{item.name}}</td>
											<td>{{item.score}}</td>									
										<td><template v-if="item.score >=60">
                                  			
                                       			<div>통과</div>
                                  			</template>	
                                  			
                                  			<template v-else>
                                     				<div>과락</div>
                              				</template>
                              			</td>
                              			</tr>
                              		</tbody>	
								</template>
								
							 <!-- <tbody id="listtestResultStudent"></tbody> -->
							</table>
	
						<div class="paging_area"  id="testResultStudentPagination" v-html="pageNav"> </div>
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