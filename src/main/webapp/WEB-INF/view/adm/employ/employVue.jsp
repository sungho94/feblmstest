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

	var stuSearch;
	var employclassList;
	var studentdetailcontent;
	var stuModify;
	
	/** OnLoad event */ 
	$(function() {
		
		/* Vue 등록 */
		init();
		
		/* 초기화면 목록 */
		employclasssearchlist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	/* new Vue 모음 */
	function init(){
		
		/* 학생아이디 검색 */
		stuSearch = new Vue({
			
								el : "#empstuSearch",
								data : {
									
									empstuSearch : ""
									
								},
			
		});
		
		/* 학생 정보 등록 */
		employclassList = new Vue({
			
								el : "#employclassList",
								data : {
									
									listitem : [],
									totalcnt : 0,
									currentpage : 0,
									pagesize : 5,
									blocksize : 10,
									pagenavi : "",
									
								},
								methods : {
									
									selectstudent : function(loginID, name){
										
										console.log(loginID, name);
										
										selectstudent(loginID, name);
										
									}
									
								},
			
		});
		
		/* 하단 목록 */
		studentdetailcontent = new Vue({
			
									el : "#studentdetailcontent",
									data :{
										
										listitem : [],
										totalcnt : 0,
										stdpageSize : 5,
										delshow : false,
										blocksize : 10,
										pagenavi : "",
										
									},
									methods : {
										
										modifystudent : function(employ_no, loginID){
											
											console.log(employ_no, loginID);
											
											modifystudent(employ_no, loginID);
											
										},
										
									},
			
		});
		
		/* 하단 수정버튼 모달창 */
		stuModify = new Vue({
			
								el : "#stuModify",
								data : {
									
									upemp_no : "",
									upstdempname : "",
									upstdloginID : "",
									emp_update_join : "",
									emp_update_leave : "",
									emp_update_state : "",
									emp_update_name : "",
									action : "",
									delshow : false
									
								}
			
		});
		
	}
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				//등록 버튼
				case 'btnSaveempstudent':
					fn_saveempstudent();
					break;
				//검색 버튼
				case 'btnempstuSearch':
					employclasssearchlist();
					break;
				//삭제버튼
				case 'btnDeleteempstudent':
					stuModify.action ="D";
					fn_saveempstudent();
					break;
				//닫기 버튼
				case 'btnCloseGrpCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	//취업정보등록(상단) list 보여주는 부분
	function employclasssearchlist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : employclassList.pagesize,
				empstuSearch : stuSearch.empstuSearch
				
		}
		
		var listcallback = function(employclasslistdata){
			
			/* 현재 페이지 값 */
			employclassList.currentpage = pagenum;
			
			console.log("상단 리스트" + JSON.stringify(employclasslistdata));
			
			/* 목록, 전체 페이지 수 */
			employclassList.listitem = employclasslistdata.empclasslist;
			employclassList.totalcnt = employclasslistdata.totalcnt;
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, employclassList.totalcnt, employclassList.pagesize, employclassList.blocksize, 'employclasssearchlist');
			
			/* 페이지 네비 */
			employclassList.pagenavi = paginationHtml;
			
		}
		
		callAjax("/adm/vueempclasslist.do", "post" , "json", "false", param, listcallback);
	}
	
	/* 상단 목록에서 확인 버튼 눌렀을 때 */
	function selectstudent(stdID, name){
		
		studentdetailcontent.loginID = stdID;
		studentdetailcontent.name = name;
		
		studentdetailcontent.delshow = true;
		
		empdetailsearch();
		
	}
	
	//하단 디테일 내용 보이는 곳.
	function empdetailsearch(pagenum){
		
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : studentdetailcontent.stdpageSize,
				stdID : studentdetailcontent.loginID,
				stdname : studentdetailcontent.name
				
		}
		
		var listcallback= function(emplistdata){
			
			console.log("하단 디테일 내용" + JSON.stringify(emplistdata));
			
			studentdetailcontent.listitem = emplistdata.employdetaillist;
			studentdetailcontent.totalcnt = emplistdata.totalcnt;
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, studentdetailcontent.totalcnt, studentdetailcontent.stdpageSize, studentdetailcontent.blocksize, 'empdetailsearch');
			
			/* 페이지 네비 */
			studentdetailcontent.pagenavi = paginationHtml;
			
		}
		
		callAjax("/adm/vuedetailcontent.do", "post" , "json", "false", param, listcallback);
		
	}
	
	/* 하단 비고 수정버튼 눌렀을 때 모달창 */
	function modifystudent(employ_no, loginID){
		
		stuModify.upemp_no = employ_no;
		stuModify.upstdloginID = loginID;
		
		console.log("하단 비고 수정버튼" + stuModify.upemp_no, stuModify.upstdloginID);
		
		var param = {
				
				employ_no : employ_no,
				stdID : loginID
				
		};
		
		console.log(param);
		
		var listcallback = function(selectedreslt) {
			
			console.log("수정 삭제 모달창 : " + JSON.stringify(selectedreslt));
			
			// 수정 삭제 모달
			fn_modalpage(selectedreslt.empInfo);
			
			//모달 팝업
			gfModalPop("#stuModify");
			
		};
		
		callAjax("/adm/vuesdetailcontent.do", "post" , "json", "false", param, listcallback);
		
	}
	
	/* 모달창 수정 / 신규 폼 */
	function fn_modalpage(object){
		
		if(object == "" || object == null || object == undefined){
			
			stuModify.upemp_no = "";
			stuModify.upstdempname = studentdetailcontent.name;
			stuModify.upstdloginID = studentdetailcontent.loginID;
			stuModify.emp_update_name = "";
			stuModify.emp_update_state = "";
			stuModify.emp_update_join = "";
			stuModify.emp_update_state = "";
			stuModify.emp_update_leave = "";

			
			stuModify.action = "I";
			
			stuModify.delshow = false;
			
		} else {
			
			stuModify.upemp_no = object.employ_no;
			stuModify.upstdempname = object.name;
			stuModify.upstdloginID = object.loginID;
			stuModify.emp_update_name = object.employ_name;
			stuModify.emp_update_state = object.employ_state;
			stuModify.emp_update_join = object.employ_join;
			stuModify.emp_update_leave = object.employ_leave;
			
			stuModify.action = "U";
			
			stuModify.delshow = true;
			
		}
	}
	
	/* 신규 등록 버튼 */
	function empnewpopup(){
		
		fn_modalpage();
		
		//모달 팝업
		gfModalPop("#stuModify");
	}
	
	/* 신규 등록 입력 */
	function fn_saveempstudent(){
		
		if(!fn_Validateitem()) {
			   return;
		}
		
		if(stuModify.action == "I" || stuModify.action == "U"){
			
			if (stuModify.emp_update_state == "N" && stuModify.emp_update_leave == "") {
				
				alert("퇴사일을 지정해 주세요.");
				
				return;
				
			}
		}
		
		if(stuModify.action == "I" || stuModify.action == "U"){
			
			if (stuModify.emp_update_state == ""){
				
				alert("재직 상태를 체크해 주세요.");
				
				return;
				
			}
		}
		
		if(stuModify.action == "I" || stuModify.action == "U"){
			
			if (stuModify.emp_update_join == ""){
				
				alert("입사일을 지정해 주세요.");
				
				return;
				
			}
		}
		
		if(stuModify.action == "I" || stuModify.action == "U"){
			
			if (stuModify.emp_update_state == "Y" && stuModify.emp_update_leave == ""){
				
				stuModify.emp_update_leave = "재직중";
				
			}
		}
		
		if(stuModify.action == "I" || stuModify.action == "U"){
			
			if (stuModify.emp_update_join > stuModify.emp_update_leave){
				
				alert("퇴사일을 확인해주세요.");
				
				return;
				
			}
		}
		
		var param = {
				
				emp_no : stuModify.upemp_no,
	     	    stdID : stuModify.upstdloginID,
	     	    emp_name : stuModify.emp_update_name,
	     	    emp_state : stuModify.emp_update_state,
	     	    emp_join : stuModify.emp_update_join,
	     		emp_leave : stuModify.emp_update_leave,
	     		action : stuModify.action
				
		}
		
		console.log("신규등록 입력값 : " + JSON.stringify(param));
		
		var resultCallback = function(data) {
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 새로고침
			empdetailsearch();
			
		};
		
		callAjax("/adm/empsave.do", "post", "json", true, param, resultCallback);
		
	}
	
	function fn_Validateitem() {
		var chk = checkNotEmpty(
				[
						["emp_update_name", "업체명을 적어주세요." ]
					,	["emp_update_state", "재직여부를 선택하세요." ]
					, 	["emp_join", "입사일을 정해주세요."]
				]
		);

		if (!chk) {
			return false;
		}

		return true;
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="stdname" id="stdname" value="">
	<input type="hidden" name="stdID" id="stdID" value="">
	<input type="hidden" name="emp_no" id="emp_no" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 -->
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">취업관리</span> <span class="btn_nav bold">취업 정보</span> 
								<a href="../adm/employ.do" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle">
							<span>취업 정보 등록</span> <span class="fr"> 
		     	                <input type="text" style="width: 300px; height: 25px;" id="empstuSearch" name="empstuSearch" v-model="empstuSearch" placeholder="학생 아이디로 검색">                    
			                    <a href="" class="btnType blue" id="btnempstuSearch" name="btn"><span>검  색</span></a>
							</span>
					</p>
					
					<div id="employclassList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="15%">
									<col width="25%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명</th>
										<th scope="col">연락처</th>
										<th scope="col">아이디</th>
										<th scope="col">가입일자</th>
										<th scope="col">확인</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=5>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{ item.name }}</td>
											<td>{{ item.user_hp }}</td>
											<td>{{ item.loginID }}</td>
											<td>{{ item.user_regdate }}</td>
											<td><a href="" @click.prevent="selectstudent(item.loginID, item.name)">[확인]</a></td>
										</tr>
									</tbody>
								</template>
								
							</table>
							
							<div class="paging_area"  id="detailstudentclassPagination" v-html="pagenavi"> </div>
						</div>
						
						<br><br><br><br>
						
						<div id="studentdetailcontent" v-show="delshow">
						
						<p class="conTitle">
							<span>학생 취업 정보</span> 
							<span class="fr"> 
								<a href="javascript:empnewpopup()" class="btnType blue" id="emp_updqte_data" name="modal"><span>신규등록</span></a>
							</span>
						</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="16%">
									<col width="16%">
									<col width="8%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학번</th>
										<th scope="col">아이디</th>
										<th scope="col">학생명</th>
										<th scope="col">업체명</th>
										<th scope="col">재직여부(N/Y)</th>
										<th scope="col">입사일</th>
										<th scope="col">퇴사일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=8>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{ item.employ_no }}</td>
											<td>{{ item.loginID }}</td>
											<td>{{ item.name }}</td>
											<td>{{ item.employ_name }}</td>
											<td>{{ item.employ_state }}</td>
											<td>{{ item.employ_join }}</td>
											<td>{{ item.employ_leave }}</td>
											<td><a href="" @click.prevent="modifystudent(item.employ_no, item.loginID)">[상세보기]</a></td>
										</tr>
									</tbody>
								</template>
								
							</table>
							<div class="paging_area"  id="detailstudentclassPagination" v-html="pagenavi"> </div>
						</div>
					</div> <!--// content -->
					
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="stuModify" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>학생정보수정</strong>
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
							<th scope="col">학번</th>
							<td><input type="text" class="inputTxt p100" id="upemp_no" v-model="upemp_no" readonly /></td>
						</tr>
						<tr>
							<th scope="col">학생명</th>
							<td><input type="text" class="inputTxt p100" id="upstdempname" v-model="upstdempname" readonly /></td>
							<th scope="col">아이디</th>
							<td><input type="text" class="inputTxt p100" id="upstdloginID" v-model="upstdloginID" readonly /></td>
						</tr>
						<tr>
							<th scope="col">업체명</th>
							<td><input type="text" class="inputTxt p100" id="emp_update_name" name="emp_update_name" v-model="emp_update_name"/></td>
							<th scope="col">재직여부</th>
							<td>
							<input type="radio" id="radio1-1" name="emp_update_state" id="emp_update_state_1" v-model="emp_update_state" value="Y" /> <label for="radio1-1">Y</label>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="radio1-2" name="emp_update_state" id="emp_update_state_2" v-model="emp_update_state" value="N" /> <label for="radio1-2">N</label>
							</td>
						</tr>
						<tr>
							<th scope="col">입사일</th>
							<td><input type="date" class="inputTxt p100" id="emp_update_join" name="emp_update_join" v-model="emp_update_join"/></td>
							<th scope="col">퇴사일</th>
							<td><input type="date" class="inputTxt p100" id="emp_update_leave" name="emp_update_leave" v-model="emp_update_leave"/></td>
						</tr>
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnSaveempstudent" name="btn"><span>등록</span></a>
					<a href="" class="btnType gray" id="btnDeleteempstudent" name="btn" v-show="delshow"><span>삭제</span></a>
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>
</body>
</html>