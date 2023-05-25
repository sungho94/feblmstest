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

	var conTitle;
	var divLectureList;
	var subTitle;
	var WeekPlanList;
	var lecturePlan;
	var weekPlanManage;

	// 강의 목록 페이징 설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5;
	
	// 주차별 계획 목록 페이징 설정
	var pageSizeWeek = 5;
	var pageBlockSizeWeek = 10;
	
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		comcombo("lecture_seq", "lectureseq", "all", "");
		
		lectureListPlanSearch();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			console.log("btnID : " + btnId);

			switch (btnId) {
			
				case 'btnLectureSearch' :
					lectureListPlanSearch();
					break;
				case 'btnSaveWeekPlan' :
					fn_insertweekplan();
					break;
				case 'btnDeleteWeekPlan' :
					conTitle.action = "D";
					fn_insertweekplan();
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
				case 'closePop' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init(){
		conTitle = new Vue ({
			el : "#conTitle",
			data : {
				lectureNameSearch : "",
				weeklectureno : "",
				lectureStart : "",
				lectureEnd : "",
				weeklectureno : "",
				maxemptiy : "",
				maxWeek : "",
				action : ""
			}
		});
		
		divLectureList = new Vue({
			el : "#divLectureList",
			data : {
				totalcnt : 0,
				itemlist : [],
				pagenavi : "",
			},
			methods : {
				/* 강의명을 눌러 주차별계획 목록 불러오기 */
				fn_weekPlanList : function(lecture_seq, maxWeek, lecture_start, lecture_end){
					
					conTitle.weeklectureno = lecture_seq;
					conTitle.lectureStart = lecture_start;
					conTitle.lectureEnd = lecture_end;
					conTitle.maxemptiy = maxWeek;
					
					subTitle.show = true;
					WeekPlanList.show = true;
					
					fn_weekPlanListSearch();
				},
				
				/* 강의 상세보기 */
				fn_lecturePlanListSelect : function(lecture_seq){
					var param = {
							lectureseq : lecture_seq
					};
					
					var selectcallback = function(selectresult){
						console.log("selectcallback : " + JSON.stringify(selectresult));
						
						fn_selectlecture(selectresult.lectureinfo);
						
						// 모달 팝업
						gfModalPop("#layer1");
					}
					
					callAjax("/tut/LecturePlanSelect.do", "post", "json", "false", param, selectcallback);
				}
			}
		});
		
		subTitle = new Vue({
			el : "#subtitle",
			data : {
				show : false,
				lastWeekDeletePlan : false,
			},
			methods : {
				
				/* 주차별계획 목록 선택 */
				fn_WeekPlan : function(planno){
					
					if(planno == null || planno == "" || planno == undefined){
						
						var weeklectureno = conTitle.weeklectureno;
						
						if(weeklectureno == null || weeklectureno == "" || weeklectureno == undefined){
							alert("강의를 먼저 선택해 주세요");
							return;
						}
						
						var lectureS = conTitle.lectureStart.replaceAll("-", "");
						var lectureE = conTitle.lectureEnd.replaceAll("-", "");
						
						console.log("lectureS: ", lectureS, "lectureE : ", lectureE);
						
						if(((lectureE - lectureS) / 7) >= conTitle.maxWeek) {
							
							conTitle.action = "I";
							
							// 그룹코드 폼 초기화
							fn_weekForm();
							
							// 모달 팝업
							gfModalPop("#layer2");
							
						} else {
							alert("최대 주차 입니다.");
							return;
						}
						
					} else {
						
						conTitle.action = "U";
						
						fn_selectweek(planno);
						
					}
				}
			}
		});
		
		WeekPlanList = new Vue({
			el : "#WeekPlanList",
			data : {
				show : false,
				itemlist : [],
				totalcnt : 0,
				pagenavi : "",
			}
		});
		
		lecturePlan = new Vue({
			el : "#layer1",
			data : {
				teacherName : "",
				lecture_name : "",
				lecture_start : "",
				lecture_end : "",
				lecture_person : "",
				lecture_total : "",
				test_no : "",
				lecture_goal : "",
				btnDeleteLecturePlan : false,
			}
		});
		
		weekPlanManage = new Vue({
			el : "#layer2",
			data : {
				lecture_no : "",
				plan_no : "",
				loginID : "",
				plan_goal : "",
				plan_content : "",
				plan_week : "",
			}
		})
	}
	
	//강의 목록 불러오기
	function lectureListPlanSearch(pagenum){
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				lectureNameSearch : conTitle.lectureNameSearch
		};
		
		function listcallback(returnData){
			divLectureList.totalcnt = returnData.totalcnt;
			divLectureList.itemlist = returnData.lecturePlanListSearch;
			
			var paginationHtml = getPaginationHtml(pagenum, divLectureList.totalcnt, pageSizeLecture, pageBlockSizeLecture, 'lectureListPlanSearch');
			divLectureList.pagenavi = paginationHtml;
			
			conTitle.weeklectureno = "";
			conTitle.lectureStart = "";
			conTitle.lectureEnd = "";
			
			subTitle.show = false;
			WeekPlanList.show = false;
			
			
			fn_weekPlanListSearch();
		}
		
	
	callAjax("/tut/lecturePlanListSearchVue.do", "post" , "json", "true", param, listcallback);
	}

	
	/* 강의 주차별계획 목록 불러오기 */
	function fn_weekPlanListSearch(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeWeek,
				lectureseq : conTitle.weeklectureno,
				lectureNameSearch : conTitle.lectureNameSearch
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			
			WeekPlanList.totalcnt = returndata.totalcnt;
			WeekPlanList.itemlist = returndata.weekPlanList;
			
			if (WeekPlanList.itemlist.length > 0){
				conTitle.maxWeek = WeekPlanList.itemlist[0].maxWeek
			} else {
				conTitle.maxWeek = "";
			}
			
			var paginationHtml = getPaginationHtml(pagenum, WeekPlanList.totalcnt, pageSizeLecture, pageBlockSizeLecture, 'fn_weekPlanListSearch');
			
			WeekPlanList.pagenavi = paginationHtml;
			
			$("#weekpagenum").val(pagenum);
			
			if(WeekPlanList.totalcnt < 1){
				subTitle.lastWeekDeletePlan = false;
			} else {
				subTitle.lastWeekDeletePlan = true;
			}
		};
		
		callAjax("/tut/weekPlanListVue.do", "post" , "json", "true", param, listcallback);
		
	}
	
	/* 강의 상세보기 모달창 */
	function fn_selectlecture(lectureinfo){
		
		lecturePlan.teacherName = lectureinfo.teacherName;
		lecturePlan.lecture_name = lectureinfo.lecture_name;
		lecturePlan.lecture_start = lectureinfo.lecture_start;
		lecturePlan.lecture_end = lectureinfo.lecture_end;
		lecturePlan.lecture_person = lectureinfo.lecture_person;
		lecturePlan.lecture_total = lectureinfo.lecture_total;
		lecturePlan.test_no = lectureinfo.test_no;
		lecturePlan.lecture_goal = lectureinfo.lecture_goal;
			
		lecturePlan.btnDeleteLecturePlan = true;
		
	}
	
	function fn_weekForm(weekinfo){
		
		if(weekinfo == null || weekinfo == "" || weekinfo == undefined){
			weekPlanManage.lecture_no = conTitle.weeklectureno;
			weekPlanManage.plan_goal = "";
			weekPlanManage.plan_content = "";
		
			if(conTitle.maxWeek == null || conTitle.maxWeek == "" || conTitle.maxWeek == undefined){
				weekPlanManage.plan_week = conTitle.maxemptiy;
			} else {
				weekPlanManage.plan_week = conTitle.maxWeek;
			}
	
		} else {
			weekPlanManage.lecture_no = conTitle.weeklectureno;
			weekPlanManage.plan_goal = weekinfo.plan_goal;
			weekPlanManage.plan_content = weekinfo.plan_content;
			weekPlanManage.plan_week = weekinfo.plan_week;
			
		}
	}
	
	/* 주차별계획 개별 선택 */
	function fn_selectweek(planno){
		
		var param = {
				lectureseq : conTitle.weeklectureno,
				plan_no : planno
		};
		
		weekPlanManage.plan_no = planno
		
		var selectcallback = function(selectresult){
			
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			fn_weekForm(selectresult.weekinfo);
			
			// 모달 팝업
			gfModalPop("#layer2");
			
		}
		
		callAjax("/tut/weekselect.do", "post", "json", "false", param, selectcallback);
	}
	
	/* 주차별계획 신규 주차 등록 / 수정 */
	function fn_insertweekplan(){
		
		var action = conTitle.action;
		console.log("액션 : " + action);
		
		if(action == "I" || action == "U"){
			
			if(!fn_Validateitem()){
				return;
			}
		}
		
		var param = {
				action : conTitle.action,
				lectureseq : conTitle.weeklectureno,
				plan_week : weekPlanManage.plan_week,
				plan_goal : weekPlanManage.plan_goal,
				plan_content : weekPlanManage.plan_content,
				plan_no : weekPlanManage.plan_no,
		};
		var savecallback = function(selectresult){
			
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			alert("저장되었습니다.")
			
			gfCloseModal();
			
			fn_weekPlanListSearch();
			
		}
		
		callAjax("/tut/weeksave.do", "post", "json", "false", param, savecallback);
		
	}
	
	function fn_Validateitem(){
		var chk = checkNotEmpty(
				[
						[ "plan_goal", "학습목표를 입력해주세요." ]
					,	[ "plan_content", "학습내용를 입력해주세요." ]
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
	<input type="hidden" name="weekaction" id="weekaction" value="">
	<input type="hidden" name="weeklectureno" id="weeklectureno" value="">
	<input type="hidden" name="weekpagenum" id="weekpagenum" value="">
	<input type="hidden" name="loginID" id="loginID" value="">
	<input type="hidden" name="maxWeek" id="maxWeek" value="">
	<input type="hidden" name="maxemptiy" id="maxemptiy" value="">
	<input type="hidden" name="lectureStart" id="lectureStart" value="">
	<input type="hidden" name="lectureEnd" id="lectureEnd" value="">
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의계획서</span> 
								<a href="../tut/lecturePlan.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="conTitle">
							<span>강의계획서</span> <span class="fr"> 
							
								강의명
		     	                <input type="text" style="width: 300px; height: 25px;" id="lectureNameSearch" name="lectureNameSearch" v-model="lectureNameSearch">                    
			                    <a href="" class="btnType blue" id="btnLectureSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divLectureList" id="divLectureList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="20%">
									<col width="20%">
									<col width="8%">
									<col width="8%">
									<col width="8%">
									<col width="11%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강의 시작날짜</th>
										<th scope="col">강의 종료날짜</th>
										<th scope="col">모집인원</th>
										<th scope="col">마감인원</th>
										<th scope="col">시험번호</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=7>데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in itemlist">
										<tr>
											<td><a href="" @click.prevent="fn_weekPlanList(item.lecture_seq, item.maxWeek, item.lecture_start, item.lecture_end)">{{item.lecture_name}}</a></td>
											<td>{{item.lecture_start}}</td>
											<td>{{item.lecture_end}}</td>
											<td>{{item.lecture_person}}</td>
											<td>{{item.lecture_total}}</td>
											<td>{{item.test_no}}</td>
											<td>
												<a href="" @click.prevent="fn_lecturePlanListSelect(item.lecture_seq)"><span>상세보기</span></a>
											</td>
										</tr>
									</tbody>
								</template>
							</table>
							<div class="paging_area"  id="lecturePagination" v-html="pagenavi"> </div>
						</div>
	
						
						
						<br/>
						<br/>
						
						<p class="conTitle" id="subtitle" v-show="show">
							<span>주차별 계획</span> <span class="fr"> 
							    <a class="btnType blue" href="" @click.prevent="fn_WeekPlan()" name="modal"><span>신규등록</span></a>
							    <a class="btnType blue" href="" id="btnDeleteWeekPlan" name="btn" v-show="lastWeekDeletePlan"><span>마지막주차 삭제</span></a>
							</span>
						</p>
						
						<div class="WeekPlanList" id="WeekPlanList"  v-show="show">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="35%">
									<col width="35%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주차</th>
										<th scope="col">학습목표</th>
										<th scope="col">학습내용</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<template v-if="totalcnt ===0">
									<tbody>
										<tr>
											<td colspan=4>데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item, index) in itemlist">
										<tr>
											<td>{{item.plan_week}}</td>
											<td>{{item.plan_goal}}</td>
											<td>{{item.plan_content}}</td>
											<td>
												<a href="" @click.prevent="subTitle.fn_WeekPlan(item.plan_no)"><span>수정</span></a>
											</td>
										</tr>
									</tbody>
								</template>
							</table>
							<div class="paging_area"  id="planPagination" v-html="pagenavi"> </div>
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
				<strong>강의 계획서</strong>
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
							<th scope="row">강사명</th>
							<td><input type="text" class="inputTxt p100" name="teacherName" id="teacherName" readonly v-model="teacherName"/></td>
							<th scope="row">강의명 </th>
							<td><input type="text" class="inputTxt p100" name="lecture_name" id="lecture_name" readonly v-model="lecture_name"/></td>
						</tr>
						<tr>
							<th scope="row">강의 시작날짜 </th>
							<td><input type="date" class="inputTxt p100" name="lecture_start" id="lecture_start" readonly v-model="lecture_start"/></td>
							<th scope="row">강의 종료날짜 </th>
							<td><input type="date" class="inputTxt p100" name="lecture_end" id="lecture_end" readonly v-model="lecture_end"/></td>
						</tr>
						<tr>
							<th scope="row">모집인원 </th>
							<td><input type="text" class="inputTxt p100" name="lecture_person" id="lecture_person" readonly v-model="lecture_person"/></td>
							<th scope="row">마감인원 </th>
							<td><input type="text" class="inputTxt p100" name="lecture_total" id="lecture_total" readonly v-model="lecture_total"/></td>
						</tr>
						<tr>
							<th scope="row">시험번호 </th>
							<td><input type="text" class="inputTxt p100" name="test_no" id="test_no" readonly v-model="test_no"/></td>
						</tr>
						<tr>
							<th scope="row">수업목표 </th>
							<td colspan="4"><input type="text" class="inputTxt p200" name="lecture_goal" id="lecture_goal" readonly v-model="lecture_goal"/></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" name="btn" id="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>주차별계획 관리</strong>
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
							<th scope="row">주차 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="plan_week" name="plan_week" readonly v-model="plan_week"/>
								<input type="hidden" class="inputTxt p100" id="plan_no" name="plan_no" />
							</td>
							<th scope="row">강의번호 </th>
							<td><input type="text" class="inputTxt p100" id="lecture_no" name="lecture_no" readonly v-model="lecture_no"/></td>
						</tr>
						<tr>
							<th scope="row">학습목표 <span class="font_red">*</span></th>
							<td colspan="4"><input type="text" class="inputTxt p100"
								id="plan_goal" name="plan_goal" v-model="plan_goal"/></td>
						</tr>
						<tr>
							<th scope="row">학습내용 <span class="font_red">*</span></th>
							<td colspan="4"><textarea type="text" class="inputTxt p100"
								id="plan_content" name="plan_content" v-model="plan_content"></textarea></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveWeekPlan" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="closePop" name="btn"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>