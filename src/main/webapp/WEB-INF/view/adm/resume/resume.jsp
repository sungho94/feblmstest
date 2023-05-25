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
	var pageSizeresumeLecture = 5;
	var pageBlockSizeresumeLecture = 5;
	
	// 학생 목록 페이징 설정
	var pageSizeresumeStudent = 5;
	var pageBlockSizeresumeStudent= 10;
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lectureno", "all", "");
		
		$(".divResumeStudent").hide();
		$("#resumeStudentPagination").hide();
		
		resumeLectureListSearch();
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
					resumeLectureListSearch();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	/* 강의 목록 조회 */
	function resumeLectureListSearch(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizeresumeLecture,
				lectureNameSearch : $("#lectureNameSearch").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#resumeLectureList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeresumeLecture, pageBlockSizeresumeLecture, 'resumeLectureListSearch');
			
			$("#resumeLecturePagination").empty().append(paginationHtml);
			
			$("#selectlectureno").val("");
			
			$(".divResumeStudent").hide();
			$("#resumeStudentPagination").hide();
			
			fn_resumeLectureSelect();
			
		};
		
		callAjax("/adm/resumeLectureListSearch.do", "post" , "text", "false", param, listcallback);
		
	}
	
	/* 강의명을 눌러서 학생 목록 조회 */
	function fn_resumeStudentList(lectureno){
		
		$("#selectlectureno").val(lectureno);
		
		$(".divResumeStudent").show();
		$("#resumeStudentPagination").show();
		
		fn_resumeLectureSelect();
		
		console.log(lectureno);
		
	}
	
	/* 학생 목록 조회 */
	function fn_resumeLectureSelect(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizeresumeStudent,
				lectureno : $("#selectlectureno").val(),
				lectureNameSearch : $("#lectureNameSearch").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#resumeStudentList").empty().append(returndata);
			
			var totalcnt = $("#stotalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeresumeStudent, pageBlockSizeresumeStudent, 'fn_resumeLectureSelect');
			
			$("#resumeStudentPagination").empty().append(paginationHtml);
			
		};
		
		callAjax("/adm/resumeLectureSelect.do", "post" , "text", "false", param, listcallback);
		
	}
	
	/* 이력서 다운로드 */
	function fn_resumeDownload(loginID){
		
		$("#selectloginID").val(loginID);
		
		var loginID = $("#selectloginID").val();
	    
		if(loginID == null){
			return;
		}
		var params = "<input type='hidden' name='loginID' id='loginID' value='"+ loginID +"' />";

		jQuery(
				"<form action='/adm/Download.do' method='post'>"
						+ params + "</form>").appendTo('body').submit().remove();
		
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="selectlectureno" id="selectlectureno" value="">
	<input type="hidden" name="selectloginID" id="selectloginID" value="">
	
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
								class="btn_nav bold">취업 관리</span> <span class="btn_nav bold">이력서 관리</span> 
								<a href="../adm/resume.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>이력서 관리</span> <span class="fr">
							
								강의명
		     	                <input type="text" style="width: 300px; height: 25px;" id="lectureNameSearch" name="lectureNameSearch">                    
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divResumeLecture">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="20%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">담당 강사</th>
										<th scope="col">수강 인원</th>
										<th scope="col">강의 시작일</th>
										<th scope="col">강의 종료일</th>
									</tr>
								</thead>
								<tbody id="resumeLectureList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="resumeLecturePagination"> </div>
						
						<br/>
						<br/>
						
						<div class="divResumeStudent">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="25%">
									<col width="25%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생 ID</th>
										<th scope="col">학생 이름</th>
										<th scope="col">전화 번호</th>
										<th scope="col">이메일</th>
										<th scope="col">이력서</th>
									</tr>
								</thead>
								<tbody id="resumeStudentList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="resumeStudentPagination"> </div>
						
						
						
						
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