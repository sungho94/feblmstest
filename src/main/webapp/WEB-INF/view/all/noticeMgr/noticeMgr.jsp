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
	var noticepageSize = 5;
	var noticepageBlockSize = 10;
	
	/** OnLoad event notino = 공지사항no*/ 
	$(function() {
		
		noticesearachlist();
		
		$("#noticedcontent").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSavenotice' :
					fSavenotice();
					break;
				case 'btnSaveUpdatenotice' :
					fSavenotice();
					break;
				//삭제버튼
				case 'btnDeletenotice' :
					$("#action").val("D");
					fSavenotice();
					break;
				//검색버튼
				case 'btnnoticeSearch':
					noticesearachlist();
					break;
				//닫기 버튼
				case 'btnCloseDtlCod' :
				case 'btnClosenotice' :
					gfCloseModal();
					$("#noticedcontent").hide();
					noticesearachlist();
					break;
			}
		});
	}
	
	//공지사항 메뉴 리스트
	function noticesearachlist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : noticepageSize,
				noticesearch : $("#noticesearch").val()
		}
		
		console.log("noticesearachlist param :", param);
		
		var listcallback = function(noticelistdata) {
			
			$("#tbodynoticelistdata").empty().append(noticelistdata);
			
			var totalcnt = $("#totalcnt").val();
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, noticepageSize, noticepageBlockSize, 'noticesearachlist');
			$("#noticelistPagination").empty().append( paginationHtml );
			
			//페이지 넘어갈 때 하단 디테일 내용 숨기기
			if(pagenum != totalcnt ){
				$("#noticedcontent").hide();
			} 
			
		};
		callAjax("/all/noticemgrlist.do", "post" , "text", "false", param, listcallback);
	}
	
	// 디테일 들어가기전 공지번호 백업
	function fn_notionlistsearch(notino){
		$("#bnotino").val(notino);
		
		$("#noticedcontent").show();
		
		console.log("fn_notionlistsearch 공지번호 백업 : " + notino);
		
		notionlistsearch();
	}
	
	//공지사항 디테일 데이터
	function notionlistsearch(no){
		
		var param = {
				notino : $("#bnotino").val()
		}
		
		console.log("공지사항 디테일 데이터 param : ", param);
		
		var listcallback = function(noticelistdata) {
			console.log(noticelistdata.noticeinfo.loginID);
			console.log('${loginId}');
			
			noticedetaillista(noticelistdata);
			
		}
		
		callAjax("/all/noticecontent.do", "post" , "json", "false", param, listcallback);
	}
	
	
	//공지사항 하단 디테일 데이터
	function noticedetaillista(data){
		console.log("하단 디테일 data : ", data );
		
		$("#detail_notice_no").empty().append(data.noticeinfo.notice_no);
		$("#detail_notice_title").empty().append(data.noticeinfo.notice_title);
		$("#detail_loginID").empty().append(data.noticeinfo.loginID);
		$("#detail_notice_date").empty().append(data.noticeinfo.notice_date);
		$("#detail_notice_count").empty().append(data.noticeinfo.notice_count);
		$("#detail_notice_content").empty().append(data.noticeinfo.notice_content);
		
		//하단 디테일 부분에 a(로그인한 아이디와) b(디테일에 작성한 아이디와 다르다면 버튼이 안보이게 하기.)
		var a = '${loginId}';
		var b = data.noticeinfo.loginID;
		if(a != b){
			$("#btn_save").hide();
		} else {
			$("#btn_save").show();
		}
		
		//수정하는 부분에서 데이터 가져오는 부분.
		$("#notice_no").val(data.noticeinfo.notice_no);
		$("#loginID").val(data.noticeinfo.loginID);
		$("#notice_new_date").val(data.noticeinfo.notice_date);
		$("#notice_new_title").val(data.noticeinfo.notice_title);
		$("#notice_new_content").val(data.noticeinfo.notice_content);
	}
	
	//업데이트 할 때  번호 백업
	function fn_updateBackup(){
		var bnotino = $("#bnotino").val();
		
		noticenewpopup(bnotino);
	}
	
	function noticenewpopup(notino){
		
		console.log("noticenewpopup", notino);
		
		if(notino == "" || notino == null || notino == undefined ){
			
			$("#action").val("I");
			//해당 팝업 초기화
			fn_noticeForm();
			gfModalPop("#layer2");
		} else {
			$("#action").val("U");
			//값이 있을 때, 수정할때 쓸거 (만들어야함)
			notionlistsearch(notino);
			
			gfModalPop("#layer2");
		}
	}
	
	//신규등록, 수정 버튼을 눌렀을 때 값 가져오는 부분.
	function fn_noticeForm(noticeForm){
		
		console.log("noticeForm",noticeForm);
		
		console.log("신규등록, 수정 에서의 id 값:" , $("#loginID").val());
		
		//신규등록(수정)을 눌렀을 때 하단디테일목록 가리기
		$("#noticedcontent").hide();
		
		//noticeForm의 값이 없으면 빈화면
		if(noticeForm == "" || noticeForm == null || noticeForm == undefined){
			$("#notice_no").val("");
			$("#notice_new_title").val("");
			$("#loginID").val("${loginId}");
			$("#notice_date").val(document.getElementById('notice_new_date').value= new Date().toISOString().slice(0, 10));
			$("#notice_new_content").val("");
			
		} else {
			$("#notice_no").val(noticeForm.notice_no);
			$("#loginID").val(noticeForm.loginID);
			$("#notice_new_date").val(noticeForm.notice_date);
			$("#notice_new_title").val(noticeForm.notice_title);
			$("#notice_new_content").val(noticeForm.notice_content);
			
		}
	}
	
	
	//저장(수정완료) 버튼을 눌렀을 때!
		function fSavenotice(){
			
			var param = {
					action : $("#action").val(),
					notice_no : $("#notice_no").val(),
					loginID : $("#loginID").val(),
					notice_new_date : $("#notice_new_date").val(),
 		    		notice_new_title : $("#notice_new_title").val(),
 		    		notice_new_content : $("#notice_new_content").val(),
 		    		notice_new_count : $("#notice_new_count").val()
			}
			
			console.log(param);
			
			var saveCallBack = function(data) {
				gfCloseModal();
				location.reload();
			}
			callAjax("/all/noticesave.do", "post", "json", "false", param, saveCallBack);

		}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="bnotino" id="bnotino" value="">
	<imput type="hidden" name="bloginID" id="bloginID" value="" >
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">공지사항</span> 
								<a href="../all/noticeMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지사항</span> <span class="fr">
							
		     	                <input type="text" style="width: 300px; height: 25px;" id="noticesearch" name="noticesearch" placeholder="작성자로 검색">                    
			                    <a href="" class="btnType blue" id="btnnoticeSearch" name="btn" ><span>검    색</span></a>
			                    <c:choose>
			                     <c:when test="${userType eq 'B'}">
			                     	<a href="javascript:noticenewpopup()" class="btnType blue" id="modal" name="modal"><span>신규등록</span></a>
			                     </c:when>
			                     <c:when test="${userType eq 'C'}">
			                     	<a href="javascript:noticenewpopup()" class="btnType blue" id="modal" name="modal"><span>신규등록</span></a>
			                     </c:when>
			                    </c:choose>
							</span>
						</p>
						
						<div class="noticelist">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">글번호</th>
										<th scope="col">글제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="tbodynoticelistdata"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="noticelistPagination"> </div>
						
						<br><br><br><br><br>
						
						<div id="noticedcontent">
							<table class="row">

							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>

								<tr>
									<th scope="row">글번호</th>
									<td colspan="1"><div id="detail_notice_no"></div></td>
									<th scope="row">작성자</th>
									<td colspan="2"><div id="detail_loginID"></div></td>
									<th scope="row">등록일</th>
									<td colspan="2"><div id="detail_notice_date"></div></td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td colspan="5"><div id="detail_notice_title"></div></td>
									<th scope="row">조회수</th>
									<td colspan="2"><div id="detail_notice_count"></div></td>
								</tr>
								<tr>
									<th scope="row">내용</th>
									<td colspan="8"><div id="detail_notice_content"></div></td>
								</tr>
							</table>

								<div class="btn_areaC mt30">
								<div id="btn_save"> <!-- 해당 userId와 작성자 userID가 같을 때 수정 & 삭제 버튼이 보이게끔 하기. -->
									<a href="javascript:fn_updateBackup()" class="btnType blue" id="modal" name="modal"><span>수정</span></a>
									<a href="" class="btnType blue" id="btnDeletenotice" name="btn"><span>삭제</span></a>
								</div>
									<a href=""	class="btnType gray" id="btnClosenotice" name="btn"><span>취소</span></a>
								</div>
						</div>

					
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<div id="layer2" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>신규등록</strong>
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
							<th scope="row">글번호<span class="font_red">*</span></th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="notice_no" name="notice_no" readonly="readonly" placeholder="글번호 입니다."/></td>
							<th scope="row">작성자<span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="loginID" name="loginID" readonly="readonly" /></div></td>
							<th scope="row">등록일</th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="notice_new_date" name="notice_new_date" readonly="readonly"></input></td>
						</tr>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="7"><input type="text" class="inputTxt p100" id="notice_new_title" name="notice_new_title" /></td>
							
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td colspan="7"><input colspan="3" type="text" class="inputTxt p100" id="notice_new_content" name="notice_new_content" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveUpdatenotice" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업 -->
	<div id="layer3" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>공지사항 수정</strong>
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
							<th scope="row">글번호</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="update_notice_no" name="update_notice_no" readonly="readonly"/></div></td>
							<th scope="row">작성자</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="update_loginID" name="update_loginID" readonly="readonly"/></div></td>
						</tr>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="5"><input type="text" class="inputTxt p100" id="update_notice_title" name="update_notice_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td colspan="5"><input colspan="3" type="text" class="inputTxt p100" id="update_notice_content" name="update_notice_content" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavenotice" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>