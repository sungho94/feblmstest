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

	// 강의 목록 페이징 설정
	//var pageSizeReference = 5;
	//var pageBlockSizeReference = 5;
	
	// 상세코드 페이징 설정
	//var pageSizeReferenceList = 5;
	//var pageBlockSizeReferenceList = 10;
	
	var lsearcharea;
	var llistarea;
	var cList;
	var layer1;
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		// 학습자료 조회(=강의목록에서 가져와서 조회)
		LectureList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function init(){
		lsearcharea = new Vue({
			el : "#lsearcharea",
			data : {
				lecturename : "",
			}
		});// lsearcharea
		
		llistarea = new Vue ({
			el : "#llistarea",
			data : {
				listitem : [], // 배열 형식으로 받아온다
				totalcnt : 0, // 총 몇개가 있는지
				cpage : 0, // 현재 페이지
				pagesize : 5, // 페이지 행 몇개씩?
				blocksize : 5, // 네비게이션으로 5개씩 나오게
				pagenavi : "", // vhtml 연결할 놈이어서 str로 초기화
			}, methods : {
				fn_referenceselect : function(lecture_seq) {
					fn_referenceselect(lecture_seq);
				}
			}
		});//llistarea
		
		cList = new Vue({
			el : "#cList",
			data : {
				listitem : [], // 배열 형식으로 받아온다
				totalcnt : 0, // 총 몇개가 있는지
				cpage : 0, // 현재 페이지
				pagesize : 5, // 페이지 행 몇개씩?
				blocksize : 10, // 네비게이션으로 5개씩 나오게
				pagenavi : "", // vhtml 연결할 놈이어서 str로 초기화
				lectureseq : 0,
				cdisflag : false,
				newreferenceno : 0,
			},
			methods : {
				fn_referencemodify : function(reference_no) {
					fn_referencemodify(reference_no);
				}
			}
			
		}); // cList
		
		comcombo("lecture_no", "lecturename", "all", "");
		
 		layer1 = new Vue({
			el : "#layer1",
			data : {
				lecture_seq : 0,
				newreferenceno : 0,
				reference_title : "",
				reference_content : "",
				reference_file : "",
				action : "",
				lectureseq : 0,
				reference_no : 0,
			},
		});
		
		
	}; //init
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchreference' :
					LectureList();
					break;
				case 'btnSaveReference' :
					fn_savereference();
					break;
				case 'btnDeleteReference' :
					$("#action").val("D");
					fn_savereference();
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	/* 강의목록 조회_학습자료 조회됨 */
	
	function LectureList(pagenum){
		pagenum = pagenum || 1;
		
		// 전해줄 param
		var param = {
				pagenum : pagenum,
				pageSize : llistarea.pagesize,
				lecturename : lsearcharea.lecturename
		};
		
		// callback 함수
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			
			llistarea.listitem = returndata.LectureList;
			llistarea.totalcnt = returndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(pagenum, llistarea.totalcnt, llistarea.pagesize, llistarea.blocksize, 'LectureList');
			
			llistarea.pagenavi = paginationHtml;	
			
			//fn_referenceselectlist();
			
		}; 
		
		// ** Ajax ** 
		//callAjax("","","","",,);형태로 사용, commonAjax.js, Ajax참고용
		callAjax("/tut/vueLectureList.do","post","json","true",param,listcallback);
		
		
	}; // LectureList,강의 목록 조회 
	
	/* 목록 눌러서 학습자료 목록 조회 */
	function fn_referenceselect(lectureseq) {
		
		cList.cdisflag = true;
		
		cList.lectureseq = lectureseq;
		
		fn_referenceselectlist();
	}; // fn_referenceselect	
	
	/* 학습자료 목록 조회 */
	function fn_referenceselectlist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : cList.pagesize,
				lectureseq : cList.lectureseq
		};
		
		pagenum = pagenum || 1;
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			// retrundata를 json형태로 console창에 출력해서 확인한다.
			
 			cList.listitem = returndata.referenceselectlist;
			cList.totalcnt = returndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(pagenum, cList.totalcnt, cList.pagesize, cList.blocksize, 'fn_referenceselectlist');
			
			cList.pagenavi = paginationHtml;	
			
		};
		
		callAjax("/tut/vuereferenceselectlist.do","post","json","true",param,listcallback);
		
		
	}; //fn_referenceselectlist
	
	/* 학습자료 등록, 수정 모달창 */
	function fn_referencedownload (referenceno){
		/* alert("referenceno : "+referenceno);
		if(referenceno == null || referenceno == "" || referenceno == undefined){
		
			var lectureseq = cList.lectureseq;
		
			if(lectureseq == null || lectureseq == "" || lectureseq == undefined){
			
				alert("강의를 먼저 선택해 주세요.");
				return;
			
			}
			
		alert("asdfff"); */
		
			// 폼 초기화
			fn_referenceSelectForm();
		
			// 모달 팝업
			gfModalPop("#layer1");
		
		/* } else {
			
			
			fn_referencemodify(referenceno);
			
		} */
		
	}; // fn_referencedownload
	
	/* 학습자료 모달창 초기화 폼 */
	function fn_referenceSelectForm(referenceinfo) {
		console.log("referenceinfo : " + JSON.stringify(referenceinfo));
		if(referenceinfo == "" || referenceinfo == null || referenceinfo == undefined){
			layer1.action = "I";
			
			layer1.lectureseq = cList.lectureseq;
			layer1.newreferenceno = "";
			layer1.reference_title = "";
			layer1.reference_content = "";
			layer1.reference_file = "";
			
		}else{
			layer1.action = "U";
			
			
 			layer1.lecture_seq = referenceinfo.lectureseq;
			layer1.reference_no = referenceinfo.reference_no;
			layer1.reference_title = referenceinfo.reference_title;
			layer1.reference_content = referenceinfo.reference_content;
			layer1.reference_file = referenceinfo.reference_file;
			
			if(referenceinfo.reference_file == null || referenceinfo.reference_file == "" || referenceinfo.reference_file == undefined){
				
				$("#fileinfo").empty();
			
			} else {
				
				var readfilename = referenceinfo.reference_file;
			    var filearr = readfilename.split(".");
			    var inserthtml = "";
			         
			   inserthtml = "<a href='javascript:fn_download()'>" + referenceinfo.reference_file + "</a>";
			    
			    $("#fileinfo").empty().append(inserthtml);

			}
			
			$("#btnDeleteReference").show();
			
		}
		
	}; //fn_referenceSelectForm();
	
	/* 학습자료 다운로드 */
	function fn_download() {
		
		var referenceno = $("#reference_no").val();
	    
		if(referenceno == null){
			return;
		}
		var params = "<input type='hidden' name='referenceno' value='"+ referenceno +"' />";

		jQuery(
				"<form action='/tut/referencedownload.do' method='post'>"
						+ params + "</form>").appendTo('body').submit().remove();
	
	}
	
	/* 학습자료 목록 detail */
	function fn_referencemodify(referenceno){
		
		//layer1.newreferenceno = referenceno;
		
		var param = {
				referenceno : referenceno
		};
		
		var selectcallback = function(selectresult){
			
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			fn_referenceSelectForm(selectresult.referenceinfo);
			
			// 모달 팝업
			gfModalPop("#layer1");
			
		}
		
		callAjax("/tut/referenceselect.do", "post", "json", "true", param, selectcallback);
		
		
	}; // fn_referencemodify, 학습자료 목록 detail
	
	/* 저장버튼 클릭시 등록,수정 */
	function fn_savereference(){
		
		  if(!fn_Validateitem()){
			return;
		  }
		
	      var frm = document.getElementById("myForm");
	      
	      frm.enctype = 'multipart/form-data';
	      
	      var dataWithFile = new FormData(frm);
	      
	      var saveempdvcallback = function(savereturn){
	    	  
	         console.log("saveempdvcallback: ", JSON.stringify(savereturn)); 
	         
	         alert("저장 되었습니다.");
	         
	         gfCloseModal();
	         
	         fn_referenceselectlist();
	         //fn_referenceselect(
	         
	         
	      }
	      
	      callAjaxFileUploadSetFormData("/tut/savereference.do", "post", "json", true, dataWithFile, saveempdvcallback);
	      
	}
	
	/** 그룹코드 저장 validation */
	function fn_Validateitem() {

		var chk = checkNotEmpty(
				[
						[ "reference_title", "제목을 입력해주세요." ]
					,	[ "reference_content", "내용을 입력해주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
	<input type="hidden" name="referencepagenum" id="referencepagenum" value="">
	<!-- <input type="hidden" name="lectureseq" id="lectureseq" value=""> -->
	<input type="hidden" name="slectureseq" id="slectureseq" value="">
	
	
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

						<p class="conTitle" id="lsearcharea">
							<span>학습자료</span> <span class="fr">
								<select name="lecturename" id="lecturename" v-model="lecturename" style="width: 150px;"></select>
							    
								강의명                   
			                    <a href="" class="btnType blue" id="btnSearchreference" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div id="llistarea">
							
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
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=4> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for=" (item, index) in listitem">
										<tr>
											<td>{{ item.lecture_name }}</td>
											<td>{{ item.lecture_start }}</td>
											<td>{{ item.lecture_end }}</td>
											<td>
												<a href="" @click.prevent="fn_referenceselect(item.lecture_seq)">
													<span>목록</span>
												</a>
											</td>
										</tr>
									</tbody>
								</template>

							</table>
						<div class="paging_area"  id="referencePagination" v-html="pagenavi"> </div>
						</div>
	
						
						<br/>
						<br/>
						
						
						<div id="cList" v-show="cdisflag">
						
						<p class="conTitle">
							<span>학습자료 목록</span> <span class="fr">

							    <a href=""	class="btnType blue" @click.prevent="fn_referencedownload(newreferenceno)" name="modal"><span>자료등록</span></a>
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
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=4> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for=" (item, index) in listitem">
										<tr>
											<td>{{ item.reference_title }}</td>
											<td>{{ item.reference_date }}</td>
											<td>{{ item.reference_file }}</td>
											<td>
												<a href="" @click.prevent="fn_referencemodify(item.reference_no)">
													<span>수정 / 삭제</span>
												</a>
											</td>
										</tr>
									</tbody>
								</template>
							</table>
						<div class="paging_area"  id="referenceListPagination" v-html="pagenavi"> </div>
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
	<input type="hidden" name="action" id="action" v-model="action">
	<input type="hidden" name="reference_no" id="reference_no" v-model="reference_no">
	<input type="hidden" name="lectureseq" id="lectureseq" v-model="lectureseq">
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
							<input type="hidden" class="inputTxt p100" name="lecture_seq" id="lecture_seq" v-model="lecture_seq" readonly/>
							<input type="hidden" class="inputTxt p100" name="newreferenceno" id="newreferenceno" v-model="newreferenceno" readonly/>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan=4><input type="text" class="inputTxt p100" name="reference_title" id="reference_title" v-model="reference_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan=4><textarea class="inputTxt p100" name="reference_content" id="reference_content" v-model="reference_content" ></textarea></td>
						</tr>
				
						<tr>
							<th scope="row">학습자료 </th>
							<td><input type="file" class="inputTxt p100" name="reference_file" id="reference_file" v-model="reference_file" /></td>
							<td colspan=2><div id="fileinfo"></div></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveReference" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteReference" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>