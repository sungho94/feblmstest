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

	var resumemange;
	var divResumeLecture;
	var divResumeStudent;

	// 강의 목록 페이징 설정
	var pageSizeresumeLecture = 5;
	var pageBlockSizeresumeLecture = 5;
	
	// 학생 목록 페이징 설정
	var pageSizeresumeStudent = 5;
	var pageBlockSizeresumeStudent= 10;
	
	
	/** OnLoad event */ 
	$(function() {
		init();
		
		resumeLectureListSearch();
		
		comcombo("lecture_no", "lectureno", "all", "");

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
	
	function init(){
		resumemange = new Vue({
			el : "#resumemange",
			data : {
				lectureNameSearch : "",
			},
		})
		
		divResumeLecture = new Vue({
			 el : "#divResumeLecture",
			 data : {
				 pagenum : 0,
				 pageSize : pageSizeresumeLecture,
				 pageBlockSize : pageBlockSizeresumeLecture,
				 lectureNameSearch : "",
				 listitem : [],
				 totalcnt : 0,
				 pagenavi : "",
				 cpage : 0,
			 },
			 methods : {
				 resumeStudentList : function(lecture_no) {
					 resumeStudentList(lecture_no);
				 }
			 }
		})
		
		divResumeStudent = new Vue({
			el : "#divResumeStudent",
			data : {
				pagenum : 0,
				pageSize : pageSizeresumeStudent,
				pageBlockSize : pageBlockSizeresumeStudent,
				show : false,
				lectureno : "",
				totalcnt : 0,
				listitem : [],
				pagenavi : "",
				loginID : "",
			},
			methods : {
				fn_resumeDownload : function(loginID){
					fn_resumeDownload(loginID);
				}
			}
		})
	}
	
	
	//강의목록 조회
	function resumeLectureListSearch(pagenum){
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeresumeLecture,
				lectureNameSearch : resumemange.lectureNameSearch
		}
		
		var listcallback = function(returndata){
			console.log("returndata : " + JSON.stringify(returndata));
			
			divResumeLecture.totalcnt = returndata.totalcnt;
			divResumeLecture.listitem = returndata.resumeLectureListSearch;
			
			var paginationHtml = getPaginationHtml(pagenum, divResumeLecture.totalcnt, pageSizeresumeLecture, pageBlockSizeresumeLecture, 'resumeLectureListSearch');
			
			divResumeLecture.pagenavi = paginationHtml;


			divResumeStudent.show = false;
		
		}
		
		callAjax("/adm/resumeLectureListSearchVue.do", "post" , "json", "true", param, listcallback);
	}
	
	function resumeStudentList(lecture_no){
		divResumeStudent.show = true;
		
		divResumeStudent.lectureno=lecture_no;
		fn_resumeStudentList();
	}
	
	//학생 조회
	function fn_resumeStudentList(pagenum){
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeresumeStudent,
				lectureno : divResumeStudent.lectureno,
				lectureNameSearch : resumemange.lectureNameSearch
		}
		
		var listcallback = function(returndata){
			console.log("returndata : " + JSON.stringify(returndata));
			
			divResumeStudent.listitem = returndata.resumeLectureSelect
			divResumeStudent.totalcnt = returndata.totalcnt
			
			var paginationHtml = getPaginationHtml(pagenum, divResumeStudent.totalcnt, pageSizeresumeStudent, pageBlockSizeresumeStudent, 'fn_resumeStudentList');
			
			divResumeStudent.pagenavi = paginationHtml;
			
		}
		
		callAjax("/adm/resumeLectureSelectVue.do", "post" , "json", "true", param, listcallback);
	}
	
	//파일 다운로드
	function fn_resumeDownload(loginID){
		divResumeStudent.loginID=loginID;
		
		var loginID = divResumeStudent.loginID;
	    
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

						<p class="conTitle" id="resumemange">
							<span>이력서 관리</span> <span class="fr">
							
								강의명
		     	                <input type="text" style="width: 300px; height: 25px;" id="lectureNameSearch" name="lectureNameSearch" v-model="lectureNameSearch">                    
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="divResumeLecture">
							
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
								<tbody v-for="(item, index) in listitem">
									<tr>
										<td>{{item.lecture_no}}</td>
										<td><a href="" @click.prevent="resumeStudentList(item.lecture_no)">{{item.lecture_name}}</a></td>
										<td>{{item.name}}</td>
										<td>{{item.lecture_person}}</td>
										<td>{{item.lecture_start}}</td>
										<td>{{item.lecture_end}}</td>
									</tr>
								</tbody>
							</table>
	
						<div class="paging_area"  id="resumeLecturePagination" v-html="pagenavi"> </div>
						</div>
						
						<br/>
						<br/>
						
						<div id="divResumeStudent" v-show="show">
							
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
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=5> 조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{item.loginID}}</td>
											<td>{{item.name}}</td>
											<td>{{item.user_hp}}</td>
											<td>{{item.user_email}}</td>
											<td v-if="item.resume_file != null"><a href="" @click.prevent="fn_resumeDownload(item.loginID)">[다운로드]</td>
											<td v-else></td>
										</tr>
									</t-body>
								</template>
							</table>
						
	
						<div class="paging_area"  id="resumeStudentPagination" v-html="pagenavi"> </div>
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