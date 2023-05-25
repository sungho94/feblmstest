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
		TeacherList();
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
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearch':
					TeacherList();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	/* 강사 목록 */
	function TeacherList(pagenum){
		
		pagenum =  pagenum || 1;
		
		var param = {
				
			pagenum : pagenum,
			pageSize : pageSize,
			search : $("#search").val()
		};
		
		var teacherListCallback = function(data){
			console.log("teacherListCallback : " +  data);
			
			$("#tbodyTeacherList").empty().append(data);
			
			var totalcnt = $("#teacherCnt").val();
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize , 'TeacherList');
	         $("#teacherListPagination").empty().append( paginationHtml );
			
	         
		};
		callAjax("/adm/teacherlist.do", "post", "text", "false", param, teacherListCallback); 
	}
	
	
	/* 승인 & 미승인 ( 유저타입 업데이트 ) */
	function typesearch(loginid){
		$("#loginID").val(loginid),
		typeUpdate();
	}
	
	function typeUpdate(){
		
		var param = {
				loginID : $("#loginID").val(),
				userType : 'B'
		}
		
		var updateCallback= function(data){
			console.log("updateCallback : " + JSON.stringify(data));
			TeacherList();
		}
		
		callAjax("/adm/tutupdate.do", "post", "json", "false", param, updateCallback); 
	}
	 
	
	/* 강사 정보 상세보기 */
	function tutInfo(loginID){
		
	    var param = {
			loginID : loginID
		}
		
		var tutInfoCallback= function(data){
			console.log("tutInfoCallback : " + JSON.stringify(data));
			var teacherInfo = data.teacherInfo
			
			$("#tutId").empty().append(teacherInfo.loginID);
			$("#tutName").empty().append(teacherInfo.name);
			$("#tutRegdate").empty().append(teacherInfo.user_regdate);
			$("#tutHp").empty().append(teacherInfo.user_hp);
			$("#tutEmail").empty().append(teacherInfo.user_email);
			$("#tutBirthday").empty().append(teacherInfo.user_birthday);
			$("#tutAddress").empty().append(teacherInfo.user_address);
			$("#tutLecture").empty().append(teacherInfo.lectureName);
			
			gfModalPop("#tutInfoLayer");
		}
		
		callAjax("/adm/tutInfoDetail.do", "post", "json", "false", param, tutInfoCallback); 
	}
	 
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="loginID" id="loginID" value="">
	
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
								class="btn_nav bold">인원관리</span> <span class="btn_nav bold">강사관리</span> 
								<a href="../adm/teacher.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강사관리</span>
							<span class="fr">
							 <select id="teacherName" name="teacherName" style="width: 150px;">
							      <option value="name">강사명(ID)</option> </select>
		     	                <input type="text" style="width: 200px; height: 25px;" id="search" name="search" placeholder="검색어를 입력하세요">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강사명 </th>
										<th scope="col">연락처</th>
										<th scope="col">이메일</th>
										<th scope="col">가입일자</th>
										<th scope="col">승인여부</th>
									</tr>
								</thead>
								<tbody id="tbodyTeacherList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="teacherListPagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 강사 정보 상세보기  -->
	<div id="tutInfoLayer" class="layerPop layerType2" style="width: 800px; height: 350px;">
		<dl>
			<dt>
				<strong>강사 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" style="width: 750px; height: 200px;">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row"> 아이디 </th>
							 <td ><div id="tutId"></div></td>
							<th scope="row"> 이름</th>
							 <td colspan="3"><div id="tutName"></div></td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><div id="tutHp"></div></td>
							<th scope="row">이메일 </th>
							<td ><div id="tutEmail"></div></td>
						</tr>
						<tr>
							<th scope="row">생년월일</th>
							<td ><div id="tutBirthday"></div></td>
							<th scope="row">주소 </th>
							<td><div id="tutAddress"></div></td>
						</tr>
						<tr>
						    <th scope="row"> 가입일 </th>
							 <td><div id="tutRegdate"></div></td>
							<th scope="row">진행 중인 수업</th>
							 <td ><div id="tutLecture"></div></td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>