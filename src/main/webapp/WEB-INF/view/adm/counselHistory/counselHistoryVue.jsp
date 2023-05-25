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
	
	var lecture;
	var counsel;
	
	/** OnLoad event */ 
	$(function() {
		
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();   
		
		init(); 
		lectureList();  //강의목록
	
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
		
	function init(){
		
		searchArea = new Vue ({
								el : "#searchArea",
								data : {
									lectureNo : "",
								},
								methods : {
									check : function(){
										lectureList()
									}
								}
		});
		
		lecture = new Vue ({
							el : "#lectureList",
							data : {
								item : [],
								lectureCnt : 0,
								cPage : 0,
								pageNav : "",
								lectureNo : "",
								lectureSeq : 0,
							}
		});
		
		counsel = new Vue ({
								el : "#counselList",
								data : {
									item : [],
									counselCnt : 0,
									cPage : 0,
									pageNav : "",
									show : false,
								}
			
		});
		
		comcombo("lecture_no", "lectureNo", "all", "");
		
	}
		
	
	/* 강의 목록 */	
	function lectureList(pageNum){
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				lectureNo : searchArea.lectureNo,

		}
		
		var lectureListCallback = function(data){
			console.log(" lectureList : " + JSON.stringify(data));
			lecture.item=data.counselLectureList;
			lecture.lectureCnt=data.totalCnt;
			
			lecture.cPage=pageNum;
			
	         var paginationHtml = getPaginationHtml(pageNum, data.totalCnt, pageSize, pageBlockSize, 'lectureList');
				    
	         console.log(" paginationHtml : "+paginationHtml);
	         
	         lecture.pageNav=paginationHtml;
	        
		}
		
		callAjax("/adm/vueLecturelist.do", "post", "json", "false", param, lectureListCallback); 

		counsel.show=false;
	}


	/* 상담 목록 */
	function fn_counsel(lectureSeq){
	
		lecture.lectureSeq=lectureSeq;
		counselList();
		
		counsel.show=true;
	}
	
	function counselList (pageNum){
	
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				lectureSeq : lecture.lectureSeq
		} 
		
		var counselListCallback = function(data){
			console.log("counselList0 : " + JSON.stringify(data));
			counsel.item=data.counselList;
			counsel.counselCnt=data.totalCnt;
			counsel.cPage=pageNum;
			
			var paginationHtml = getPaginationHtml(pageNum, data.totalCnt, pageSize, pageBlockSize, 'counselList');
			
			
			counsel.pageNav=paginationHtml;
			
		}
		callAjax("/adm/vueCounselList.do", "post", "json", "false", param, counselListCallback);
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

						<p class="conTitle" id="searchArea">
							<span>강의 목록</span> <span class="fr"> 
							   <select id="lectureNo" name="lectureNo" style="width: 150px;" v-model="lectureNo"></select>                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn" @click.prevent="check()"><span>검  색</span></a>
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
									<template v-if="lectureCnt == 0">
										<tbody>
											<tr>
												<td colspan="7">데이터가 없습니다.</td>
											</tr>
										</tbody>
									</template>
									<template v-else>
										<tbody v-for="(item,index) in item">
											<tr>
												<td>{{item.lectureSeq}}</td>
												<td>{{item.lectureName}}</td>
												<td>{{item.lectureStart}} ~ {{item.lectureEnd}}</td>
												<td> 
													<a class="btnType3 color1" href="" @click.prevent="fn_counsel(item.lectureSeq);"><span>조회</span></a>
												</td>												
											</tr>
										</tbody>
									</template>
								</table>
								
							<div class="paging_area"  id="lectureListPagination" v-html="pageNav"> </div>
						</div>
						<br>
						<br>
						
	                    <div id="counselList" v-show="show">
	                    
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
								  
								  <template v-if="counselCnt == 0">
									  <tbody>
									  	<tr>
											<td colspan="7">데이터가 없습니다.</td>
										</tr>	
									  </tbody>
								  </template> 
								  <template v-else>
								  	<tbody v-for="(item,index) in item">
								  		<tr>
								  			<td>{{item.lecture_name}}</td>
								  			<td>{{item.stu_name}}({{item.stu_loginID}})</td>
								  			<td>{{item.consultant_counsel}}</td>
								  			<td>{{item.consultant_date}}</td>
								  			<td>{{item.teacher_name}}</td>
								  			<td>
								  				<a class="btnType3 color1" href="" @click.prevent="fn_selectCounsel(item.consultant_no);"><span>상세조회</span></a>
								  			</td>
								  		</tr>
								  	</tbody>
								  </template>
							</table>
							
						<div class="paging_area"  id="counselListPagination" v-html="pageNav"> </div>
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