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

	
	// 강의검색영역
	var lecSearchArea;
	// 강의목록영역
	var divLectureList;
	// 학생검색+목록영역
	var divStudentList;
	// 학생상세조회
	var layer1;
	
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		lectureList();
		
	});
	
	function init(){
		
		lecSearchArea = new Vue({
									el : "#lecSearchArea",
								  data :  {
									  lname : ""
									  		
								  }
			
		});
		
		divLectureList = new Vue({
									el : "#divLectureList",
								  data : {
									  listitem : [],
									  totalcnt : 0,
									  cpage : 0,
									  pagesize : 5,
									  blocksize : 10,
									  pagenavi : "",
									  
								  },
								methods : {
									fn_studentList : function(lecture_seq){
										fn_studentList(lecture_seq);
									}
								} 
			
		});
		
		divStudentList = new Vue({
									el : "#divStudentList",
								  data : {
									  listitem : [],
									  totalcnt : 0,
									  cpage : 0,
									  pagesize : 5,
									  blocksize : 10,
									  pagenavi : "",
									  stuList : false,
									  lecSeq : 0,
									  sname : "",
								  },
								methods : {
									fn_studentSelect : function(loginID,lecSeq){
										fn_studentSelect(loginID,lecSeq);
									}
									
								}
						
						});
		
		layer1 = new Vue({
							el : "#layer1",
						  data : {
							  loginID : "",
							  regdate : "",
							  name : "",
							  birthday : "",
							  email : "",
							  address : "",
							  stLecNo : 0,
							  stLecName : "",
							  stLecDate : "",
							  stLecSta : "",
						  }
		});
		
		
	}
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchLecture':
					lectureList();
					break;
				case 'btnSearchStudent':
					studentList();
					break;
				case 'btnCancelLecture':
					cancelLecture();
					break;
				case 'btnCloseModal' :
					gfCloseModal();
					break;
			}
		});
	}
	
	// 강의 목록 조회
	function lectureList(pageNum){
		
		
		divStudentList.stuList = false;
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : divLectureList.pagesize,
				lname : lecSearchArea.lname
		}
		
		var lectureListCallBack = function(lecData){
			
			divLectureList.cpage = pageNum;
			
			console.log("lectureListCallBack : " + JSON.stringify(lecData));
			
			divLectureList.listitem = lecData.lectureList;
			divLectureList.totalcnt = lecData.totalCnt;
			
						
			var paginationHtml = getPaginationHtml(pageNum, divLectureList.totalcnt, divLectureList.pagesize, divLectureList.blocksize, 'lectureList');
			divLectureList.pagenavi = paginationHtml; 
			
			
		}
		callAjax("/adm/vuelectureList.do", "post", "json", "false", param, lectureListCallBack)
	}
	
	// 학생 목록 들어가기전 백업
	function fn_studentList(lecSeq){
		
		console.log("fn_studentList lecSeq :  " + lecSeq);
		
		divStudentList.lecSeq = lecSeq;
		
		studentList();
	}
	
	// 학생 목록 조회
	function studentList(pageNum){
		
		divStudentList.stuList = true;
		
		console.log("fn_studentList lecSeq :  " + divStudentList.lecSeq);
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : divStudentList.pagesize,
				lecSeq : divStudentList.lecSeq,
				sname : divStudentList.sname
		}
		console.log("fn_studentList param lecSeq :  " + divStudentList.lecSeq);
		var studentListCallBack = function(stuData){
			
			console.log("studentListCallBack : " +   JSON.stringify(stuData));
			
						
			divStudentList.cpage = pageNum;
			
			divStudentList.listitem = stuData.studentList;
			divStudentList.totalcnt = stuData.totalCnt;
			
			var paginationHtml = getPaginationHtml(pageNum, divStudentList.totalcnt, divStudentList.pagesize, divStudentList.blocksize, 'studentList');
			
			divStudentList.pagenavi = paginationHtml; 
		}
		callAjax("/adm/vuestudentList.do", "post", "json", "false", param, studentListCallBack);
	}
	
	 // 학생 상세조회 전 백업
	function fn_studentSelect(loginID,lecSeq){
		
		console.log("fn_studentSelect loginID : " + loginID);
		console.log("fn_studentSelect lecSeq : " + lecSeq);
		
		divStudentList.loginID = loginID;
		divStudentList.lecSeq = lecSeq;
		
		studentSelect();
	}
	
	// 학생 상세조회
	function studentSelect(){
		
		var param = {
				loginID : divStudentList.loginID,
				lecSeq : divStudentList.lecSeq,
		}
		
		var studentSelectCallback = function(stuSelData){
			
			console.log("stuSelData : " + JSON.stringify(stuSelData));
			
			fn_initModal(stuSelData.studentSelect);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/adm/studentSelect.do", "post", "json", "false", param, studentSelectCallback);
		
	} 
	
	// 모달창에 데이터 넣기
	function fn_initModal(studentSelect) {
		
		layer1.loginID = studentSelect.loginID;
		layer1.regdate = studentSelect.regdate;
		layer1.name = studentSelect.name;
		layer1.birthday = studentSelect.birthday;
		layer1.email = studentSelect.email;
		layer1.address = studentSelect.address;
		
		layer1.stLecNo = studentSelect.lecture_no;
		layer1.stLecName = studentSelect.lecture_name;
		layer1.stLecDate = studentSelect.lecture_start + ' ~ ' + studentSelect.lecture_end;
		layer1.stLecSta = studentSelect.student_lecture;
	}
	
	// 학생 수강 취소
    function cancelLecture() {
      console.log('들어왔다');

      console.log(layer1.loginID);
     

      var param = {
				loginID : layer1.loginID,
				lec_seq : divStudentList.lecSeq,
		}
      console.log(param);
		var cancelLectureCallBack = function(){
			
			studentList();
			
			gfCloseModal();
		}
		callAjax("/adm/studentCancel.do", "post", "json", "false", param, cancelLectureCallBack);
	}

	
	
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="blecNo" id="blecNo" value="">
	<input type="hidden" name="bloginID" id="bloginID" value="">
	
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
								class="btn_nav bold">인원관리</span> <span class="btn_nav bold">학생 관리</span> 
								<a href="../adm/student.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="lecSearchArea">
							<span>학생 관리</span> <span class="fr"> 
								강 의 명	
		     	                <input type="text" style="width: 200px; height: 25px;" id="lname" name="lname" v-model="lname">                    
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="divLectureList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="45%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의 번호</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의 기간</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=5>데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr @click="fn_studentList(item.lecture_seq)">
											<td>{{item.num}}</td>
											<td>{{item.lecture_no}}</td>
											<td >{{item.lecture_name}}</td>
											<td>{{item.name}}</td>
											<td>{{item.lecture_start}} ~ {{item.lecture_end}}</td>
										</tr>
									</tbody>
								</template>
								
							</table>
							<div class="paging_area"  id="lectureListPagination" v-html="pagenavi"> </div>
						</div>
	
						
						
						<br><br><br><br><br><br>
					
					<div id="divStudentList" v-show="stuList">
						
						<p class="conTitle" >
							<span>학생 목록</span> <span class="fr"> 
								학 생 명	
		     	                <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname" v-model="sname">                    
			                    <a href="" class="btnType blue" id="btnSearchStudent" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명(ID)</th>
										<th scope="col">수강강의</th>
										<th scope="col">휴대전화</th>
										<th scope="col">가입일자</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=5>데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr @click="fn_studentSelect(item.loginID,lecSeq)">
											<td>{{item.name}}({{item.loginID}})</td>
											<td>{{item.lecture_name}}</td>
											<td>{{item.hp}}</td>
											<td>{{item.regdate}}</td>
											<td></td>
										</tr>
									</tbody>
								</template>
								
							</table>
	
						<div class="paging_area"  id="studentListPagination" v-html="pagenavi"> </div>
					</div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학생 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="120px">
						<col width="120px">
						<col width="120px">
						<col width="*">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">ID</th>
							<td><div id="loginID" v-html="loginID"></div></td>
							<th scope="row">가입일자</th>
							<td><div id="regdate" v-html="regdate"></div></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><div id="name" v-html="name"></div></td>
							<th scope="row">생년월일 </th>
							<td><div id="birthday" v-html="birthday"></div></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan="4"><div id="email" v-html="email"></div></td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="4"><div id="address" v-html="address"></div></td>
						</tr>
					</tbody>
				</table>
				
				<br><br><br>
				
				<div id="">
						<p class="conTitle">
							<span>수강 내역</span> 
						</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="45%">
									<col width="10%">
									<col width="15%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">기간</th>
										<th scope="col">상태</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><div id="stLecNo" v-html="stLecNo"></div></td>
										<td><div id="stLecName" v-html="stLecName"></div></td>
										<td>
											<div id="stLecDate" v-html="stLecDate"></div>
										</td>
										<td><div id="stLecSta" v-html="stLecSta"></div></td>
										
									<template v-if="stLecSta == 'Y'">
										<td><a href="" class="btnType blue" id="btnCancelLecture" name="btn"><span>수강취소</span></a></td>
									</template>
									<template v-else="stLecSta == 'N'">
										<td>취소완료</td>
									</template>
									</tr>
								</tbody>
							</table>
					</div>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseModal" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>