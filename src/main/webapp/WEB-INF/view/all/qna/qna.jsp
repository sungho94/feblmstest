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
	var qnapageSize = 5;
	var qnapageBlockSize = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		qnasearchlist();
		
		userinfo();

		$("#qnadcontent").hide(); //QnA 디테일 내용 숨기기
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveqan' :	
					fSaveqan();
					break;
				case 'btnDeleteqna' :
					$("#action").val("D");
					fSaveqan();
					break;
				case 'btnDeleteReply' :
					$("#action").val("D");
					fsavereply();
					break;
				case 'btnSearchqna':
					qnasearchlist();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
				case 'btnCloseqna' :
					gfCloseModal();
				$("#qnadcontent").hide();
				$("#replydata").hide();
				qnasearchlist();
					break;
				case 'replysave' :
					fsavereply();
					break;
			}
		});
	}
	
	// 로그인 정보 가져오기
	function userinfo(){
		
		var ID = '${loginID}'
		
		var param = {
				loginID : ID
		}
		
		var userinfoCallBack = function(data){
			
			$("#bloginID").val(data.userinfo.loginID);
			$("#bname").val(data.userinfo.name);
		}
		callAjax("/all/userinfo.do", "post", "json", "false", param, userinfoCallBack);
	}
	
	//QnA 목록
	function qnasearchlist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param= {
				pagenum : pagenum,
				pageSize : qnapageSize,
				qnasearch : $("#qnasearch").val()
		}
		
		console.log(param);
		var listcallback = function(qnalistdata) {
			
			$("#tbodyqnalistdata").empty().append(qnalistdata);
			
			var totalcnt = $("#totalcnt").val();
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, qnapageSize, qnapageBlockSize, 'qnasearchlist');
			$("#qnaPagination").empty().append( paginationHtml );
			
			//페이지 넘어갈 때 하단 디테일 내용 숨기기
			if(pagenum != totalcnt ){
				$("#qnadcontent").hide();
			}
		}
		callAjax("/all/qnalist.do", "post" , "text", "false", param, listcallback);
	}
	
	//디테일 들어가기 전 qna 번호 백업!
	function fn_qnalistsearch(qnano){
		$("#qnano").val(qnano);
		
		$("#qnadcontent").show();
		
		//console.log("fn_qnalistsearch qna 번호 백업 : " , qnano);
		
		qnalistsearch();
	}
	
	//qna 디테일 데이터
	function qnalistsearch(no){
		
		var param = {
				qnano : $("#qnano").val()
		}
		
		console.log("qna 디테일 데이터 param : ", param);
		
		var listcallback = function(qnalistdata) {
			
			//제목 눌렀을 때 하단 디테일 목록 보이는 곳
			qnadataillista(qnalistdata);
		}
		
		callAjax("/all/qnacontent.do", "post" , "json", "false", param, listcallback);
	}
	
	//제목을 눌렀을 때 하단에 디테일 목록이 보이게
	function qnadataillista(data) {
		console.log("qnadataillista 디테일 데이터 : ", data);
		
		$("#detail_qna_no").empty().append(data.qnainfo.qna_no);
		$("#detail_qna_title").empty().append(data.qnainfo.qna_title);
		$("#detail_name").empty().append(data.qnainfo.name);
		$("#detail_qna_date").empty().append(data.qnainfo.qna_date);
		$("#detail_qna_count").empty().append(data.qnainfo.qna_count);
		$("#detail_qna_content").empty().append(data.qnainfo.qna_content);
		
		var detail_login = data.qnainfo.loginID; //QnA detail의 loginID 저장하기.
		var nowloginID = $("#bloginID").val(); //현재 로그인한 ID 저장하기.
		
		console.log(detail_login);  //현재 글쓴이의 아이디값 가져옴.
		console.log(nowloginID);   //현재 로그인한 ID 가져옴.
		
		if(detail_login != nowloginID){ //현재 글쓴이의 아이디값과 로그인한 ID 값이 다르면 디테일버튼을 지워준다.
			$("#detail_btn").hide();
		} else {
			$("#detail_btn").show();
		}
		
		//댓글의 reply 리스트에 qna_no 값 넘겨주기.
		replysearchlist(data.qnainfo.qna_no);
		
		//수정버튼 눌렀을 때 데이터값 가져오기
		$("#qna_no").val(data.qnainfo.qna_no);
		$("#name").val(data.qnainfo.name);
		$("#qna_new_title").val(data.qnainfo.qna_title);
		$("#qna_new_date").val(data.qnainfo.qna_date);
		$("#qna_new_content").val(data.qnainfo.qna_content);
	}
	
	//수정(업데이트) 할 때.
	function fn_updateBackup(){
		var qnano =$("#qnano").val();
		
		qnanewpopup(qnano);
	}
	
	//qna 신규버튼 눌렀을 때
	function qnanewpopup(qnano){
		console.log("qnanewpopup 의 qnano : ", qnano);
		
		$("#qnadcontent").hide();
		
		if(qnano == "" || qnano == null || qnano == undefined ){
			$("#action").val("I");
			fn_qnaForm(); //폼 초기화?
			//$("#qnadcontent").hide(); //신규등록 버튼 누르면서 이전 QnA 디테일 목록을 가린다.
			gfModalPop("#layer1"); //신규등록 버튼을 눌렀을 때 layer1 모달창이 뜬다.
			
		} else {
			$("#action").val("U");
			
			fn_qnalistsearch(qnano);
			gfModalPop("#layer1");
		}
	}
	
	//신규 혹은 수정 버튼을 눌렀을 때 qnaForm 값에 따라 빈화면 혹은 데이터가진 화면 보여주기
	function fn_qnaForm(qnaForm, data){
		
		console.log(" 수정 버튼 눌렀을 때 data : ", data);
		
		console.log($("#bloginID").val());
		
		//qnaForm에 값이 없이 빈 화면이라면
 		if(qnaForm == "" || qnaForm == null || qnaForm == undefined){
 			$("#qna_no").val("");
			$("#name").val($("#bname").val());
			$("#qna_new_title").val("");
			$("#qna_new_date").val(document.getElementById('qna_new_date').value = new Date().toISOString().slice(0, 10));
			$("#qna_new_content").val("");
		} else {
			$("#qna_no").val(qnaForm.qna_no);
			$("#name").val(qnaForm.name);
			$("#qna_new_date").val(qnaForm.qna_date);
			$("#qna_new_title").val(qnaForm.qna_title);
			$("#qna_new_content").val(qnaForm.qna_content);
		}
		
	}
	
	//저장(수정완료) 버튼을 눌렀을 때
	function fSaveqan(){
		
		var param = {
			action : $("#action").val(),
			qna_no : $("#qna_no").val(),
			loginID : $("#bloginID").val(),
			name : $("#name").val(),
			qna_new_date : $("#qna_new_date").val(),
			qna_new_title : $("#qna_new_title").val(),
			qna_new_content : $("#qna_new_content").val(),
			qna_new_count : $("#qna_new_count").val()
		}
		
		console.log("저장버튼의 param : ", param);
		
		var saveCallBack = function(data){
			gfCloseModal();
			location.reload();
			replysearchlist();
		}
		callAjax("/all/qnasave.do", "post", "json", "false", param, saveCallBack);
	}
	
	//QnA 리플(댓글) 리스트  (qnano = qna 디테일 데이터 번호)
	function replysearchlist(qnano){
		
		var param = {
				qnano : qnano
		}
		
		console.log("replysearchlist 의 param", param); // qnano 가져오는거는 확인.
		
		var listcallback = function(replylistdata){
			
			//console.log("replylistdata 데이터 : ", replylistdata); //가져오는거 확인
			
			$("#tbodyreplylistdata").empty().append(replylistdata);
			
			var totalcnt = $("#totalcnt").val();
		}
		callAjax("/all/replylist.do", "post" , "text", "false", param, listcallback);
	}
	
	
	//QnA 게시글 들어간 후 답변 버튼을 눌렀을 때 나타나는 창에 qnano값, loginID 값, date 값 넣어주기.
	function btnaddreply() {
		
		var param = {
				qnano : $("#qnano").val(),
				loginID : $("#bloginID").val(),
				date : document.getElementById('reply_date').value = new Date().toISOString().slice(0, 10)
		}
		fn_replyForm(param);
	}
	
	//답변 팝업창에 qnano(qna 번호), loginID(로그인ID), date(날짜)와 입력 및 빈칸은 빈칸으로 나타내기
	function fn_replyForm(data){
		console.log("fn_replyForm의 데이터 : ",data);
		
		gfModalPop("#layer2");
		
		//팝업창과 함께 데이터 입력
		$("#reply_no").val("");
		$("#action").val("I"),
		$("#qnano").val(data.qnano),
		$("#reply_date").empty().append(document.getElementById('reply_date').value = new Date().toISOString().slice(0, 10));
		$("#loginID").val(data.loginID);
		$("#new_reply_content").empty().append("");
	}

	//댓글 가져오는 부분
	function fsavereply(){
		
		var param = {
				action : $("#action").val(),
				qna_no : $("#qnano").val(),
				reply_no : $("#reply_no").val(),
				reply_date : $("#reply_date").val(),
				loginID : $("#loginID").val(),
				reply_content : $("#reply_content").val()
		}
		
		var saveCallBack = function (data){
			gfCloseModal();
			location.reload();
			replysearchlist();
		}
		callAjax("/all/replysave.do", "post", "json", "false", param, saveCallBack);
	}
	
	//replylist 에서의 qna 번호, reply 번호, reply 아이디 값 저장
	function fn_replydelete(qnano, rplyno, rplyID){
		
		$("#qna_no").val(qnano);
		$("#reply_no").val(rplyno);
		$("#action").val("D");
		
		fsavereply();
		replysearchlist();
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="qnano" id="qnano" value=""> <!-- qna 디테일 데이터 번호 -->
	<input type="hidden" name="bloginID" id="bloginID" value=""> <!-- 현재 로그인 아이디 -->
	<input type="hidden" name="bname" id="bname" value=""> <!-- 로그인한 이름 -->
	<input type="hidden" name="brplyno" id="brplyno" value=""> <!-- reply 디테일 데이터 번호 -->
	<input type="hidden" name="baction" id="baction" value=""> <!-- reply 에 대한 action값 -->
	
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
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">QnA</span> 
								<a href="../all/qna.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>QnA</span> <span class="fr"> 
		     	                <input type="text" style="width: 300px; height: 25px;" id="qnasearch" name="qnasearch" placeholder="작성자명으로 검색">                    
			                    <a href="" class="btnType blue" id="btnSearchqna" name="btn"><span>검  색</span></a>
			                    <c:if test="${userType eq 'A'}"> <!-- userType이 학생일 때 신규등록 버튼이 보이게끔 -->
							 	   <a	class="btnType blue" href="javascript:qnanewpopup()" id="qna_updqte_data" name="modal"><span>신규등록</span></a>
							    </c:if>
							</span>
						</p>
						
						<div class="qnalist">
							
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
										<th scope="col">등록일</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="tbodyqnalistdata"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="qnaPagination"> </div>
						
						<br><br><br><br>
						
						<div id="qnadcontent">
						<p>
						<div id="detail_btn">
							<span class="fr"> 
		     	                <a href="javascript:fn_updateBackup()" class="btnType blue" id="qna_updqte_data" name="modal"><span>수정</span></a>
								<a href="" class="btnType blue" id="btnDeleteqna" name="btn"><span>삭제</span></a> 
							</span>
						</div>
						</p>
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
									<td colspan="1"><div id="detail_qna_no"></div></td>
									<th scope="row">작성자</th>
									<td colspan="2"><div id="detail_name"></div></td>
									<th scope="row">등록일</th>
									<td colspan="2"><div id="detail_qna_date"></div></td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td colspan="5"><div id="detail_qna_title"></div></td>
									<th scope="row">조회수</th>
									<td colspan="2"><div id="detail_qna_count"></div></td>
								</tr>
								<tr>
									<th scope="row">내용</th>
									<td colspan="8"><div id="detail_qna_content"></div></td>
								</tr>
							</table>
						
						<div id="replydata">
							<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="20%">
								<col width="40%">
								<col width="25%">
								<col width="15%">
							</colgroup>
								<thead>
									<tr>
										<th scope="col">댓글작성자</th>
										<th scope="col">댓글내용</th>
										<th scope="col">댓글작성일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="tbodyreplylistdata"></tbody>
							</table>
						</div>
						<div class="btn_areaC mt30">
						<c:if test="${userType ne 'A'}"> <!-- userType이 학생일 때 답변 버튼이 안보이게. -->
								<a href="javascript:btnaddreply()" class="btnType blue" id="modal" name="modal"><span>답변</span></a>
						</c:if>
								<a href=""	class="btnType gray" id="btnCloseqna" name="btn"><span>취소</span></a>
						</div>
						</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 1000px;">
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
						<col width="120px">
						<col width="*">
						
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글번호<span class="font_red">*</span></th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="qna_no" name="qna_no" readonly="readonly" placeholder="글번호입니다." /></td>
							<th scope="row">작성자<span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="name" name="name" /></div></td>
							<th scope="row">등록일</th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="qna_new_date" name="qna_new_date" readonly="readonly"></input></td>
						</tr>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="7"><input type="text" class="inputTxt p100" id="qna_new_title" name="qna_new_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td colspan="7"><input colspan="3" type="text" class="inputTxt p100" id="qna_new_content" name="qna_new_content" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveqan" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>QnA답변하기</strong>
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
							<th>댓글번호</th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="reply_no" name="reply_no" readonly="readonly"></input></td>
							<th>댓글작성일</th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="reply_date" name="reply_date" readonly="readonly"></input></td>
							<th>댓글작성자</th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="loginID" name="loginID" readonly="readonly"></input></td>
						</tr>
						<tr>
							<th>댓글내용</th>
							<td colspan="8"><input type="text" class="inputTxt p100" id="reply_content" name="reply_content"></input></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="replysave" name="btn"><span>저장</span></a>
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