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
	
	// 검색영역
	var searcharea; 
	// 목록영역
	var listarea;
	// 강사 목록
	var TeacherList;
	// 상세보기
	var tutInfoLayer;
	
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		// 강사목록
		TeacherList();
		
	});
	
	function init(){
		
		searcharea = new Vue({
					            el : "#searcharea",
					          data : {
					        	 search : ""
					         }   
		});
		
		listarea = new Vue({
					            el : "#listarea",
					          data : {
					        	 listitem : [],
					        	 totalcnt : 0,
					        	 cpage : 0,
					        	 pagesize : 10,
                    	     	 blocksize : 2,
                    	       	 pagenavi : "",
					        	 	
					        	 
					         },
					       methods : {
					    	   tutInfo : function(loginID){
					    		   
					    		   tutInfo(loginID);
					    		   
					    	   }
					       }
		});
		
		tutInfoLayer = new Vue({
									el : "#tutInfoLayer",
								  data : {
									  tutId : "",
									  tutName : "",
									  tutHp : "",
									  tutEmail : "",
									  tutBirthday : "",
									  tutAddress : "",
									  tutRegdate : "",
									  tutLecture : "",
								}
			
			
			
		});
		
		
	}
	

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
			pageSize : listarea.pagesize,
			search : searcharea.search
		};
		
		var teacherListCallback = function(data){
			
			listarea.cpage = pagenum;
			
			console.log("teacherListCallback : " +   JSON.stringify(data));
			
			listarea.listitem = data.teacherList;
			listarea.totalcnt = data.totalCnt;
			
			var paginationHtml = getPaginationHtml(pagenum, listarea.totalcnt, listarea.pagesize, listarea.blocksize , 'TeacherList');
			listarea.pagenavi = paginationHtml;
			
	         
		};
		
		callAjax("/adm/vueteacherlist.do", "post", "json", "false", param, teacherListCallback); 
	}
	
	
	/* 승인 & 미승인 ( 유저타입 업데이트 ) */
	function typesearch(loginid){
		listarea.loginID = loginid,
		typeUpdate();
	}
	
	function typeUpdate(){
		
		var param = {
				loginID : listarea.loginID,
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
		console.log(loginID);
		
		tutInfoLayer.loginID = loginID;
		
	    var param = {
			loginID : loginID
		}
		
		var tutInfoCallback= function(data){
			console.log("tutInfoCallback : " + JSON.stringify(data));
			
			var teacherInfo = data.teacherInfo
			
			tutInfoLayer.tutId = teacherInfo.loginID;
			tutInfoLayer.tutName = teacherInfo.name;
			tutInfoLayer.tutRegdate = teacherInfo.user_regdate;
			tutInfoLayer.tutHp = teacherInfo.user_hp;
			tutInfoLayer.tutEmail = teacherInfo.user_email;
			tutInfoLayer.tutBirthday = teacherInfo.user_birthday;
			tutInfoLayer.tutAddress = teacherInfo.user_address;
			tutInfoLayer.tutLecture = teacherInfo.lectureName;
			
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

						<p class="conTitle" id="searcharea">
							<span>강사관리</span>
							<span class="fr">
							 <select id="teacherName" name="teacherName" style="width: 150px;">
							      <option value="name">강사명(ID)</option> </select>
		     	                <input type="text" style="width: 200px; height: 25px;" id="search" name="search" v-model="search" placeholder="검색어를 입력하세요">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="listarea">
							
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
								
								<template v-if="totalcnt === 0">
									<tbody>
										 <tr>
										      <td colspan=5>조회된 데이터가 없습니다.  </td>
										 </tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for=" (item,index)  in  listitem">
									     <tr > 
										   <td @click="tutInfo(item.loginID)">{{item.name}}({{item.loginID}})</td>
										   <td>{{item.user_hp}}</td>
										   <td>{{item.user_email}}</td>
										   <td>{{item.user_regdate}}</td>
									   <template v-if="item.user_type === 'D'">
									   		<td><a class="btnType3 color1" @click="typesearch(item.loginID)"><span>미승인</span></a></td>
									   </template>
										<template v-else="item.user_type === 'B'">
											<td>승인</td>
										</template>   
										 </tr>  
									</tbody>
								</template>
								
								
							</table>
							<div class="paging_area"  id="teacherListPagination" v-html="pagenavi"> </div>
						</div>
	
						
						
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
							 <td ><div id="tutId" v-html="tutId"></div></td>
							<th scope="row"> 이름</th>
							 <td colspan="3"><div id="tutName" v-html="tutName"></div></td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><div id="tutHp" v-html="tutHp"></div></td>
							<th scope="row">이메일 </th>
							<td ><div id="tutEmail" v-html="tutEmail"></div></td>
						</tr>
						<tr>
							<th scope="row">생년월일</th>
							<td ><div id="tutBirthday" v-html="tutBirthday"></div></td>
							<th scope="row">주소 </th>
							<td><div id="tutAddress" v-html="tutAddress"></div></td>
						</tr>
						<tr>
						    <th scope="row"> 가입일 </th>
							 <td><div id="tutRegdate" v-html="tutRegdate"></div></td>
							<th scope="row">진행 중인 수업</th>
							 <td ><div id="tutLecture" v-html="tutLecture"></div></td>
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