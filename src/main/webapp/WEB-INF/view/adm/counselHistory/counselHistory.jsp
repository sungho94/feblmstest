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
	var pageSize = 5;
	var pageBlockSize = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	
	/** OnLoad event */ 
	$(function() {
		
		comcombo("lecture_no", "lectureNo", "all", "");
		
		lectureList();
		$("#counselList").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnCounselUpdate' :
					break;
				case 'btnSearch':
					lectureList();
					break;
				case 'btnClose' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	/* 강의 목록 */	
	function lectureList(pageNum){
		
		$("#counselList").hide();
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				lectureNo : $("#lectureNo").val()
		}
		
		var lectureListCallback = function(data){
			console.log(" lectureList : " + data);
			$("#tbodyLectureList").empty().append(data);
			
	         var totalcnt =  $("#lectureCnt").val(); 
	         
	         var paginationHtml = getPaginationHtml(pageNum, totalcnt, pageSize, pageBlockSize, 'lectureList');
	        
	         console.log(" paginationHtml : "+paginationHtml);
	         
	         $("#lectureListPagination").empty().append( paginationHtml );
		}
		
		callAjax("/adm/lecturelist.do", "post", "text", "false", param, lectureListCallback); 
	}
	
	
	/* 상담 목록 */
	function fn_counsel(lectureSeq){
		console.log("lectureSeq : " + lectureSeq)
		
		$("#lectureSeq").val(lectureSeq);
		counselList();
	}
	
	function counselList (pageNum){
		$("#counselList").show();
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				lectureSeq : $("#lectureSeq").val()
		}
		
		var counselListCallback = function(data){
			
			console.log("counselList: " + data);
			
			$("#tbodyCounselList").empty().append(data);
			
	         var totalcnt =  $("#counselCnt").val(); 
	         var paginationHtml = getPaginationHtml(pageNum, totalcnt, pageSize, pageBlockSize, 'counselList');
				               
	         console.log(" paginationHtml : "+paginationHtml);
	         
	         $("#counselListPagination").empty().append( paginationHtml );
		}
		
		callAjax("/adm/counselList.do", "post", "text", "false", param, counselListCallback); 
	}
	
	
	/* 상담 상세 조회 */
	
	function fn_selectCounsel(consultantNo){
		
		var param = {
				consultantNo : consultantNo
		}
		
		var selectCallback = function(data){
			console.log("selectCallback : " + JSON.stringify(data));
			
			var selectCounsel= data.counselInfo
			 $("#lecture").empty().append(selectCounsel.lecture_name);	
			 $("#consultantNo").empty().append($("#counselno").val());
			 $("#consultantName").empty().append(selectCounsel.stu_name);	
			 $("#consultantContent").empty().append(selectCounsel.consultant_content);	
			 $("#consultantCounsel").empty().append(selectCounsel.consultant_counsel);	
			 $("#consultantDate").empty().append(selectCounsel.consultant_date);	
			
			 gfModalPop("#counselSaveLayer");
		}
		 callAjax("/adm/counselSelect.do", "post" , "json", "false", param, selectCallback);
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lectureName" id="lectureName" value="">
	<input type="hidden" name="lectureSeq" id="lectureSeq" value="">
	<input type="hidden" name="counselno" id="counselno" value="">
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">수강 상담 이력</span> 
								<a href="../adm/counselHistory.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의 목록</span> <span class="fr"> 
							   <select id="lectureNo" name="lectureNo" style="width: 150px;" ></select>                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="50%">
										<col width="30%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">기간</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="tbodyLectureList"></tbody> 
								</table>
							<div class="paging_area"  id="lectureListPagination"> </div>
						</div>
						<br>
						<br>
						
	                    <div id="counselList">
		                    <p class="conTitle">
								<span>상담 이력</span>
								<span class="fr"> 
								</span>
						    </p>
							<table class="col">
								<caption>caption</caption>
								  <colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
								  </colgroup>
								  <thead>
								      <tr>
										<th scope="col">강의명</th>
										<th scope="col">학생명</th>
										<th scope="col">상담일</th>
										<th scope="col">작성일</th>
										<th scope="col">상담사</th>
										<th scope="col"></th>
									  </tr>
								  </thead>
								<tbody id="tbodyCounselList"></tbody>
							</table>
						<div class="paging_area"  id="counselListPagination"> </div>
					</div>
	
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="counselSaveLayer" class="layerPop layerType2" style="width: 800px; height: 480px;">
		<dl>
			<dt>
				<strong>상담 내용</strong>
			</dt>
			<dd class="content">
				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>
					
					<tbody>
							<input type="hidden" class="inputTxt p100" name="consultantNo" id="consultantNo" />
						<tr>
							<th scope="row" >강의명 </th>
							<td><div id="lecture" ></div></td>
							
							<th scope="row">학생명 </th>
							<td><div id="consultantName" ></div>
							</td>
						</tr>
						<tr>
							<th scope="row">상담일 </th>
							<td><div id="consultantCounsel" ></div></td>
							
							<th scope="row">작성일</th>
							<td><div id="consultantDate" ></div></td>
						</tr>
						<tr style=" height: 200px;">
							<th scope="row">상담 내용</th>
							<td colspan="3"><div id="consultantContent" ></div></td>
						</tr>	
				
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>