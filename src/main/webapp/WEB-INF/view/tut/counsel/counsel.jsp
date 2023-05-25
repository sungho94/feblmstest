<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	// 강의목록 페이징 설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5;
	
	// 학생목록 페이징 설정
	var pageSizeStudent = 5;
	var pageBlockSizeStudent = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		lectureList();
		
		$("#studentListDiv").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnInsert' :
					fn_modalPop();
					break;
				case 'btnModify' :
					fn_modifyPop();
				break; 
				case 'btnSave' :
					saveCounsel();
					break;
				case 'btnDelete' :
					$("#action").val("D");
					saveCounsel();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	// 강의 목록 조회
	function lectureList(pageNum){
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizeLecture,
				loginID : '${loginID}'
				
		}
		
		var lectureListCallBack = function(data){
			console.log(data);
			
			$("#lectureList").empty().append(data);
			
			var totalCnt = $("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizeLecture, pageBlockSizeLecture, 'lectureList');
			
			$("#lectureListPagination").empty().append(paginationHtml);
		}
		callAjax("/tut/counselLectureList.do", "post", "text", "false", param, lectureListCallBack)
	}
	
	// 학생 목록 들어가기전 백업
	function fn_backUP(lecture_seq){
		$("#blecture_seq").val(lecture_seq);
		studentList();
	}
	
	// 학생 목록 조회
	function studentList(lecture_seq, pageNum){
		
		$("#studentListDiv").show();
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizeStudent,
				loginID : '${loginID}',
				lecture_seq : $("#blecture_seq").val()
		}
		
		var studentListCallBack = function(data){
			console.log(data)
			
			$("#studentList").empty().append(data);
			
			var totalCnt = $("#stotalCnt").val();
			
			var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizeStudent, pageBlockSizeStudent, 'studentList');
			
			$("#studentListPagination").empty().append(paginationHtml);
		}
		callAjax("/tut/counselStudentList.do", "post", "text", "false", param, studentListCallBack)
	}
	
	// 모달 팝업
	function fn_modalPop(consultant_no){
		
		console.log(consultant_no)
		if(consultant_no == null || consultant_no == "" || consultant_no == undefined){
			$("#action").val("I")
			fn_form();
			
		} else {
			detailStudent(consultant_no);
		}
	}
	
	// 학생 상세보기
	function detailStudent(consultant_no){
		console.log(consultant_no);
		var param = {
				consultant_no : consultant_no
		}
		
		var detailStudentCallBack = function(data){
			console.log(data);
			
			fn_form(data.detailStudent);
			fn_modifyForm(data.detailStudent);
			
			$("#bconsultant_no").val(data.detailStudent.consultant_no);
			
			
		}
		callAjax("/tut/detailStudent.do", "post", "json", "false", param, detailStudentCallBack)
	}
	
	
	
	// 폼 작성
	function fn_form(consultant_no){
		
		if(consultant_no == null || consultant_no == "" || consultant_no == undefined){
			
			gfModalPop("#layer1");
			var inhtml =  "<select name='lecbyuserall2' id='lecbyuserall2' style='width: 150px;' onchange='javascript:lecbyuser()'></select>";
	        $("#lectureName").empty().append(inhtml);
	        selectComCombo("lecseqUser", "lecbyuserall2", "all", "");
	        
	        var inhtml2 =  "<select name='stuloginID' id='stuloginID' style='width: 150px;'> </select>";
	        $("#loginIdDiv").empty().append(inhtml2) ;
	        //userCombo("usr", "A", "stuloginID", "sel", "");
	        
	        
	        $("#counselDate").val("");
	        $("#counselContent").val("");
	       
		} else {
	        
	        gfModalPop("#layer2");
			$("#lectureDetailName").empty().append(consultant_no.lecture_Name);
			$("#studentDetailName").empty().append(consultant_no.studentName);
			$("#counselDetailDate").empty().append(consultant_no.consultant_counsel);
			$("#counselDetailWritelDate").empty().append(consultant_no.consultant_date);
			$("#counselDetailContent").empty().append(consultant_no.consultant_content);
			
		}
	}
	
	// 수정 모달 팝업
	function fn_modifyPop(consultant_no){
		
		$("#action").val("U")
		
		gfModalPop("#layer3");
		
	}
	
	// 수정 폼 작성
	function fn_modifyForm(consultant_no){
			
		$("#lectureModifyName").empty().append(consultant_no.lecture_Name);
		$("#studentModifyName").empty().append(consultant_no.studentName);
		$("#counselModifyDate").empty().append(consultant_no.consultant_counsel);
		
		$("#counselModifyContent").val(consultant_no.consultant_content);
		
	}
	
	// 저장 및 수정, 삭제
	function saveCounsel(){
		
		var action = $("#action").val();
		
		console.log($("#counselModifyWritelDate").val());
		
		if(action == 'U' || action == 'D'){
			var param = {
					action : action,
					consultant_no : $("#bconsultant_no").val(),
					consultant_content : $("#counselModifyContent").val(),
			}
		} else {
			var param = {
					action : action,
					lecture_seq : $("#lecbyuserall2").val(),
					loginID : '${loginID}',
					stu_loginID : $("#stuloginID").val(),
					consultant_counsel : $("#counselDate").val(),
					consultant_content : $("#counselContent").val(),
			}
		}
		
		console.log(param);
		
		var saveCounselCallBack = function(){
			gfCloseModal();
			location.reload();
		}
		callAjax("/tut/saveCounsel.do", "post", "json", "false", param, saveCounselCallBack)
	}
	
	
	function lecbyuser() {
		console.log("들어왔다");
		userbylecseqCombo('userbylec',$("#lecbyuserall2").val(),'stuloginID','sel','');       
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="blecture_seq" id="blecture_seq" value="">
	<input type="hidden" name="bconsultant_no" id="bconsultant_no" value="">
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">상담</span> 
								<a href="../tut/counsel.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>상담일지</span> <span class="fr"> 
							   <select id="select" name="select" style="width: 100px;" >
									<option value = "">전체</option>
									<option value = "lecture">강의명</option>
									<option value = "name">강사</option>
							    </select> 
		     	                <input type="text" style="width: 150px; height: 25px;" id="search" name="search">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
			                    <a href="" class="btnType blue" id="btnInsert" name="btn"><span>신규등록</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="35%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명(ID)</th>
										<th scope="col">강의기간</th>
										<th scope="col">강의실</th>
									</tr>
								</thead>
								<tbody id="lectureList"></tbody>
							</table>
							<div class="paging_area"  id="lectureListPagination"> </div>
						</div>
						
						<br><br><br><br><br>
						
						<div id="studentListDiv">
							<p class="conTitle">
								<span>학생 목록</span>
							</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">상담 번호</th>
										<th scope="col">학생 명(ID)</th>
										<th scope="col">수강 강의</th>
										<th scope="col">상담일자</th>
										<th scope="col">작성일자</th>
										<th scope="col">강사(ID)</th>
									</tr>
								</thead>
								<tbody id="studentList"></tbody>
							</table>
	
							<div class="paging_area"  id="studentListPagination"> </div>
						</div>
						
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 신규 등록 모달 팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명 <span class="font_red">*</span></th>
							<td><div id = "lectureName"></div></td>
							<th scope="row">학생명 <span class="font_red">*</span></th>
							<td><div id = "loginIdDiv"></div></td>
						</tr>
						<tr>
							<th scope="row">상담일자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100"
								name="counselDate" id="counselDate" /></td>
							<th scope="row">작성일자 <span class="font_red">*</span></th>
							<td id ="counselWriteDate"><c:set var="ymd" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<th scope="row">상담내용 <span class="font_red">*</span>
							<td colspan=3>
							<textarea class="inputTxt p100" id = "counselContent" >
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 신규등록 모달 팝업 -->
	
	<!-- 상세보기 모달 팝업 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상세보기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명 </th>
							<td><div id = "lectureDetailName"></div></td>
							<th scope="row">학생명 </th>
							<td><div id = "studentDetailName"></div></td>
						</tr>
						<tr>
							<th scope="row">상담일자</th>
							<td><div id = "counselDetailDate"></div></td>
							<th scope="row">작성일자 </th>
							<td ><div id = "counselDetailWritelDate"></div></td>
						</tr>
						<tr>
							<th scope="row">상담내용</th>
							<td colspan=3>
							<div id = "counselDetailContent">
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnModify" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 상세보기 모달 팝업 -->
	
	<!-- 수정 모달 팝업 -->
	<div id="layer3" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명 </th>
							<td><div id = "lectureModifyName"></div></td>
							<th scope="row">학생명 </th>
							<td><div id = "studentModifyName"></div></td>
						</tr>
						<tr>
							<th scope="row">상담일자</th>
							<td><div id = "counselModifyDate"></div></td>
							<th scope="row">수정일자 </th>
							<td id ="counselModifyWritelDate"><c:set var="ymd" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<th scope="row">상담내용</th>
							<td colspan=3>
							<textarea class="inputTxt p100" id = "counselModifyContent" >
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 수정 모달팝업 -->
</form>
</body>
</html>