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
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lecturename", "all", "");
		
		LectureList();
		
		$("#ReferenceList").hide();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

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
				lecturename : $("#lecturename").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#Reference").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeReference, pageBlockSizeReference, 'LectureList');
			
			$("#referencePagination").empty().append(paginationHtml);
			
			$("#lectureseq").val("");
			
			$("#ReferenceList").hide();
			
		};
		
		callAjax("/std/LectureList.do", "post" , "text", "false", param, listcallback);
		
	}
	
	function fn_referenceselect(lectureseq){
		
		$("#lectureseq").val(lectureseq);
		
		fn_referenceselectlist();
		
	}
	
	function fn_referenceselectlist(pagenum){
		
		$("#ReferenceList").show();
		
		pagenum = pagenum || 1;
		
		var param = {
				
				pagenum : pagenum,
				pageSize : pageSizeReferenceList,
				lectureseq : $("#lectureseq").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#tReferenceList").empty().append(returndata);
			
			var totalcnt = $("#rtotalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeReferenceList, pageBlockSizeReferenceList, 'fn_referenceselectlist');
			
			$("#referenceListPagination").empty().append(paginationHtml);
			
			$("#referencepagenum").val(pagenum);
			
		};
		
		callAjax("/std/referenceselectlist.do", "post" , "text", "false", param, listcallback);
		
	}
	
	
	function fn_referenceSelectForm(referenceinfo){
			
			$("#lecture_seq").val($("#lectureseq").val());
			$("#reference_no").val(referenceinfo.reference_no);
			$("#reference_title").val(referenceinfo.reference_title);
			$("#reference_content").val(referenceinfo.reference_content);
			$("#reference_file").val(referenceinfo.reference_file);
			
			if(referenceinfo.reference_file == null || referenceinfo.reference_file == "" || referenceinfo.reference_file == undefined){
				
				$("#fileinfo").empty();
			
			} else {
				
				var readfilename = referenceinfo.reference_title;
			    var filearr = readfilename.split(".");
			    var inserthtml = "";
		         
			    if(filearr[1] == "jpg" || filearr[1] == "png"  || filearr[1] == "jpeg" || filearr[1] == "gif") {
					   inserthtml = "<a href='javascript:fn_download()'>" +  "<img src='" + referenceinfo.reference_non + "' style='width: 100px; height: 100px;' />" + "</a>";
			       }  else {
			    	   inserthtml = "<a href='javascript:fn_download()'>" + referenceinfo.reference_file + "</a>"; 
			       }
				    
				    $("#fileinfo").empty().append(inserthtml);

			}
			
			$("#btnDeleteReference").show();
			
		
		
	}
	
	function fn_download() {
		
		var referenceno = $("#reference_no").val();
	    
		if(referenceno == null){
			return;
		}
		var params = "<input type='hidden' name='referenceno' value='"+ referenceno +"' />";

		jQuery(
				"<form action='/std/referencedownload.do' method='post'>"
						+ params + "</form>").appendTo('body').submit().remove();
	
	}
	
	function fn_referencedownload(referenceno){
		
		var param = {
				lectureseq : $("#lectureseq").val(),
				referenceno : referenceno
		};
		
		var selectcallback = function(selectresult){
			
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			fn_referenceSelectForm(selectresult.referenceinfo);
			
			// 모달 팝업
			gfModalPop("#layer1");
			
		}
		
		callAjax("/std/referenceselect.do", "post", "json", "false", param, selectcallback);
		
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

						<p class="conTitle">
							<span>학습자료</span> <span class="fr">
								<select name="lecturename" id="lecturename" style="width: 150px;"></select>
							    
								강의명                   
			                    <a href="" class="btnType blue" id="btnSearchreference" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="lectureReferenceList">
							
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
								<tbody id="Reference"></tbody>
							</table>
	
						<div class="paging_area"  id="referencePagination"> </div>
						</div>
						
						<br/>
						<br/>
						
						<div id="ReferenceList">
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
								<tbody id="tReferenceList"></tbody>
							</table>
	
						<div class="paging_area"  id="referenceListPagination"> </div>
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
							<input type="hidden" class="inputTxt p100" name="lecture_seq" id="lecture_seq" readonly/>
							<input type="hidden" class="inputTxt p100" name="reference_no" id="reference_no" readonly/>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan=4><input type="text" class="inputTxt p100" name="reference_title" id="reference_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan=4><textarea class="inputTxt p100" name="reference_content" id="reference_content" readonly></textarea></td>
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