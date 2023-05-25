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
	var pageSizeReference = 5;
	var pageBlockSizeReference = 5;
	
	// 상세코드 페이징 설정
	var pageSizeReferenceList = 5;
	var pageBlockSizeReferenceList = 10;
	
	var studyReference;
	var Reference;
	
	/** OnLoad event */ 
	$(function() {
		
	
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();  
	
	
		init(); 
		LectureList();  //강의목록
	
	});
	
	function init(){
		
		 searchArea = new Vue({
								el : "#searchArea",
								data : {
									lecturename : "",								
								},
								methods : {
									check : function(){
										LectureList()
									}
								}
		});
		
		 studyReference = new Vue({
			 						el : "#studyReferenceList",
			 						data : {
			 							item : [],
			 							totalCnt : 0,
			 							cPage : 0,
			 							pageNav : "",
			 							lectureseq : 0,
			 						}
		 });
		
		 Reference = new Vue({
			 				 el : "#ReferenceList",
			 				 data : {
			 					 item : [],
			 					 rtotalCnt : 0,
			 					 cPage : 0,
			 					 pageNav : "",
			 					 show : false,
			 				 }
			 
		 });
		 
		 layer1 = new Vue({
							el : "#layer1",
							data : {
								lecture_seq : 0,
								reference_no : 0,
								reference_title : "",
								reference_content : "",
								reference_file : "",
							}
		 });
		 
		 
		comcombo("lecture_no", "lecturename", "all", "");
		
	}
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchreference' :
					LectureList();
					break;
				case 'btnCancel' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function LectureList(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizeReference,
				lecturename : searchArea.lecturename,
		}
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			studyReference.item=returndata.LectureList;
			studyReference.totalCnt=returndata.totalcnt;
			studyReference.cPage=pagenum;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.totalcnt, pageSizeReferenceList, pageBlockSizeReferenceList, 'LectureList');
			
			studyReference.pageNav=paginationHtml;
			
		}
		
		callAjax("/std/vueLectureList.do", "post" , "json", "false", param, listcallback);
		
		Reference.show=false;
	}
	
	function fn_referenceselect(lectureseq){
		
			studyReference.lectureseq=lectureseq; 
			fn_referenceselectlist();
		
			Reference.show=true;	
	}
	
	function fn_referenceselectlist(pagenum){
	
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizeReferenceList,
				lectureseq : studyReference.lectureseq,
		}
		
		var listcallback = function(returndata) {
			console.log("returndata0 : " + JSON.stringify(returndata));
			Reference.item=returndata.referenceselectlist;
			Reference.rtotalCnt=returndata.totalcnt;
			Reference.cPage=pagenum;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.totalcnt, pageSizeReferenceList, pageBlockSizeReferenceList, 'fn_referenceselectlist');
			
			Reference.pageNav=paginationHtml;
		}
		
		callAjax("/std/vueReferenceselectlist.do", "post" , "json", "false", param, listcallback);
	}
	
	function fn_referenceSelectForm(referenceinfo){
			
		layer1.lecture_seq = referenceinfo.lecture_seq;
		layer1.reference_no = referenceinfo.reference_no;
		layer1.reference_title = referenceinfo.reference_title;
		layer1.reference_content = referenceinfo.reference_content;
		layer1.reference_file = referenceinfo.reference_file;
		
	}
	
	
	function fn_referencedownload(referenceno){
		
		var param = {
				
				lectureseq : studyReference.lectureseq,
				referenceno : referenceno				
		}
		
		var selectcallback = function(selectresult){
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			fn_referenceSelectForm(selectresult.referenceinfo);
			
			// 모달 팝업
			gfModalPop("#layer1");
			
		}
		
		callAjax("/std/vueReferenceselect.do", "post", "json", "false", param, selectcallback);
		
	}		
			
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="referencepagenum" id="referencepagenum" value="">
	<input type="hidden" name="lectureseq" id="lectureseq" value="">
	<input type="hidden" name="slectureseq" id="slectureseq" value="">
	<input type="hidden" name="referenceno" id="referenceno" value="">
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">학습자료</span> 
								<a href="../tut/studyReference.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searchArea">
							<span>학습자료</span> <span class="fr">
								<select name="lecturename" id="lecturename" style="width: 150px;" v-model="lecturename"></select>
							    
								강의명                   
			                    <a href="" class="btnType blue" id="btnSearchreference" name="btn" @click.prevent="check()"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="lectureReferenceList" id="studyReferenceList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="45%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강의시작날짜</th>
										<th scope="col">강의종료날짜</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<template v-if="totalCnt == 0">
									<tbody>
										<tr>
											<td colspan="4">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in item">
										<tr>
											<td>{{item.lecture_name}}</td>
											<td>{{item.lecture_start}}</td>
											<td>{{item.lecture_end}}</td>
											<td><a href="" @click.prevent="fn_referenceselect(item.lecture_seq)"><span>목록</span></a></td>
										</tr>
									</tbody>
								</template>
								
								<!-- <tbody id="Reference"></tbody> -->
								
							</table>
	
						<div class="paging_area"  id="referencePagination" v-html="pageNav"> </div>
						</div>
						
						<br/>
						<br/>
						
						<div id="ReferenceList" v-show="show">
						
						<p class="conTitle">
							<span>학습자료 목록</span> <span class="fr">
							</span>
						</p>
						
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="40%">
									<col width="30%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
										<th scope="col">자료명</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								
								<template v-if="rtotalCnt == 0">
									<tbody>
										<tr>
											<td colspan="4">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for="(item,index) in item">
										<tr>
											<td>{{item.reference_title}}</td>
											<td>{{item.reference_date}}</td>
											<td>{{item.reference_file}}</td>
											<td><a href="" @click.prevent="fn_referencedownload(item.reference_no)"><span>조회</span></a></td>
										</tr>
									</tbody>
								</template>	
					
								<!-- <tbody id="tReferenceList"></tbody> -->
							</table>
	
						<div class="paging_area"  id="referenceListPagination" v-html="pageNav"> </div>
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
				<strong>학습자료 등록 / 수정</strong>
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
							<input type="hidden" class="inputTxt p100" name="lecture_seq" id="lecture_seq" v-model="lecture_seq"readonly/>
							<input type="hidden" class="inputTxt p100" name="reference_no" id="reference_no" v-model="reference_no"readonly/>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan=4><input type="text" class="inputTxt p100" name="reference_title" id="reference_title" v-model="reference_title"/></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan=4><textarea class="inputTxt p100" name="reference_content" id="reference_content" v-model="reference_content" readonly></textarea></td>
						</tr>
				
						<tr>
							<th scope="row">학습자료 </th>
							<td colspan=2><div id="fileinfo"></div></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCancel" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>