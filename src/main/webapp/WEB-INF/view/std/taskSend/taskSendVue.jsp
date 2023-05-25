<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>뷰 과제제출</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	//  페이징 설정
	var pageSize= 5;
	var pageBlockSize= 5;

	//TODO
	/** 변수 추가 설정, 각 변수는 주석처리하여 정의함 */
	var lectureHeaderArea;
	var lectureListArea;
	var sendListArea;
	var taskContentLayer;
	var taskSendLayer;
	var findId;
	
	
	/** OnLoad event */ 
	$(function() {
		
		selectComCombo("lecbyuser", "lecbyuserall", "all", "");
		init();
		showLectureList();
		
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
					functionSaveTask();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSearch' :
					searchTasks();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnUpdateTask':
					functionSaveTask();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}

	function init(){
		findId = new Vue({
			el: "#findId",
			data :{
				loginId : "${loginId}",
			}
		});

		lectureHeaderArea = new Vue({
			el: "#lectureHeaderArea",
			data : {
				search : "",
			}
		});

		lectureListArea = new Vue({
			el: "#lectureListArea",
			data : {
				lectureItem : [],
				totalCnt : 0,
				currentPage : 0,
				pageSize : 5,
				blockSize : 1,
				pageNav : "",
				loginId : "",
				lectureSeq : "",
				lectureName : "",
				planWeek : "",
			},
			method : {
				searchTasks : function (lectureSeq, lectureName){
					searchTasks(lectureSeq,lectureName);
				}
			}
		});

		sendListArea  = new Vue({
			el : "#sendListArea",
			data : {
				taskItem : [],
				totalCnt : 0,
				currentPage : 0,
				pageSize : 5,
				blockSize: 5,
				planNo : 0,
				pageNav : "",
				//sendList에서 저장함
				planWeek : "",
			}
		});
		//과제내용
		taskContentLayer= new Vue({
			el :"#taskContentLayer",
			data : {
				lectureName : "",
				taskWeek : "",
				taskStart : "",
				taskEnd  : "",
				taskTitle : "",
				taskContent : "",
				fileInfo : "",
				planWeek :"",
			}
		});
		//과제 제출
		taskSendLayer = new Vue({
			el : "#taskSendLayer",
			data : {
				planNo : "",
				studentLecture : "",
				studentPlanWeek : "",
				sendTitle : "",
				sendContent : "",
				sendFileName : "",
				taskNo : "",
				action : "",
				insert : false,
				update : false,
			}
		});

	}

	//과제제출 폼 안에 데이터 넣기
	function taskSendform(taskSendInfo){

		var lectureName = taskContentLayer.lectureName;
		taskSendLayer.studentLecture = lectureName;

		if(taskSendInfo == null || taskSendInfo == "" || taskSendInfo == undefined){
			$("#action").val("I");
			$("#taskNo").val(taskSendLayer.taskNo);
			$("#planNo").val(sendListArea.planNo);
			console.log(taskSendLayer.taskNo);
			console.log(sendListArea.planNo);

			taskSendLayer.action = "I";
			taskSendLayer.planNo = "";
			taskSendLayer.taskNo = "";
			taskSendLayer.sendTitle = "";
			taskSendLayer.sendContent = "";
			taskSendLayer.sendFileName = "";
		}else{
			$("#action").val("U");
			$("#taskNo").val(taskSendInfo.taskNo);
			$("#planNo").val(taskSendInfo.planNo);
			taskSendLayer.action = "U";
			taskSendLayer.planNo = taskSendInfo.planNo;
			taskSendLayer.taskNo = taskSendInfo.taskNo;
			taskSendLayer.sendTitle = taskSendInfo.sendTitle;
			taskSendLayer.sendContent = taskSendInfo.sendContent;
			taskSendLayer.sendFileName = taskSendInfo.sendFileName;

			var readFileName = taskSendInfo.sendFile;
			var inserthtml = "";
			inserthtml = "<a>" + taskSendInfo.sendFile + "</a>";
			console.log(inserthtml);


			//TODO 바꾸

			$("#fileInfo").empty().append(taskSendInfo.sendFile);
		}
	}
	//과제 제출하기
	function functionSaveTask(){
		console.log(taskSendLayer.action);
		var action = taskSendLayer.action;
		if(action == "I" || action == "U"){
			if(!checkValidation()){
				return;
			}
		}
		 // var param = {
			// planNo : sendListArea.planNo,
		 //    taskNo : taskContentLayer.taskNo,
			// loginId :findId.loginId,
			// sendTitle :taskSendLayer.sendTitle,
			// sendContent : taskSendLayer.sendContent,
		 //    action : action,
		 // }


		var frm = document.getElementById("myForm");
		frm.enctype= 'multipart/form-data';
		var dataWithFile = new FormData(frm);
		console.log("frm" + frm);
		console.log("확인용" + JSON.stringify(dataWithFile));


		var saveTaskCallback = function(data){
			alert("정상적으로 제출되었습니다.");
			console.log("data" + JSON.stringify(data));
			gfCloseModal();

			showSendList();
		}
		callAjaxFileUploadSetFormData("/std/taskSendSave.do", "post", "json", true, dataWithFile, saveTaskCallback);
		// callAjax("/std/taskSendSave.do", "post", "json", true, param, saveTaskCallback);
	}
	//TODO : 검색리스트 불러오기
	function searchTasks(lectureSeq, lectureName){
		console.log("searchTasks의 강의 : " + lectureSeq);
		lectureListArea.lectureSeq = lectureSeq;
		lectureListArea.lectureName = lectureName;

		functionStudentSearch();
	}

	function functionStudentSearch(pageNum){
		pageNum = pageNum || 1;

		lectureListArea.currentPage= pageNum;
		var logId = findId.loginId;
		var search;

		var param = {
			pageNum : pageNum,
			pageSize : lectureListArea.pageSize,
			lectureSeq : lectureListArea.lectureSeq,
			search : lectureHeaderArea.search,
		}

		//TODO 로그인 아이디 필요함
		console.log(param);

		var searchLectureListCallBack = function(lectureListData){
			lectureListArea.currentPage = pageNum;
			//lectureListArea.blockSize = pageBlockSize;
			//console.log("수강내역 조회 : " + JSON.stringify(lectureListData));


			var paginationHtml = getPaginationHtml(pageNum, lectureListArea.totalcnt, lectureListArea.pageSize, lectureListArea.blockSize, 'showLectureList');
			lectureListArea.pageNav = paginationHtml;

			lectureListArea.lectureItem = lectureListData.lectureList;
			lectureListArea.totalCnt = lectureListData.totalCnt;

			//console.log(lectureListData);
			//console.log(JSON.stringify(lectureListData));


		};

		callAjax("/std/courseListVue.do", "post", "json", "false", param, searchLectureListCallBack,'');
	}


	//TODO: 리스트 전체 불러오기
	function showLectureList(pageNum){

		$("#sendListArea").hide()
		pageNum = pageNum || 1;

		lectureListArea.currentPage= pageNum;
		console.log("1234444" + pageNum);

		var logId = findId.loginId;
		console.log("111+" + logId);

		var param = {
			pageNum : pageNum,
			pageSize : lectureListArea.pageSize,
			lectureSeq : lectureListArea.lectureSeq
		}
		//TODO 로그인 아이디 필요함
		console.log(param);

		var lectureListCallBack = function(lectureListData){
			lectureListArea.currentPage = pageNum;
			//console.log("수강내역 조회 : " + JSON.stringify(lectureListData));

			lectureListArea.lectureItem = lectureListData.lectureList;
			lectureListArea.totalCnt = lectureListData.totalCnt;

			var paginationHtml = getPaginationHtml(pageNum, lectureListArea.totalCnt, lectureListArea.pageSize, lectureListArea.blockSize, 'showLectureList');
			lectureListArea.pageNav = paginationHtml;



			//console.log(lectureListData);
			//console.log(JSON.stringify(lectureListData));


		};

		callAjax("/std/courseListVue.do", "post", "json", "false", param, lectureListCallBack,'');
	}


	//TODO: 과제관리 목록 보여주기
	function showSendList(lectureSeq,lectureName,pageNum){

		$("#sendListArea").show()
		pageNum = pageNum || 1;

		lectureListArea.lectureSeq = lectureSeq;
		sendListArea.currentPage = pageNum;

		taskContentLayer.lectureName = lectureName;


		var param = {
			pageNum : pageNum,
			pageSize : sendListArea.pageSize,
			lectureSeq: lectureListArea.lectureSeq,
			loginId: lectureListArea.loginId,
		}

		var taskListCallBack = function(taskData){
			console.log("과제내역 조회 : " + JSON.stringify(taskData));

			var paginationnHtml = getPaginationHtml(pageNum, sendListArea.totalCnt,sendListArea.pageSize,lectureListArea.blockSize,'showSendList');
			sendListArea.pageNav = paginationnHtml;

			sendListArea.taskItem = taskData.taskList;
			sendListArea.totalCnt = taskData.totalCnt;


		};
		callAjax("/std/taskListVue.do", "post", "json", "false", param, taskListCallBack);
		//TODO 초기화하기: 클릭할 때 마다 다시 조회하기
		sendListArea.tbodySendList = [];
	}

	//TODO 데이터 한건씩 조회하기
	function showTaskDetail(planNo, planWeek){

		sendListArea.planNo = planNo;
		taskContentLayer.planWeek = planWeek;
		taskSendLayer.studentPlanWeek = planWeek;
		console.log("주차확인" + planWeek);

		var param = {
			planNo : planNo
		}

		var resultCallBack = function(planNo){
			console.log("과제내용 상세보기" + JSON.stringify(planNo));

			functionInitForm(planNo.taskInfo);
			gfModalPop('#taskContentLayer');
			taskContentLayer.taskWeek = planWeek;
			//taskSendLayer.studentPlanWeek = planWeek;

		};
		callAjax("/std/taskContent.do", "post", "json", true, param, resultCallBack)

	}

	function functionInitForm(data){

		var fileName = data.taskName;
		var notFile = "없엉 ㅎㅎㅎㅎㅎㅎ";


		if(fileName == null || fileName == "" || fileName == undefined){
			taskContentLayer.fileinfo = notFile;
		}else{
			taskContentLayer.fileinfo = data.taskName;
		}

		taskContentLayer.taskStart = data.taskStart;
		taskContentLayer.taskEnd = data.taskEnd;
		taskContentLayer.taskTitle = data.taskTitle;
		taskContentLayer.taskContent = data.taskContent;

	}


//TODO 과제제출 상세보기
	function showSendDetail(planNo, planWeek, taskNo){

		sendListArea.planNo = planNo;
		console.log("주차확인" + taskNo);
		taskSendLayer.studentPlanWeek = planWeek;
		taskSendLayer.taskNo = taskNo;

		var lectureSeq = lectureListArea.lectureSeq;
		var loginId = findId.loginId;
		var param = {
			planNo : planNo,
		}

		console.log("로그인 아이디 : " + loginId + " 파라미터 : " + planNo + " 시퀀스:" + lectureSeq + " 과제번호 : " + taskNo );
		//param  값 읽힘

		var detailCallBack = function(data){
			console.log("제출내용 상세보기 " + JSON.stringify(data));
			if(data.taskSendInfo == null){
				gfModalPop('#taskSendLayer');
				taskSendform(data.taskSendInfo);
				taskSendLayer.insert = true;
				taskSendLayer.update = false;
			}else{
				// functionInitForm2(data.taskSendInfo);
				gfModalPop('#taskSendLayer');
				taskSendform(data.taskSendInfo);
				taskSendLayer.insert = false;
				taskSendLayer.update = true;
				//조회로 초기화 해 주기
			}
		};
		callAjax("/std/taskSendSelect.do", "post", "json", true, param, detailCallBack)
	}

	// function functionInitForm1(taskWeek){
	// 	var lectureName = taskContentLayer.lectureName;
	// 	var planWeek = taskContentLayer.taskWeek;
	// 	taskSendLayer.studentPlanWeek = taskNo;
	//
	//
	// 	//강의명
	// 	taskSendLayer.studentLecture = lectureName
	// 	console.log("몇주차???" + planWeek.taskWeek)
	// }

	// //TODO : 팝업에 내용 넣기
	// function functionInitForm2(taskSendInfo){
	// 	var lectureName = taskContentLayer.lectureName;
	//
	//
	// 	//파이썬만 데이터 있어서 읽힘
	// 	//강의명
	// 	taskSendLayer.studentLecture = lectureName;
	// 	//주차
	// 	taskSendLayer.studentPlanWeek = taskSendInfo.planNo;
	// 	taskSendLayer.sendTitle = taskSendInfo.sendTitle;
	// 	taskSendLayer.sendContent = taskSendInfo.sendContent;
	// 	taskSendLayer.sendFileName = taskSendInfo.sendFile;
	// }


	function checkValidation(){
		var check = checkNotEmpty(
				[
					[ "sendTitle", "제목을 입력하세요" ],
					[ "sendContent", "내용을 입력하세요" ],
					// [ "selfile", "파일을 선택하세요"]
				]
		);
		if(!check){
			return;
		}
		return true;
	}

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<div id="findId">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="lectureSeq" id="lectureSeq" value="">
		<input type="hidden" name="planNo" id="planNo" value="">
		<input type="hidden" name="lecture" id="lecture" value="">
		<input type="hidden" name="taskNo" id="taskNo" value="">
		<input type="hidden" name="planWeek" id="planWeek" value="">
<%--		<input type="text"  name="loginId" id="loginId" value="${loginId}">--%>
<%--		<input type="text"  name="loginId" id="loginId" value="${loginId}" v-model="loginId">--%>
	</div>
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

						<p class="Location" >
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">과제제출</span> 
								<a href="../std/taskSend.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="lectureHeaderArea">
							<span>수강 내역</span> <span class="fr"> 
								<select id="lectuerName" name="lectuerName" style="width: 150px;">
								 <option value="name">강의명</option> </select>
							   <input type="text" style="width: 200px; height: 25px; " id="search" name="search" placeholder="검색어를 입력하세요" v-model="search">
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="lectureList" id="lectureListArea">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="15%">
									<col width="35%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">강사</th>
										<th scope="col">기간</th>
										<th scope="col">버튼</th>
										
									</tr>
								</thead>
								<template>
									<tbody v-for="(lecture, lectures) in lectureItem">
										<tr>
											<td>{{lecture.lectureSeq}}</td>
											<td v-model="lectureName">{{lecture.lectureName}}</td>
											<td>{{lecture.teacherName}}</td>
											<td>{{lecture.lectureStart}} ~ {{lecture.lectureEnd}}</td>
											<td @click="showSendList(lecture.lectureSeq, lecture.lectureName)"><a class="btnType3 color1">과제관리</a></td>
										</tr>
									</tbody>
								</template>
							 </table>
						   <div class="paging_area" id="lectureListPagination" v-html="pageNav"> </div>
						</div>
						<br>
						<br>
						<div id="sendListArea">
						<p class="conTitle">
							<span>과제 관리</span> <span class="fr">                
							</span>
						</p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="60%">
									<col width="20%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">주차</th>
										<th scope="col">학습목표</th>
										<th scope="col">과제</th>
										<th scope="col">제출</th>
									</tr>
								</thead>
<%--								<tbody id="tbodySendList" v-for="taskItem"></tbody>--%>

								<template v-if="totalCnt == 0">
									<tbody>
									<tr>
										<td colspan="4"> no DB </td>
									</tr>
									</tbody>
								</template>
								<template>
									<tbody id="tbodySendList">
									<tr v-for="(task, tasks) in taskItem">
										<td>{{task.plan_week}}</td>
										<td>{{task.plan_goal}}</td>
										<%--									<td v-if="task.task_no == 0">등록된 과제가 없네용</td>--%>
<%--										<td v-if="task.totalCnt == 0">등록된 과제가 없네용</td>--%>
										<td @click="showTaskDetail(task.plan_no,task.plan_week)"><a class="btnType3 color1">과제내용</a></td>
<%--										<td v-if="task.task_no == 0">버튼도 없당</td>--%>
										<td @click="showSendDetail(task.plan_no,task.plan_week, task.task_no)"><a class="btnType3 color1">제출하기</a></td>
									</tr>
									</tbody>
								</template>

							 </table>
						   <div class="paging_area" id="sendListPagination" v-html="pageNav"> </div>
						</div>
	
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="taskContentLayer" class="layerPop layerType2" style="width: 800px; height: 630px;">
		<dl>
			<dt>
				<strong>과제 내용</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" style="width: 750px; height: 450px;">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명</th>
							  <td><div id="lectureName" v-html="lectureName"></div></td>
							<th scope="row">주차 </th>
							  <td><div id="taskWeek" v-html="planWeek"></div></td>
						</tr>
						<tr>
							<th scope="row">제출일</th>
							   <td><div id="taskStart" v-html="taskStart"></div></td>
							<th scope="row">마감일</th>
							    <td><div id="taskEnd" v-html="taskEnd"></div></td>
						</tr>
						<tr>
							<th scope="row">과제명</th>
							  <td colspan="3"><div id="taskTitle" v-html="taskTitle"></div></td>
						</tr>	  
						<tr style=" height: 150px;">
							<th scope="row">과제 내용</th>
							  <td colspan="3"><div id="taskContent" v-html="taskContent"></div></td>
						</tr>	  
				
						<tr>
							<th scope="row">파일 </th>
							<td colspan="3"><div id="fileinfo" v-html="fileinfo"> </div></td>
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

	<!-- 과제 제출 모달  -->
	<div id="taskSendLayer" class="layerPop layerType2" style="width:580px">
		<dl>
			<dt>
				<strong>과제 제출</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row"   style="width:500px">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<input type="hidden" name="t_planNo" id="t_planNo" v-model="planNo" value=""/>
						<input type="hidden" name="t_taskNo" id="t_taskNo" v-model="taskNo" value=""/>
						<tr>
							<th scope="row">강의명 </th>
							<td><input type="text" class="inputTxt p100" id="s_lecture" name="s_lecture" v-model="studentLecture"readonly/></td>
							<th scope="row">주차</th>
							<td><input type="text" class="inputTxt p100" id="s_planWeek" name="s_planWeek" v-model="studentPlanWeek" readonly/></td>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="sendTitle" name="sendTitle" v-model="sendTitle" /></td>
						</tr>
						<tr>
						<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea  name="sendContent" id="sendContent" style="height: 100px; resize: none;" v-model="sendContent"></textarea></td>
						</tr>	
					    <tr>
							<th scope="row">파일 </th>
							<td colspan="2"><input type="file" class="inputTxt p100"name="selfile" id="selfile"/>
							<td colspan="2"><div id="fileInfo" v-html="sendFileName"> </div></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveTask" name="btn" v-show="insert"><span>제출</span></a>
					<a href="" class="btnType blue" id="btnUpdateTask" name="btn" v-show="update" @click="functionSaveTask()"><span>수정</span></a>
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