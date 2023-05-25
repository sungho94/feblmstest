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
	
	// 변수 선언
	var searcharea;
	var listarea;
	var lecList;

/* 	// 강의 목록 페이징 설정
	var pageSizetestResultLecture = 5;
	var pageBlockSizetestResultLecture = 5;
	
	// 학생 목록 페이징 설정
	var pageSizetestResultStudent = 5;
	var pageBlockSizetestResultStudent = 10; */
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lectureno", "all", "");
		
		init();
		
		testResultLectureList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function init() {	
		
		searcharea = new Vue({
			el : "#searcharea",
			data : {
				lectureNameSearch : ""
			}
		});
		
		listarea = new Vue({
			el : "#listarea",
            data : {
            	       listitem : [],
            	       totalcnt : 0,
            	       cpage :0,      //현재 조회하고있는 page
            	       pagesize : 5,
            	       blocksize : 5,//pagenavigation 번호 몇까지 나오는지
            	       pagenavi : "", // vhtml 연결할 놈이어서 str로
            }, methods : {
            	testResultSelect : function(lecture_no) {
            		testResultSelect(lecture_no);
               	 }
            }
		});
		
		lecList = new Vue ({
			el : "#lecList",
			data : {
					listitem : [],
	     	        totalcnt : 0,
	     	        cpage :0,      //현재 조회하고있는 page
	     	        pagesize : 5,
	     	        blocksize : 10,//pagenavigation 번호 몇까지 나오는지
	     	        pagenavi : "", // vhtml 연결할 놈이어서 str로
	     	        lectureno : 0,
	     	        passflag : false,
	     	        //passrs : true,

			}, /* methods: {
				passrs:function() {
					if(score < 60){
						passrs = true;
					} else {
						passrs = false;
					}
				}
			} */
			
		});
		
		
	} //init

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnLectureSearch' :
					testResultLectureList();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	

	
	/* 강의 목록 조회 */
	function testResultLectureList(pagenum){
		
		pagenum = pagenum || 1;

		
		var param = {
				
				pagenum : pagenum,
				pageSize : listarea.pagesize,
				lectureNameSearch : searcharea.lectureNameSearch
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			listarea.listitem = returndata.testResultLectureList;
			listarea.totalcnt = returndata.totalcnt;
			
		var paginationHtml = getPaginationHtml(pagenum, listarea.totalcnt, listarea.pagesize, listarea.blocksize, 'testResultLectureList');
			
			listarea.pagenavi = paginationHtml;
			
		};
		
		callAjax("/adm/vuetestResultLectureList.do", "post" , "json", "true", param, listcallback);
		
	}
	
	function testResultSelect(lectureno) {
		lecList.passflag = true;
		lecList.lectureno = lectureno;
		
		fn_testResultSelect();
	}
	
	/* 학생 목록 조회 */
	function fn_testResultSelect(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : lecList.pagesize,
				lectureno : lecList.lectureno,
				lectureNameSearch : searcharea.lectureNameSearch
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			lecList.listitem = returndata.testResultSelect
			lecList.totalcnt = returndata.totalcnt
			
			var paginationHtml = getPaginationHtml(pagenum, lecList.totalcnt, lecList.pagesize, lecList.blocksize, 'fn_testResultSelect');
			
			lecList.pagenavi = paginationHtml;			
		};
		
		callAjax("/adm/vuetestResultSelect.do", "post" , "json", "true", param, listcallback);
		
	}
	
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="selectlectureno" id="selectlectureno" value="">
	<input type="hidden" name="studentpage" id="studentpage" value="">
	
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

						<p class="conTitle" id="searcharea">
							<span>시험 결과</span> <span class="fr">
							    
								강의명
		     	                <input type="text" style="width: 300px; height: 25px;" id="lectureNameSearch" name="lectureNameSearch" v-model="lectureNameSearch">                    
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="listarea">
							
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
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=7> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for = "(item,index) in listitem">
										<tr >
											<td>{{ item.lecture_seq }}</td>
											<td>
											<a href="" @click.prevent="testResultSelect(item.lecture_no)">
											    <span>{{ item.lecture_name }}</span>
											</a>
											</td>
											<td>{{ item.name }}</td>
											<td>{{ item.test_no }}</td>
											<td>{{ item.lecture_person }}</td>
											<td>{{ item.aft }}</td>
											<td>{{ item.bef }}</td>
										</tr>
									</tbody>
								</template>
							</table>
						<div class="paging_area"  id="testResultLecturePagination" v-html="pagenavi"> </div>
						</div>
	
						
						<br/>
						<br/>
						
						<div id="lecList" v-show="passflag">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="40%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생 ID</th>
										<th scope="col">학생 이름</th>
										<th scope="col">총점</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=4> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for = "(item,index) in listitem">
										<tr>
											<td>{{ item.loginID }}</td>
											<td>{{ item.name }}</td>
											<td>{{ item.score }}</td>
											<td v-if=" item.score >= 60">통과</td>
											<td v-else>과락</td>
										</tr>
									</tbody>
								</template>
							</table>
						<div class="paging_area"  id="testResultStudentPagination" v-html="pagenavi"> </div>
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