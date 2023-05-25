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
	var pageSizelecture = 5;
	var pageBlockSizelecture = 10;
	// 강의계획서
	var pageSizePlan = 5;
	var pageBlockSizePlan = 10;
	
	
	/** OnLoad event */ 
	$(function() {
		
		lectureList();
		
		$("#lecturePlan").hide();
		$("#taskList").hide();
		$("#sendList").hide();
		
		selectComCombo("lecbyuser", "lecbyuserall", "all", ""); 
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveTask' :
					fn_insertTask();
					break;
				case 'btnUpdateTask' :
					fn_insertTask();
					break;
				case 'btnSearch':
					lectureList();
					break;
				case 'btnCloseTask' :
					gfCloseModal();
					break;
				case 'btnBack' :
					fn_taskSendInfo();
					break;	
			}
		});
	}
	
	/*--------- 강의 목록 ------------*/
	function lectureList(pageNum){
		
		$("#lecturePlan").hide();
		$("#taskList").hide();
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizelecture,
				lectureNo : $("#lectureNo").val(),
				lecbyuserall : $("#lecbyuserall").val()
		}
		
		var lectureListCallback = function(listdata){
			console.log("lectureListCallback" + listdata);
			$('#tbodyLectureList').empty().append(listdata);
			var totalCnt =  $("#lectureCnt").val(); 
	        var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizelecture, pageBlockSizelecture, 'lectureList');
	        $("#lecturelistPagination").empty().append( paginationHtml );
	        
		};
		
		callAjax("/tut/lecturelist.do", "post", "text", "false", param, lectureListCallback);
	}
	
	/* 강의 클릭시 계획서 리스트 뿌리기*/
	function planlistsearch(lectureNo){
		$("#lectureNo").val(lectureNo);
		planList();
	}
	
	/* 강의계획서 목록 */
	function planList(pageNum){
		
		$("#lecturePlan").show();
		$("#taskList").hide();
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizePlan,
				lectureNo : $("#lectureNo").val(),
		}
		
		var planListCallback = function(plandata){
			
			console.log("planListCallback" + plandata);
			$('#tbodyplanList').empty().append(plandata);
			var totalCnt =  $("#plancnt").val(); 
	         var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizePlan, pageBlockSizePlan, 'planList');
	         $("#planlistPagination").empty().append( paginationHtml );
	        
	         
		};
		
		callAjax("/tut/planlist.do", "post", "text", "false", param, planListCallback);
	}
	
	/* 과제 관리 목록 */
	function tasklistsearch(planNo){
		$("#planNo").val(planNo);
		taskList();
	}
	
	
	/* 과제 관리 목록 */
	function taskList(pageNum){
		
		console.log($("#taskcnt").val());
		
		$("#taskList").show();
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizelecture,
				planNo : $("#planNo").val()
		}
		
		var taskListCallback = function(listdata){
			console.log("taskListCallback" + listdata);

			$('#tbodytaskList').empty().append(listdata);
			var totalCnt =  $("#taskcnt").val(); 

	         var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizelecture, pageBlockSizelecture, 'taskList');
	         $("#tasklistPagination").empty().append( paginationHtml );

	         if(totalCnt == 0) {
	        	$("#taskmodal").show();
	         } else {
	        	$("#taskmodal").hide();
	         }
		};
		
		callAjax("/tut/tasklist.do", "post", "text", "false", param, taskListCallback);
	}
	


	
	/* 과제 상세 조회 - 모달*/
	function fn_taskDetail(planNo){
		
		var param = {
			planNo : planNo
		};
		
		var detailCallback = function(detailresult){
			console.log("detailCallback : " + JSON.stringify(detailresult));
			
			var taskInfo = detailresult.taskInfo
			
			$("#title").val(taskInfo.taskTitle);
			$("#content").val(taskInfo.taskContent);
			$("#taskStart").val(taskInfo.taskStart);
			$("#taskEnd").val(taskInfo.taskTitle);
			$("#btnSaveTask").hide();
			fn_initForm(taskInfo);
			gfModalPop("#tasklayer1");
		}
		callAjax("/tut/taskdetail.do", "post", "json", "false", param, detailCallback);
	}
	

	/* 과제 등록 & 수정 버튼 클릭 시  */
	function fn_taskPopup(taskCode){
		
		if(taskCode == null || taskCode == "" || taskCode == undefined){
			$("#action").val("I");
			
			fn_initForm();
			
			gfModalPop("#tasklayer1");
		}else{
			$("#action").val("U");
			
			fn_taskDetail(taskCode);
			
			
		}
	}
	

	
	/* 과제 신규 등록 & 수정 폼 */
	function fn_initForm(taskInfo){
			
		    $("#iplanNo").val($("#planNo").val());
			
		    var now_utc = Date.now() // 지금 날짜를 밀리초로
			// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
			
			var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
			// new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
			var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
			var now = document.getElementById("taskStart").setAttribute("min", today);
			
			
		if(taskInfo == "" || taskInfo == null || taskInfo == undefined ){
			   $("#title").val("");
			   $("#content").val("");
			   $("#taskStart").val("");
			   $("#taskEnd").val("");
			  
			   $("#selfile").val("");
			   $("#fileinfo").empty();
			   $("#btnUpdateTask").hide();
				$("#btnSaveTask").show();
		} else {
			   $("#title").val(taskInfo.taskTitle);
			   $("#content").val(taskInfo.taskContent);
			   $("#taskStart").val(taskInfo.taskStart);
			   $("#taskEnd").val(taskInfo.taskEnd);
			   $("#selfile").val("");  
			   $("#btnUpdateTask").show();
			   
			   var readFileName = taskInfo.taskName;
			   var inserthtml = "";
			   inserthtml = "<a>" + taskInfo.taskName + "</a>"; 
			   console.log(inserthtml);
			   
			   $("#fileinfo").empty().append(taskInfo.taskName); 
			   
		}
	}

	
	/* 등록버튼 클릭시 -> 과제,파일 등록  */
	function fn_insertTask(){
		
			var action =  $("#action").val();   
			
			if(action == "I" || action == "U"){
				   if(!fn_Validateitem()){
					   return;
				   }
			 }
			

	        var frm = document.getElementById("myForm");
			frm.enctype = 'multipart/form-data';
			var dataWithFile = new FormData(frm);
			
			var insertCallback = function(data){
				console.log("insertCallback: ", JSON.stringify(data)); 
			alert("등록되었습니다.");
			
			gfCloseModal();
			//lectureList();
			taskList();	
		}
		callAjaxFileUploadSetFormData("/tut/taskinsert.do", "post", "json", true, dataWithFile, insertCallback);
		
	}
	
	
	function SendInfosearch(planNo){
		$("#planNo").val(planNo);
		fn_taskSendInfo();
	}
	
	/* 과제 제출 명단 */
	function fn_taskSendInfo(pageNum){
		$("#sendList").show();
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizelecture,
				planNo : $("#planNo").val()
		}
		
		var taskSendCallback = function(data){
			console.log("taskSendCallback : " + data);
			
			$("#tbodySendList").empty().append(data);
			var totalCnt =  $("#sendcnt").val(); 

	         var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSizelecture, pageBlockSizelecture, 'taskSendCallback');
	         $("#sendlistPagination").empty().append( paginationHtml );
	         
	         gfModalPop("#sendListLayer1");
	
		}
		callAjax("/tut/tasksendinfo.do", "post", "text", "false", param, taskSendCallback);
	}
	
	
	/* 제출 과제 상세 조회 - 모달*/
	function fn_taskSendDetail(sendNo) {

		var param = {
			sendNo : sendNo
		};
		
		var sendDetailCallback = function(data){
			console.log("sendDetailCallback : " + JSON.stringify(data));
			
			var taskInfo = data.taskSendInfo
			
			$("#sendNo").val(taskInfo.sendNo);
			$("#studentName").empty().append(taskInfo.stdName);
			$("#sendDate").empty().append(taskInfo.sendDate);
			$("#sendTitle").empty().append(taskInfo.sendTitle);
			$("#sendContent").empty().append(taskInfo.sendContent);
			
			var readFileName = taskInfo.sendFile;
			var inserthtml = "";
			var notFile = "파일없음";
			
			if(readFileName == null || readFileName == "" || readFileName == undefined ){
				inserthtml = "<a >" + notFile + "</a>"; 
			} else{
			    inserthtml = "<a href='javascript:fn_fileDounload()'>" + taskInfo.sendFile + "</a>"; 
			}
			
			$("#fileInfo").empty().append(inserthtml); 
			
			gfModalPop("#sendDetailLayer");

		}
		callAjax("/tut/taskSendDetail.do", "post", "json", "false", param, sendDetailCallback);
	}
	
	
	/*다운로드*/
	function fn_fileDounload(){
		
		var sendNo = $("#sendNo").val();
		
		alert(sendNo)
		
		if(sendNo == null){
			return;
		}
		
		var params = "<input type='hidden' name='sendNo' value='" + sendNo +"'/>";
		
		jQuery(
				"<form action='/tut/taskSendFile.do' method='post'>"
				+ params + "</form>").appendTo('body').submit().remove();
		
	}
	
	function fn_Validateitem() {

		var chk = checkNotEmpty(
				[
						[ "taskStart", "제출일을 설정해주세요" ]
					,	[ "taskEnd", "마감일을 설정해주세요" ]
					,	[ "title", "제목을 입력하세요" ]
					,	[ "content", "내용을 입력하세요" ]
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
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lectureNo" id="lectureNo" value="">
	<input type="hidden" name="planNo" id="planNo" value="">
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">과제 관리</span> 
								<a href="../tut/task.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수업 정보</span> <span class="fr"> 
							   <select id="lecbyuserall" name="lecbyuserall" style="width: 150px;">
							    </select>                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="7%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">강의실</th>
										<th scope="col">수강인원</th>
									</tr>
								</thead>
								<tbody id="tbodyLectureList"></tbody>
							</table>
							<div class="paging_area"  id="lecturelistPagination"> </div>
						</div>
						<br>
						<br>
						<div id="lecturePlan">
							<p class="conTitle">
								<span>강의 계획서</span> <span class="fr"> 
								</span>
							</p>
						
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="13%">
									<col width="30%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">주차</th>
										<th scope="col">학습목표</th>
									</tr>
								</thead>
								<tbody id="tbodyplanList"></tbody>
							</table>
							<div class="paging_area"  id="planlistPagination"> </div>
						</div>
						
						<br>
						<br>
						<div id="taskList">
							<p class="conTitle">
								<span>과제 관리</span> <span class="fr"> 
								    <a class="btnType blue" href="javascript:fn_taskPopup();" name="modal" id="taskmodal"><span>과제등록</span></a>
								</span>
							</p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="40%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과제이름</th>
										<th scope="col">제출일</th>
										<th scope="col">마강일</th>
										<th scope="col">제출현황</th>
									</tr>
								</thead>
								<tbody id="tbodytaskList">
								
								</tbody>
							</table>
							<div class="paging_area"  id="tasklistPagination"> </div>
						</div>
						<br>
						<br>
	
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 과제 등록 & 수정 & 조회 팝업 -->
	<div id="tasklayer1" class="layerPop layerType2" style="width: 500px;">
		<dl>
			<dt>
				<strong>과제 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<input type="hidden" class="inputTxt p100" name="iplanNo" id="iplanNo" />
						<tr>
							<th scope="row">제출일 <span class="font_red">*</span></th>
						<td><input type="date" class="inputTxt p100"
								   name="taskStart" id="taskStart" style="font-size: 15px" min/></td>
							<th scope="row">마감일 <span class="font_red">*</span></th>
						<td><input type="date" class="inputTxt p100"
								   name="taskEnd" id="taskEnd" style="font-size: 15px"  /></td>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt" name="title" id="title" /></td>
						</tr>
						<tr >
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea  name="content" id="content" style="height: 100px; resize: none;"></textarea></td>
						</tr>
					
						<tr>
							<th scope="row">파일 </th>
							<td><input type="file" class="inputTxt p100"name="selfile" id="selfile" />
							<td colspan="3"><div id="fileinfo"> </div></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveTask" name="btn"><span>등록</span></a> 
					<a href="" class="btnType blue" id="btnUpdateTask" name="btn"><span>수정</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseTask" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 과제 제출 명단 팝업-->
	<div id="sendListLayer1" class="layerPop layerType2" style="width: 800px; height: 630px;">
		<dl>
			<dt>
				<strong>제출명단</strong>
			</dt>
			<dd class="content">
				<div id="sendList">
					<p class="conTitle">
						<span>제출 목록</span> 
					</p>
					<table class="col">
						<caption>caption</caption>
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								</colgroup>
							<thead>
							<tr>
								<th scope="col">학생명</th>
								<th scope="col">과제명</th>
								<th scope="col">제출일</th>
							</tr>
							</thead>
							  <tbody id="tbodySendList">
						 </table>
					   <div class="paging_area"  id="sendlistPagination"> </div>
				 </div>
				 <div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseTask" name="btn"><span>닫기</span></a>
				 </div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!-- 제출 과제 상세 조회 팝업 -->
	<div id="sendDetailLayer" class="layerPop layerType2" style="width: 800px; height: 630px;">
		<dl>
			<dt>
				<strong>과제 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row"  style="width: 750px; height: 450px;">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<input type="hidden" class="inputTxt p100" name="sendNo" id="sendNo" />
						<tr>
							<th scope="row">학생명</th>
						<td><div id="studentName"></div></td>
							<th scope="row">제출일</th>
						<td><div id="sendDate"></div></td>
						</tr>
						<tr>
							<th scope="row">제목 </th>
							<td colspan="3"><div id="sendTitle"></div></td>
						</tr>
						<tr style=" height: 150px;">
							<th scope="row">내용</th>
							<td colspan="3"><div id="sendContent"></div></td>
						</tr>
					
						<tr>
							<th scope="row">파일 </th>
							<td colspan="3"><div id="fileInfo"> </div></td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnBack" name="btn" ><span>이전</span></a>
					<a href=""	class="btnType gray"  id="btnCloseTask" name="btn" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>