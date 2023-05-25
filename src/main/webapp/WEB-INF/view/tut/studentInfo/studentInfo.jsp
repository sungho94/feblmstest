<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

	// 수강정보 페이징설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5; 
	
	// 학생정보 페이징 설정
	var pageSizeStudent= 5;
	var pageBlockSizeStudent= 10;
	
	
	/** OnLoad event */ 
	$(function() {
		
		 fSearchLecture();
		
		selectComCombo("lecbyuser", "lecture_no", "all", ""); 
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveLecture' :
					fSaveGrpCod();
					break;			
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnSearchLecture':
					fSearchLecture();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	function fSearchLecture(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				loginID : $("#loginID").val(),
				lectureNameSearch : $("#lecture_no").val()
		};
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#lectureInfoList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeLecture, pageBlockSizeLecture, 'fSearchLecture');
			console.log("paginationHtml : " + paginationHtml);
			$("#lecturePagination").empty().append(paginationHtml);
			
			//$("#weeklectureno").val("");
			
			//fn_weekPlanListSearch();
		};
		
		callAjax("/tut/lectureInfoList.do", "post" , "text", "false", param, listcallback);
		$("#divStudentInfo").hide();
	}
	function studentInfoList(lecture_seq) {
		$("#lecture_seq").val(lecture_seq);
		fn_studentInfoSelect();
	}
	function fn_studentInfoSelect(spagenum){
		
			spagenum = spagenum || 1;
			
			var param = {
					spagenum : spagenum,
					pageSize : pageSizeStudent,
					lecture_seq : $("#lecture_seq").val()
			};
			var listcallback = function(returndata) {
				console.log("returndata : " + returndata);
				
				$("#studentInfoList").empty().append(returndata);
				
				var stotalcnt = $("#stotalcnt").val();
				
				var paginationHtml = getPaginationHtml(spagenum, stotalcnt, pageSizeStudent, pageBlockSizeStudent, 'fn_studentInfoSelect');
				
				console.log("studentInfo_paginationHtml : " + paginationHtml);
				
				$("#studentPagination").empty().append(paginationHtml);
				
				
			};
			
			callAjax("/tut/studentInfoList.do", "post" , "text", "false", param, listcallback);
			
			
			$("#divStudentInfo").show();
		};
		function stdLectureApproval(loginID , lecture_seq){
			
			$("#studentID").val(loginID);
			$("#slecture_seq").val(lecture_seq);
			
			var param={
					loginID : loginID, 
					lecture_seq : lecture_seq 
					
			}
			var listcallback = function(returndata) {
				console.log("returndata : " + returndata);
	
				alert("수강으로 수정되었습니다.");
				fSearchLecture();
				fn_studentInfoSelect();
			};
			callAjax("/tut/studentInfoConfirmYes.do", "post" , "json", "false", param, listcallback);
			
		};
		function stdLectureDisapproval( loginID , lecture_seq){
			
			var param={
					loginID : loginID,
					lecture_seq : lecture_seq 
					 
			}
			var listcallback = function(returndata) {
				console.log("returndata : " + returndata);
			
			alert("수강취소로 수정되었습니다.");
			fSearchLecture();
			fn_studentInfoSelect();
			
			};
			callAjax("/tut/studentInfoConfirmNo.do", "post" , "json", "false", param, listcallback);
		};
		function lecture_personExceed(){
			alert("정원초과");
			var loginID=$("#studentID").val();
			var lecture_seq=$("#slecture_seq").val();
			stdLectureDisapproval( loginID , lecture_seq);
			return;
		}
		
		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="loginID" id="loginID" value="${loginId}"><!-- 로그인한 강사 -->
	<input type="hidden" name= "studentID" id="studentID" value=""> <!-- 수업 수강학생   (승인을 했는데 인원초과시 다시 승인취소에 필요) -->
	<input type="hidden" name="lecture_seq" id="lecture_seq" value="">
	<input type="hidden" name="slecture_seq" id="slecture_seq" value=""><!-- 승인을 했는데 인원초과시 다시 승인취소에 필요 -->
	
	
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">수강생 정보</span> 
								<a href="../tut/studentInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수업 정보</span> <span class="fr"> 
							   <select id="lecture_no" name="lecture_no" style="width: 150px;" >
							    </select> 
							 
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
							    <!-- <a	class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>뒤로가기</span></a> -->
							</span>
						</p>
						
						<div class="divLectureInfo">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="17%">
									<col width="6%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">강의실</th>
										<th scope="col">현재인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="lectureInfoList"></tbody>

							</table>
						</div>
	
						
						 <div class="paging_area"  id="lecturePagination"> </div>
						<br>
						<br>
						<br>
						<!-- 수강학생 정보 -->
						<div class="divStudentInfo" id="divStudentInfo">
							
							<p class="conTitle">
								<span>수강생 명단</span> 
								<span class="fr"></span>
							</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">이름</th>
										<th scope="col">학생아이디</th>
										<th scope="col">전화번호</th>
										<th scope="col">생년월일</th>
										<th scope="col">설문여부</th>
										<th scope="col">시험여부</th>
										<th scope="col">승인여부</th>
										<th scope="col">승인/취소</th>
									</tr>
								</thead>
								<tbody id="studentInfoList"></tbody>

							</table>
						
	
						
						 <div class="paging_area"  id="studentPagination"> </div>
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