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

	// 강의 목록 페이징 설정
	var pageSizetestResultLecture = 5;
	var pageBlockSizetestResultLecture = 5;
	
	// 학생 목록 페이징 설정
	var pageSizetestResultStudent = 5;
	var pageBlockSizetestResultStudent = 10;
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lectureno", "all", "");
		
		testResultLectureList();
		
		$(".divtestResultStudent").hide();
		$("#testResultStudentPagination").hide();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
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
				pageSize : pageSizetestResultLecture,
				lectureNameSearch : $("#lectureNameSearch").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#listtestResultLecture").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizetestResultLecture, pageBlockSizetestResultLecture, 'testResultLectureList');
			
			$("#testResultLecturePagination").empty().append(paginationHtml);
			
			$("#selectlectureno").val("");
			
			$(".divtestResultStudent").hide();
			$("#testResultStudentPagination").hide();
			
			fn_testResultSelect();
		};
		
		callAjax("/adm/testResultLectureList.do", "post" , "text", "false", param, listcallback);
		
	}
	
	/* 강의명 눌러서 목록 띄위기 */
	function fn_testResultStudentList(lectureno){
		
		$(".divtestResultStudent").show();
		$("#testResultStudentPagination").show();
		
		$("#selectlectureno").val(lectureno);
		
		fn_testResultSelect();
		
	}
	
	/* 학생 목록 조회 */
	function fn_testResultSelect(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizetestResultStudent,
				lectureno : $("#selectlectureno").val(),
				lectureNameSearch : $("#lectureNameSearch").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#listtestResultStudent").empty().append(returndata);
			
			var totalcnt = $("#stotalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizetestResultStudent, pageBlockSizetestResultStudent, 'fn_testResultSelect');
			
			
			$("#testResultStudentPagination").empty().append(paginationHtml);
			
			$("#studentpage").val(pagenum);
			
		};
		
		callAjax("/adm/testResultSelect.do", "post" , "text", "false", param, listcallback);
		
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

						<p class="conTitle">
							<span>시험 결과</span> <span class="fr">
							    
								강의명
		     	                <input type="text" style="width: 300px; height: 25px;" id="lectureNameSearch" name="lectureNameSearch">                    
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divtestResultLecture">
							
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
								<tbody id="listtestResultLecture"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="testResultLecturePagination"> </div>
						
						<br/>
						<br/>
						
						<div class="divtestResultStudent">
							
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
								<tbody id="listtestResultStudent"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="testResultStudentPagination"> </div>
						
						
						
						
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