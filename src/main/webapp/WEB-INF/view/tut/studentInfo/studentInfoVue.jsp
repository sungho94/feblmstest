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

	var lectureinfo;
	var lecturelist;
	var divStudentInfo;

	// 수강정보 페이징설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5; 
	
	// 학생정보 페이징 설정
	var pageSizeStudent= 5;
	var pageBlockSizeStudent= 10;
	
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fSearchLecture();
	});
	
	
	function init() {
		lectureinfo = new Vue({
				el : "#lectureinfo",
				data : {
					lecture_no : ""
				}
		
		})
		
		lecturelist = new Vue({
			el : "#lecturelist",
			data : {
				leclistitem : [],
	     	    totalcnt : 0,
	     	    cpage :0,
	     	    pagenavi : "",
	     	    loginID : $("#loginID").val(),
	     	    pagenum : 0,
			},
			methods : {
				studentInfoList : function(lectureseq){
					studentInfoList(lectureseq);
				}
			}
		})
		
		divStudentInfo = new Vue({
			el : "#divStudentInfo",
			data : {
				stulistitem : [],
				totalcnt : 0,
	     	    cpage :0,
	     	    pagenavi : "",
	     	    studentloginID : "",
	     	    studentshow : false,
	     	    stlectureSeq : "",
	     	   
			}, methods : {
				stdLectureApproval : function(student_no, lecture_seq){
					stdLectureApproval(student_no, lecture_seq)
				},
				stdLectureDisapproval : function(student_no, lecture_seq){
					stdLectureDisapproval(student_no, lecture_seq)
				}
				
			}
		})
		
		selectComCombo("lecbyuser", "lecture_no", "all", "");
	}

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
	
	//수업정보 조회
	function fSearchLecture(pagenum){
		
		console.log("lectureno : " + lectureinfo.lecture_no);
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				loginID : lecturelist.loginID,
				lectureNameSearch : lectureinfo.lecture_no
		};
		
		var listcallback = function(returndata) {
			
			console.log("returndata.lectureInfo : " + JSON.stringify(returndata.lectureInfo) );
			
			
			lecturelist.leclistitem = returndata.lectureInfo;
			lecturelist.totalcnt = returndata.totalcnt;
			lecturelist.cpage = pagenum;
			
			var paginationHtml = getPaginationHtml(pagenum, lecturelist.totalcnt, pageSizeLecture, pageBlockSizeLecture, 'fSearchLecture');
			lecturelist.pagenavi=paginationHtml;
		};
		
		callAjax("/tut/vuelectureInfoList.do", "post" , "json", "true", param, listcallback);
		divStudentInfo.studentshow = false;
	}
	
	//수강생 명단 조회하기 위함
	function studentInfoList(lectureseq){
		
		divStudentInfo.lectureseq = lectureseq;
		fn_studentInfoSelect();
	}
	
	
	//수강생 명단 조회
	function fn_studentInfoSelect(spagenum){
		var spagenum = spagenum || 1
		divStudentInfo.cpage = spagenum;
		
		var param = {
				spagenum : spagenum,
				pageSize : pageSizeStudent,
				lecture_seq : divStudentInfo.lectureseq
		};
		
		var listcallback = function(returnmap){
			
			divStudentInfo.stulistitem = returnmap.studentInfo;
			divStudentInfo.totalcnt = returnmap.stotalcnt;
			
			var paginationHtml = getPaginationHtml(spagenum, divStudentInfo.totalcnt, pageSizeStudent, pageBlockSizeStudent, 'fn_studentInfoSelect');
			
			divStudentInfo.pagenavi = paginationHtml;
		}
		
		callAjax("/tut/vuestudentInfoList.do", "post" , "json", "false", param, listcallback);
		divStudentInfo.studentshow = true;
	}
	
	//수강 등록
	function stdLectureApproval(loginID, lectureSeq){
		divStudentInfo.studentloginID = loginID;
		divStudentInfo.stlectureSeq = lectureSeq;
		
		var param={
				loginID : loginID, 
				lecture_seq : lectureSeq 
		}
		
		var listcallback = function(returndata) {

			alert("수강으로 수정되었습니다.");
			
			fSearchLecture(lecturelist.cpage);
			fn_studentInfoSelect();
			
		};
		callAjax("/tut/studentInfoConfirmYes.do", "post" , "json", "true", param, listcallback);
		
		
	};
	
	//수강취소
	function stdLectureDisapproval(loginID , lectureSeq){
		
		divStudentInfo.stlectureSeq = lectureSeq;
		
		var param={
				loginID : loginID,
				lecture_seq : lectureSeq
				 
		}
		var listcallback = function(returndata) {
		
		alert("수강취소로 수정되었습니다.");
		
		fSearchLecture(lecturelist.cpage);
		fn_studentInfoSelect();
		
		};
		callAjax("/tut/studentInfoConfirmNo.do", "post" , "json", "true", param, listcallback);
	};
	
	/* function lecture_personExceed(){
		alert("정원초과");
		var loginID = divStudentInfo.studentloginID;
		var lecture_seq = divStudentInfo.stlectureSeq; 
		stdLectureDisapproval( loginID , lecture_seq);
		return;
	} */
		
		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="loginID" id="loginID" value="${loginId}"><!-- 로그인한 강사 -->
	<!-- <input type="hidden" name= "studentID" id="studentID" value=""> 수업 수강학생   (승인을 했는데 인원초과시 다시 승인취소에 필요) -->
	<!-- <input type="hidden" name="lecture_seq" id="lecture_seq" value=""> -->
	<!-- <input type="hidden" name="slecture_seq" id="slecture_seq" value="">승인을 했는데 인원초과시 다시 승인취소에 필요 -->
	
	
	
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

						<p class="conTitle" id="lectureinfo">
							<span>수업 정보</span> <span class="fr"> 
							   <select id="lecture_no" name="lecture_no" v-model="lecture_no"style="width: 150px;">
							    </select> 
							 
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
							    <!-- <a	class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>뒤로가기</span></a> -->
							</span>
						</p>
						
						<div id="lecturelist">
							
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
								<template v-if="totalcnt===0">
									<tbody>
										<tr>
											<td colspan=7> 조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item, index) in leclistitem">
										<tr>
											<td><a href="" @click.prevent="studentInfoList(item.lecture_seq)" >{{item.lecture_name}}</a></td>
											<td>{{item.teacher_name}}</td>
											<td>{{item.lecture_start}}</td>
											<td>{{item.lecture_end}}</td>
											<td>{{item.room_name}}</td>
											<td>{{item.lecture_person}}</td>
											<td>{{item.lecture_total}}</td>
										</tr>
										<!-- template v-if="item.lecture_person > item.lecture_total and (!(item.lecture_person and item.lecture_total) eq null)"></template> -->
									</tbody>
									<!-- <span v-if="item.lecture_person > item.lecture_total and (!(item.lecture_person and item.lecture_total) eq null)">
										<script>lecture_personExceed(); console.log("check");</script>
									</span> -->
								</template>

							</table>
						 <div class="paging_area"  id="lecturePagination" v-html="pagenavi"> </div>
						 </div>
						 
						<br>
						<br>
						<br>
						
						<!-- 수강학생 정보 -->
						<div id="divStudentInfo" v-show="studentshow">
							
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
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=8> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in stulistitem">
										<tr>
											<td>{{item.student_name}}</td>
											<td>{{item.student_no}}</td>
											<td>{{item.student_hp_no}}</td>
											<td>{{item.student_birth}}</td>
											<td>{{item.student_survey}}</td>
											<td>{{item.student_test}}</td>
											<td>{{item.student_lecture}}</td>
											<td v-if="item.student_lecture === 'N'">
												<a class="btnType blue" id="btnLectureApproval" href="" @click.prevent="stdLectureApproval(item.student_no, item.lecture_seq)" ><span>승인</span></a>
											</td>
											<td v-else>
												<a class="btnType blue" id="btnLectureDisapproval" href="" @click.prevent="stdLectureDisapproval(item.student_no, item.lecture_seq)" ><span>취소</span></a>
											</td>
										</tr>
									</tbody>
								</template>
								<%-- <tbody id="studentInfoList"></tbody> --%>

							</table>
						
	
						
						 <div class="paging_area"  id="studentPagination" v-html="pagenavi"> </div>
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