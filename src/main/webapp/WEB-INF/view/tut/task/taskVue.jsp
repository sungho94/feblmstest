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
	
	var grpCodList;
	var searchArea;
	var lecturePlan;
	var taskList;
	var tasklayer1;
	var taskSendInfo;
	var sendDetail;
	
	
	/** OnLoad event */ 
	$(function() {
		
		console.log("selectComCombo : "+JSON.stringify(selectComCombo));
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		init();
		
		lectureList();
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

				//	alert("btnId : "+$(this).attr('id')); 
			var btnId = $(this).attr('id');

			switch (btnId) {
				/* case 'btnSaveTask' :
					fn_insertTask();
					break; */
				/* case 'btnUpdateTask' :
				//	alert("aaaaaa");
					fn_insertTask();
					break; */
				/* case 'btnSearch':
					lectureList();
					break; */
				/* case 'btnCloseTask' :
					gfCloseModal();
					break; */
				/* case 'btnBack' :
					fn_taskSendInfo();
					break; */	
			}
		});
	}
	
	function init(){
		
		grpCodList = new Vue({
			
			el : "#grpCodList",
			data : {
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : ""
			},
			methods : {
				planlistsearch : function(lectureNo){
					fn_planlistsearch(lectureNo); 
				}
			}
		});
		
		searchArea = new Vue({
			el : "#search",
			data : {
			all : ""
			}
		});
		
		selectComCombo("lecbyuser", "lecbyuserall", "all", ""); 
		
		lecturePlan = new Vue({
			el : "#lecturePlan",
			data : {
				lecturePlan : false,
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
				lectureNo : 0, 
			},
			methods : {
				tasklistsearch : function(planNo){
					fn_tasklistsearch(planNo);
				}
			}
		});
		
		taskList = new Vue({
			el : "#taskList",
			data : {
				taskList : false,
				taskmodal : false,
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
				planNo : 0,
			},
		});
		
		tasklayer1 = new Vue({
			el : "#tasklayer1",
			data : {
				title : "",
				content : "",
				taskStart : "",
				taskEnd : "",
				selfile : "",
				fileinfo : "",
				btnUpdateTask : false,
				btnSaveTask : false,
				action : "",
				taskName : "",
			}
		});
		
		taskSendInfo = new Vue({
			el : "#sendListLayer1",
			data : {
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
				planNo : 0,
			//	sendList : true, 
			}
		})
		
		sendDetail = new Vue({
			el : "#sendDetailLayer",
			data : {
				studentName : "",
				sendDate : "",
				sendTitle : "",
				sendContent : "",
				fileInfo : "",
				sendNo : 0,
			}
		})
	}
	
	function lectureList(pageNum){ 
		
		lecturePlan.lecturePlan = false;
		taskList.taskList = false;
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizelecture,
				lecbyuserall : searchArea.all
		}
		
		console.log(param);

		var lectureListCallback = function(listdata){ 
			//console.log("lectureListCallback" + JSON.stringify(listdata));
			
			grpCodList.cpage = pageNum;
			
			grpCodList.listitem = listdata.lectureList;
			grpCodList.totalcnt = listdata.totalCnt;
			
			//console.log("listitem : " + JSON.stringify(grpCodList.listitem));

			var paginationHtml = getPaginationHtml(pageNum, listdata.totalCnt, pageSizelecture, pageBlockSizelecture, 'lectureList');
			
			grpCodList.pagenavi = paginationHtml;

		}; 
		
		callAjax("/tut/vueLecturelist.do", "post", "json", false, param, lectureListCallback);
	}
	
	function fn_planlistsearch(lectureNo){
		
		console.log("lectureNo : "+lectureNo);
		
		lecturePlan.lectureNo = lectureNo; 
		
		lecturePlan.lecturePlan = true;
		taskList.taskList = false;
		
		planList();
	}
	
	function planList(pageNum){ 
		
		/* lecturePlan.lecturePlan = true;
		taskList.taskList = false; */
		
		pageNum = pageNum || 1; 
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizePlan,
				lectureNo : lecturePlan.lectureNo,
		}
		
		var planListCallback = function(plandata){
			
			console.log("planListCallback" + JSON.stringify(plandata));
			
			lecturePlan.cpage = pageNum;
			
			lecturePlan.listitem = plandata.planList;
			lecturePlan.totalcnt = plandata.totalCnt;
			
			var paginationHtml = getPaginationHtml(pageNum, plandata.totalCnt, pageSizePlan, pageBlockSizePlan, 'planList');
			
			lecturePlan.pagenavi = paginationHtml;
	         
		};
		
		callAjax("/tut/vuePlanlist.do", "post", "json", false, param, planListCallback);
	}
	
	function fn_tasklistsearch(planNo){
		
		taskList.planNo = planNo;
		
		console.log("planNo : "+taskList.planNo)
		
		taskList.taskList = true;
		
		fn_taskList();
	}
	
	function fn_taskList(pageNum){
		
		pageNum = pageNum || 1;
		
		var param = {
			pageNum : pageNum,
			pageSize : pageSizelecture,
			planNo : taskList.planNo
		}
		
		var taskListCallback = function(listdata){
			
			console.log("taskListCallback : "+JSON.stringify(listdata));
			
			lecturePlan.cpage = pageNum;
			
			taskList.listitem = listdata.taskList;
			taskList.totalcnt = listdata.totalCnt;
			
			 var paginationHtml = getPaginationHtml(pageNum, listdata.totalCnt, pageSizelecture, pageBlockSizelecture, 'taskList');
			
			 taskList.pagenavi = paginationHtml;
			 
			 if(taskList.totalcnt == 0){
				 taskList.taskmodal = true;
			 }else{
				 taskList.taskmodal = false;
			 }
		};
		
		callAjax("/tut/vueTasklist.do", "post", "json", false, param, taskListCallback);
		
	}
	
	/* 과제 상세 조회 - 모달*/
	function fn_taskDetail(planNo){
		
		taskList.planNo = planNo;

		var param = {
			planNo : planNo
		};
		
		var detailCallback = function(detailresult){
			console.log("detailCallback : " + JSON.stringify(detailresult));
			
			if(detailresult.taskInfo == null){
				fn_initForm();
				console.log("과제등록 안 #planNo 제이쿼리 값 : "+$("#planNo").val());
				gfModalPop("#tasklayer1");
			}else{
			
				var taskInfo = detailresult.taskInfo
				
				tasklayer1.title = taskInfo.taskTitle;
				tasklayer1.content = taskInfo.taskContent;
				tasklayer1.taskStart = taskInfo.taskStart;
				tasklayer1.taskEnd = taskInfo.taskTitle;
				tasklayer1.btnSaveTask = false;
				fn_initForm(taskInfo);
				console.log("과제수정 안 #planNo 제이쿼리 값 : "+$("#planNo").val());
				gfModalPop("#tasklayer1"); 
			}
		}
		callAjax("/tut/taskdetail.do", "post", "json", "false", param, detailCallback);
	}
	
	/* 과제 등록 & 수정 버튼 클릭 시  */
	/* function fn_taskPopup(planNo){
		
		console.log("taskCode : "+taskCode);
		
		if(taskCode == null || taskCode == "" || taskCode == undefined){
			$("#action").val("I");
			
			fn_initForm();
			
			gfModalPop("#tasklayer1");
		}else{
			$("#action").val("U");
			
			fn_taskDetail(taskCode);
			
			 
		}
	} */
	
	function fn_initForm(object){
		
		//alert("sdfa");
		
	    var now_utc = Date.now() // 지금 날짜를 밀리초로
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		// new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
		var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		var now = document.getElementById("taskStart").setAttribute("min", today);
		
		
		if(object == "" || object == null || object == undefined ){
			tasklayer1.action = "I";
			tasklayer1.title = "";
			tasklayer1.content = "";
			tasklayer1.taskStart = "";
			tasklayer1.taskEnd = "";
		  
			tasklayer1.selfile = "";
			tasklayer1.fileinfo = "";
			tasklayer1.btnUpdateTask = false;
			tasklayer1.btnSaveTask = true;
		} else {
			tasklayer1.action = "U";
			tasklayer1.title = object.taskTitle;
			tasklayer1.content = object.taskContent;
			tasklayer1.taskStart = object.taskStart;
			tasklayer1.taskEnd = object.taskEnd;
			tasklayer1.taskName = object.taskName;
			
			tasklayer1.selfile = "";  
			tasklayer1.btnUpdateTask = true;
			tasklayer1.btnSaveTask = false;  
		   
		   var readFileName = object.taskName;
		   var inserthtml = inserthtml = "<a>" + object.taskName + "</a>";
		    
		   console.log(inserthtml);
		   
		   tasklayer1.fileinfo = readFileName; 
		   
		}
		
	}
	
	function fn_insertTask(){
		
		//alert("action : "+tasklayer1.action);
		
		var action =  tasklayer1.action;   
		
		if(action == "I" || action == "U"){
			   if(!fn_Validateitem()){
				   return;
			   }
		 }
		
	        var frm = document.getElementById("myForm");
			frm.enctype = 'multipart/form-data';
			
		//	frm.action = action;
			var dataWithFile = new FormData(frm);
			
			console.log("dataWithFile : " + JSON.stringify(frm));
			//dataWithFile.action("action", action); 
			
			var insertCallback = function(data){
				console.log("insertCallback: ", JSON.stringify(data)); 
			alert("등록되었습니다.");
			
			gfCloseModal();
			//lectureList();
			fn_taskList();	
		
		}
			
		callAjaxFileUploadSetFormData("/tut/taskinsert.do", "post", "json", true, dataWithFile, insertCallback);
	
	}
	
	function SendInfosearch(planNo){
		taskList.planNo = planNo;
		fn_taskSendInfo();
	}
	
	function fn_taskSendInfo(pageNum){
	//	taskSendInfo.sendList = true; 
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSizelecture,
				planNo : taskList.planNo,
		}
		
		var taskSendCallback = function(data){
			console.log("taskSendCallback : " + JSON.stringify(data));
			
			
			taskSendInfo.cpage = pageNum;
			taskSendInfo.listitem = data.tasksendinfo;
			taskSendInfo.totalcnt = data.totalCnt;
			
	        var paginationHtml = getPaginationHtml(pageNum, data.totalCnt, pageSizelecture, pageBlockSizelecture, 'fn_taskSendInfo');
	        taskSendInfo.pagenavi = paginationHtml; 
	         
	        gfModalPop("#sendListLayer1");
	
		}
		callAjax("/tut/vueTasksendinfo.do", "post", "json", "false", param, taskSendCallback);
	} 
	
	/* 제출 과제 상세 조회 - 모달*/
	function fn_taskSendDetail(sendNo) {
		
		var param = {
			sendNo : sendNo
		};
		
		var sendDetailCallback = function(data){
			console.log("sendDetailCallback : " + JSON.stringify(data));
			
			var taskInfo = data.taskSendInfo
			
			sendDetail.sendNo = taskInfo.sendNo;
			sendDetail.studentName = taskInfo.stdName;
			sendDetail.sendDate = taskInfo.sendDate;
			sendDetail.sendTitle = taskInfo.sendTitle;
			sendDetail.sendContent = taskInfo.sendContent;
			
			var readFileName = taskInfo.sendFile;
			var inserthtml = "";
			var notFile = "파일없음";
			
			if(readFileName == null || readFileName == "" || readFileName == undefined ){
				inserthtml = "<a >" + notFile + "</a>"; 
			} else{
			    inserthtml = "<a href='javascript:fn_fileDounload()'>" + taskInfo.sendFile + "</a>"; 
			}
			
			sendDetail.fileInfo = inserthtml;  
			
			gfModalPop("#sendDetailLayer");

		}
		callAjax("/tut/taskSendDetail.do", "post", "json", "false", param, sendDetailCallback);
	} 
	
	/*다운로드*/
	function fn_fileDounload(){
		
		var sendNo = sendDetail.sendNo;
		
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
						[ "cLecName", "강의를 선택해주세요." ]
					,	[ "cStuName", "학생을 선택해주세요" ]
					, 	["cnsDate", "상담 날짜를 입력해주세요."]
					, 	["cnsUpdate", "수정 날짜를 입력해주세요."]
					, 	["cnsPlace", "상담 장소를 입력해주세요."]
					, 	["cnsCont", "상담 내용을 입력해주세요."]
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

						<p class="conTitle" id="search">
							<span>수업 정보</span> <span class="fr"> 
							   <select id="lecbyuserall" name="lecbyuserall" v-model="all" style="width: 150px;" >
							    </select>                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn" @click.prevent=lectureList()><span>검  색</span></a>
							</span>
						</p>
						
						<div id="grpCodList">
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
								
								<tbody v-for="(item,index) in listitem">
									<tr>
										<td>{{item.lectureSeq}}</td>
										<td><a href="" @click.prevent="planlistsearch(item.lectureSeq)">{{item.lectureName}}</a></td>
										<td>{{item.tutName}}</td>
										<td>{{item.lectureStart}}</td>
										<td>{{item.lectureEnd}}</td>
										<td>{{item.roomNo}}</td>
										<td>{{item.lecturePerson}}</td>
									</tr>
								</tbody>
							</table>
							<div class="paging_area"  id="lecturelistPagination" v-html="pagenavi"> </div>
						</div>
						<br>
						<br>
						<div id="lecturePlan" v-show="lecturePlan">
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
								<template v-if="totalcnt === 0"> 
									<tbody>
										<tr>
										      <td colspan=3>조회된 데이터가 없습니다.</td>
										 </tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr>
										      <td>{{item.planWeek}}</td>
										      <td><a href="" @click.prevent="tasklistsearch(item.planNo)">{{item.planGoal}}</a></td>
										 </tr>
									</tbody>
								</template>
							</table>
							<div class="paging_area"  id="planlistPagination" v-html="pagenavi"> </div>
						</div>
						
						<br>
						<br>
						<div id="taskList" v-show="taskList">
						<input type="hidden" name="planNo" v-model="planNo" id="planNo">
							<p class="conTitle">
								<span>과제 관리</span> <span class="fr"> 
								    <a href="" class="btnType blue" @click.prevent="fn_taskDetail(planNo)" name="modal" id="taskmodal" v-show="taskmodal"><span>과제등록</span></a>
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
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
										      <td colspan=3>조회된 데이터가 없습니다.</td>
										 </tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr>
											<td><a href @click.prevent="fn_taskDetail(item.planNo)">{{item.taskTitle}}</a></td> 
											<td>{{item.taskStart}}</td>
											<td>{{item.taskEnd}}</td>
											<td><a href="" class="btnType3 color1" @click.prevent="SendInfosearch(item.planNo)"><span>목록 보기</span></a></td>
										</tr> 
									</tbody>
								</template>
							</table>
							<div class="paging_area"  id="tasklistPagination" v-html="pagenavi"> </div>
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
		<input type="hidden" name="action" id="action" v-model="action"> 
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
								   name="taskStart" v-model="taskStart" id="taskStart" style="font-size: 15px" min/></td>
							<th scope="row">마감일 <span class="font_red">*</span></th>
						<td><input type="date" class="inputTxt p100"
								   name="taskEnd" v-model="taskEnd" id="taskEnd" style="font-size: 15px"  /></td>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt" name="title" v-model="title" id="title" /></td>
						</tr>
						<tr >
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea  name="content" v-model="content" id="content" style="height: 100px; resize: none;"></textarea></td>
						</tr>
					
						<tr>
							<th scope="row">파일 </th>
							<td><input type="file" class="inputTxt p100"name="selfile" v-model="selfile" id="selfile" />
							<td colspan="3"><div id="fileinfo" v-html="fileinfo"> </div></td>
						</tr>
					</tbody>
				</table>
 
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveTask" name="btn" v-show="btnSaveTask" @click.prevent="fn_insertTask()"><span>등록</span></a> 
					<a href="" class="btnType blue" id="btnUpdateTask" name="btn" v-show="btnUpdateTask" @click.prevent="fn_insertTask()"><span>수정</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseTask" name="btn" @click.prevent="gfCloseModal()"><span>취소</span></a>
				</div>
			</dd> 
		</dl>
		<a href="" class="closePop" @click.prevent="gfCloseModal()"><span class="hidden">닫기</span></a>
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
							<template  v-if="totalcnt === 0">
								<tbody>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tbody>
							</template>
							<template  v-else>
								<tbody v-for="(litem,index) in listitem">
									<tr>
										<td>{{litem.stdName}}</td>
										<td><a href="" @click.prevent="fn_taskSendDetail(litem.sendNo)">{{litem.sendTitle}}</a></td>
										<td>{{litem.sendDate}}</td>  
									</tr>
								</tbody>
							</template>
						 </table> 
					   <div class="paging_area"  id="sendlistPagination" v-html="pagenavi"> </div>
				 </div>
				 <div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseTask" @click.prevent="gfCloseModal()" name="btn"><span>닫기</span></a>
				 </div>
			</dd>
		</dl>
		<a href="" class="closePop" @click.prevent="gfCloseModal()"><span class="hidden">닫기</span></a>
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
						<input type="hidden" class="inputTxt p100" name="sendNo" id="sendNo" v-model="sendNo" />
						<tr>
							<th scope="row">학생명</th>
						<td><div id="studentName" v-html="studentName"></div></td>
							<th scope="row">제출일</th>
						<td><div id="sendDate" v-html="sendDate"></div></td>
						</tr>
						<tr>
							<th scope="row">제목 </th>
							<td colspan="3"><div id="sendTitle" v-html="sendTitle"></div></td>
						</tr>
						<tr style=" height: 150px;">
							<th scope="row">내용</th>
							<td colspan="3"><div id="sendContent" v-html="sendContent"></div></td>
						</tr>
					
						<tr>
							<th scope="row">파일 </th>
							<td colspan="3"><div id="fileInfo" v-html="fileInfo"> </div></td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnBack" name="btn" ><span>이전</span></a>
					<a href=""	class="btnType gray"  id="btnCloseTask" name="btn" @click.prevent="gfCloseModal()" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" @click.prevent="gfCloseModal()"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>