<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>LmsRight : 강의 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>
select[readonly] {
  background-color: #ddd;
  pointer-events: none;
}
</style>
<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5;
	
	// 상세코드 페이징 설정
	var pageSizeStudent = 5;
	var pageBlockSizeStudent = 10;
	
	var lectureSearch;
	var lectureList;
	var studentList;
	var lectureSelect;
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent(); 
		
		init(); 
		
		lectureListSearch();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				/* case 'btnSearchLecture':
					lectureListSearch();
					break; */
				/* case 'btnSaveLecture' :
					fn_SaveLecture();
					break; */
				/* case 'btnUpdateLecture' :
					fn_SaveLecture();
					break; */
/* 				case 'btnDeleteLecture' :
					$("#action").val("D");
					fn_SaveLecture();
					break; */
				/* case 'btnCloseLecture' :
					gfCloseModal();
					break; */
			}
		});
		
	}
	
	function init(){
			
		lectureSearch = new Vue({
				
			el : "#lectureSearch",
			data : {
				lectureName : "",
				searchWord : "",
				depositCheck : "N",
			}
				
		});
			
		comcombo("lecture_no", "lectureName", "all", "");
			
		lectureList = new Vue({
			
			el : "#lectureList", 
			data : {
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
				lectureSeq : 0,
				
			}
			
		});
			
		studentList = new Vue({
			 el : "#studentList",
			 data : {
				studentList : false,
				listitem : [],
				totalcnt : 0,
				cpage : 0,
				pagenavi : "",
			 }
		});
		
		lectureSelect = new Vue({
			el : "#layer1",
			data : {
				action : "",
				lecture_total : "",
				lecture_start : "",
				lecture_end : "",
				lecture_goal : "",
				lectureConfirmDiv : "",
				roomStatusDiv : "",
				loginID : [],
				test_no : [],
				room_no : [],
				sloginID : "",
				stest_no : "",
				sroom_no : "",
				lecture_confirm : "N",
				room_status : "N",
				test_title : "",
				room_name : "",
				loginIDShow1 : false,
				loginIDShow2 : false,
			}
		});
		
	}
		
	//강의 목록 조회
	function lectureListSearch(pagenum) { 
		console.log("lectureListSearch");
		
		pagenum = pagenum || 1;

		var checkBox;
			
			
		if (lectureSearch.depositCheck == "Y") {
			//alert("checked");
			checkBox = "checked";
		} else checkBox = "";
		
			
		console.log(checkBox);  
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				lectureName : lectureSearch.lectureName,
				searchWord : lectureSearch.searchWord,
				// checkBoxStatus : $("#depositCheck").val()
				checkBoxStatus : checkBox
		};
			
		console.log(param);
			
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			lectureList.cpage = pagenum; 
			
			lectureList.listitem = returndata.lectureListSearch;
			lectureList.totalcnt = returndata.totalcnt; 
				
			var paginationHtml = getPaginationHtml(pagenum, lectureList.totalcnt, pageSizeLecture, pageBlockSizeLecture, 'lectureListSearch');
				
			lectureList.pagenavi = paginationHtml;
			
			lectureList.lectureSeq = "";
				
			studentList.studentList = false;
		};
			
		callAjax("/adm/vueLectureManagementList.do", "post" , "json", "false", param, listcallback);

	}
	
	function fn_studentListSearch(lectureSeq){
		
		console.log(lectureSeq);
		
		lectureList.lectureSeq = lectureSeq;
		
		studentListSearch();
	}
	
	function studentListSearch(pagenum){
		
		studentList.studentList = true;
 		
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeStudent,
				lectureSeq : lectureList.lectureSeq
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata));
			
			studentList.cpage = pagenum;
			
			studentList.listitem = returndata.studentListSearch;
			studentList.totalcnt = returndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.totalcnt, pageSizeStudent, pageBlockSizeStudent, 'studentListSearch');

			studentList.pagenavi = paginationHtml;
			
		//	$("#bkpagenum").val(pagenum); 
			
		};
		
		callAjax("/adm/vueStudentManagementList.do", "post" , "json", "false", param, listcallback);
 	}
	
	//강의 insert, update마다 값
	function fn_initForm(selectLecture){
	
		console.log("selectLecture : " + selectLecture);

		if(selectLecture.loginID == null || selectLecture.loginID == "" || selectLecture.loginID == undefined){	
			
			lectureSelect.loginID = "";
			lectureSelect.sloginID = "";
			lectureSelect.action = "I";
			lectureSelect.lecture_total = "";
			lectureSelect.lecture_start = "";
			lectureSelect.lecture_end = "";
			lectureSelect.lecture_goal = "";
			lectureSelect.test_no = "";
			lectureSelect.room_no = "";
			lectureSelect.stest_no = "";
			lectureSelect.sroom_no = "";
			lectureSelect.test_title = "";
			lectureSelect.room_name = "";
			lectureSelect.loginIDShow1 = true;
			lectureSelect.loginIDShow2 = false;
			
			lectureSelect.lectureNo = ""; 
			lectureSelect.lectureSeq = ""; 
			lectureSelect.roomSeq = ""; 
			//$("#btnDeleteLecture").hide();
			
			userCombo("usr", "B", "loginID", "sel", ""); 
			
			selectComCombo("test", "test_no", "sel", "");  
			
			selectComCombo("room:N", "room_no", "sel", "");	
			
			console.log("데이터 : "+lectureSelect.room_no+", "+lectureSelect.loginID+", "+lectureSelect.test_no);
			
		}else{

			lectureSelect.loginID = selectLecture.loginID;
			lectureSelect.test_no = selectLecture.test_no; 
			lectureSelect.room_no = selectLecture.room_no; 
			lectureSelect.lecture_confirm = selectLecture.lecture_confirm;
			lectureSelect.room_status = selectLecture.room_status;

			lectureSelect.lecture_total = selectLecture.lecture_total;
			lectureSelect.lecture_start = selectLecture.lecture_start;
			lectureSelect.lecture_end = selectLecture.lecture_end;
			lectureSelect.lecture_goal = selectLecture.lecture_goal;
			lectureSelect.lectureNo = selectLecture.lecture_no;
			lectureSelect.lectureSeq = selectLecture.lecture_seq;
			lectureSelect.roomSeq = selectLecture.room_seq;
			lectureSelect.test_title = selectLecture.test_title;
			lectureSelect.room_name = selectLecture.room_name;
			lectureSelect.loginIDShow1 = false;
			lectureSelect.loginIDShow2 = true;
			
			lectureSelect.action = "U";
			
			console.log("데이터 : "+lectureSelect.room_no+", "+lectureSelect.loginID+", "+lectureSelect.test_no);
			
			console.log("data : "+lectureSelect.loginID+lectureSelect.test_no+lectureSelect.room_no); 
			 
			//$("#btnDeleteLecture").show(); 
			
		}
		
	}
	
	//강의 단건 조회
	function fn_lectureSelect(lectureSeq){
		
		var param = {
				lectureSeq : lectureSeq,
		//		roomSeq : roomSeq
		};
		
		var selectcallback = function(selectresult){
			console.log("selectresult : " + JSON.stringify(selectresult));	
			
			var room_no = selectresult.lectureInfo.room_no;
			
			/* console.log("디테일 : "+room_no);
			
			lectureSelect.room_no = room_no; */
			
			fn_initForm(selectresult.lectureInfo);
			
			/* userCombo("usr", "B", "loginID", "sel", ""); */
			
			//모달 팝업
			gfModalPop("#layer1");
		};
		
		callAjax("/adm/lectureSelect.do", "post" , "json", "false", param, selectcallback);
		
	}
	
	//강의 저장
	function fn_SaveLecture(){
		
		var action = lectureSelect.action;
		var lecture_start = lectureSelect.lecture_start;
		var lecture_end = lectureSelect.lecture_end;
		var loginID;
		var testNo;
		var roomNo;
		
		if(action == "I" || action == "U"){
			if(!fn_validateitem()){
				return;
			}
		}
		
		 if(lectureSelect.lecture_start != '' && lectureSelect.lecture_end != ''){
			if(lectureSelect.lecture_end.replaceAll("-", "") - lectureSelect.lecture_start.replaceAll("-", "") < 0){
				
				alert("올바른 기간을 선택해주세요.");
				
				gfCloseModal();
				
				return false;
			}
		}
		 
		if(action == "I"){
			loginID = lectureSelect.sloginID;
			testNo = lectureSelect.stest_no;
			roomNo = lectureSelect.sroom_no;
			alert("asddd");
		}else{
			loginID = lectureSelect.loginID;
			testNo = lectureSelect.test_no;
			roomNo = lectureSelect.room_no;
			alert("1233");
		} 
		//console.log("sloginID, stestNo, sroomNo : "+lectureSelect.sloginID+", "+lectureSelect.stestNo+", "+lectureSelect.sroomNo);
		console.log("loginID, testNo, roomNo : "+lectureSelect.loginID[0]+", "+lectureSelect.test_no[0]+", "+lectureSelect.room_no[0]);
		var param = {
				roomSeq : lectureSelect.roomSeq,
				lectureSeq : lectureSelect.lectureSeq,
				lectureNo : lectureSelect.lectureNo,
				action : lectureSelect.action,
				loginID : loginID,
				testNo : testNo,
				roomNo : roomNo,
				lectureTotal : lectureSelect.lecture_total,
				lectureStart: lectureSelect.lecture_start,
				lectureEnd: lectureSelect.lecture_end,
				lectureGoal: lectureSelect.lecture_goal,
				lectureConfirm: lectureSelect.lecture_confirm,
				roomStatus: lectureSelect.room_status
		};
			
		var savecallback = function(selectresult){
			console.log("savecallback : " + JSON.stringify(selectresult));	
				
			alert("저장 되었습니다.");
				
			gfCloseModal();
				
			lectureListSearch();
		};
		callAjax("/adm/lectureOption.do", "post" , "json", "false", param, savecallback);
			
	}
	
	function fn_validateitem(){
		var chk = checkNotEmpty(
				[
						[ "loginID[0]", "강사명을 입력해 주세요." ]
					,	[ "lecture_total", "마감인원을 입력해 주세요" ]
					,	[ "lecture_start", "시작날짜를 입력해 주세요" ] 
					,	[ "lecture_end", "종료날짜를 입력해 주세요" ]
					,	[ "lecture_goal", "수업목표를 입력해 주세요" ]
					,	[ "lecture_confirm", "강의 종료 여부를 입력해 주세요" ]
					,	[ "room_status", "강의실 사용 여부 입력해 주세요" ]
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">강의관리</span> 
								<a href="../std/lectureList.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 강의목록 select문 빼야될 수도 있어서 메모 -->
						<p class="conTitle" id="lectureSearch">
							<span>강의관리</span> <span class="fr"> 
							    <select name="lectureName" id="lectureName" v-model="lectureName" style="width: 150px;"></select>
							    
								마감인원	
		     	                <input type="text" style="width: 300px; height: 25px;" id="searchWord" name="searchWord" v-model="searchWord" placeholder="숫자만 입력하세요." onkeydown="fFilterNumber(event);">                    
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"  @click.prevent="lectureListSearch()"><span>검  색</span></a>
			                    <a href="" class="btnType blue" @click.prevent="fn_lectureSelect()" name="modal"><span>강의 등록</span></a>
			                    <span style="margin: 10px; "><input type="checkbox" id="depositCheck" true-value="Y" false-value="N" v-model="depositCheck" @Change = "lectureListSearch()" > 종료여부 </span>
			                    
							</span> 
						</p>
						
						<div class="divLectureList" id = "lectureList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강사명</th>
										<th scope="col">강의명</th>
										<th scope="col">강의실</th>
										<th scope="col">강의 시작날짜</th>
										<th scope="col">강의 종료날짜</th>
										<th scope="col">모집인원</th>
										<th scope="col">마감인원</th>
										<th scope="col">종료여부</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan="9">데이터가 존재하지 않습니다.</td>
										</tr>
									</tbody>	
								</template>
								<template v-else>
									<tbody v-for="(item,index) in listitem">
										<tr>
											<td>{{item.teacher_name}}</td>
											<td><a href="" @click.prevent="fn_studentListSearch(item.lecture_seq)">{{item.lecture_name}}</a></td>
											<td>{{item.room_name}}</td>
											<td>{{item.lecture_start}}</td>
											<td>{{item.lecture_end}}</td>
											<td>{{item.lecture_person}}</td>
											<td>{{item.lecture_total}}</td>
											<td>{{item.lecture_confirm}}</td>
											<td>
											<a href="" class="btnType3 color1" @click.prevent="fn_lectureSelect(item.lecture_seq)"><span>수정</span></a>
										</td>
										</tr>
									</tbody>
								</template>
							</table>
	
						<div class="paging_area"  id="lecturePagination" v-html="pagenavi"> </div>
						</div>
						<br><br><br> 
						
						<div id="studentList" v-show="studentList">
						
						<p class="conTitle">
							<span>학생정보</span> <span class="fr"> 
							</span>
						</p>
						
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	     
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">학생명</th> 
										<th scope="col">아이디</th>
										<th scope="col">과정명</th>
										<th scope="col">전화번호</th>
									</tr>
								</thead>
									<template v-if="totalcnt === 0">
										<tbody>
											<tr>
												<td colspan="5">데이터가 존재하지 않습니다.</td>
											</tr>
										</tbody>
									</template>
									<template v-else>
										<tbody v-for="(item,index) in listitem">
											<tr>
												<td>{{item.lecture_seq}}</td>
												<td>{{item.name}}</td>
												<td>{{item.loginID}}</td>
												<td>{{item.lecture_name}}</td>
												<td>{{item.hp}}</td>
											</tr>
										</tbody>
									</template>
							</table>

						<div class="paging_area"  id="studentPagination" v-html="pagenavi"> </div> 
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
            <strong>강의 관리</strong>
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
                     <th scope="row">강사ID <span class="font_red">*</span></th>    
                     <td v-show="loginIDShow1"><select name='loginID' id='loginID' v-model='sloginID' style='width: 150px;'></select></td>
                     <td v-show="loginIDShow2" colspan="3"><input type='text' class='inputTxt p100' name='loginID' v-model='loginID' id='loginID'  readonly /></td>
                  </tr>
                   <tr>
                     <th scope="row">시험과목 <span class="font_red">*</span></th>
                     <td v-show="loginIDShow1"><select name='test_no' id='test_no' v-model='stest_no' style='width: 150px;'></select></td>
                     <td v-show="loginIDShow2" colspan="3"><input type='text' class='inputTxt p15' name='test_no' v-model='test_no' id='test_no'  readonly /> Test 명 : {{test_title}} </td>
                  </tr>
                  <tr>
                     <th scope="row">강의실 <span class="font_red">*</span></th>
                     <td v-show="loginIDShow1"><select name='room_no' id='room_no' v-model='sroom_no' style='width: 150px;'></select></td>
                     <td v-show="loginIDShow2" colspan="3"><input type='text' class='inputTxt p15' name='room_no' v-model='room_no' id='room_no'  readonly />강의실 명 : {{room_name}}</td>
                  </tr> 
                  <tr>
                     <th scope="row">마감인원 </th>
                     <td colspan="3"><input type="text" class="inputTxt p100"
                        name="lecture_total" id="lecture_total" v-model="lecture_total" placeholder="숫자만 입력하세요." onkeydown="fFilterNumber(event);"/></td>
                  </tr>
                  <tr>
                     <th scope="row">강의 시작날짜</th>
                     <td><input type="date" class="inputTxt p100"
                        name="lecture_start" id="lecture_start" v-model="lecture_start" style="font-size: 15px" /></td>
                     <th scope="row">강의 종료날짜</th>
                     <td><input type="date" class="inputTxt p100"
                        name="lecture_end" id="lecture_end" v-model="lecture_end" style="font-size: 15px" /></td>
                  </tr>
                  <tr>
                     <th scope="row">수업목표 </th>
                     <td colspan="3"><input type="text" class="inputTxt p100"
                        name="lecture_goal" id="lecture_goal" v-model="lecture_goal" /></td>
                  </tr>
                  <tr>
                     <th scope="row">강의 종료여부 </th>
                     <td colspan="3"> <input type='radio' style='margin-left:121px'  class='inputTxt p15' name='lecture_confirm'
                      v-model='lecture_confirm' id='lecture_confirm' value='Y'  /><label>Y</label>
                      <input type='radio' class='inputTxt p15' name='lecture_confirm' v-model='lecture_confirm' id='lecture_confirm' value='N'  />
                      <label>N</label>  
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">강의실 사용여부 </th>
                     <td colspan="3"><input type='radio' style='margin-left:121px'  class='inputTxt p15' name='room_status' id='room_status' v-model='room_status'
                      value='Y' /><label>Y</label>
                      <input type='radio' class='inputTxt p15' name='room_status' v-model='room_status' id='room_status' value='N' /> 
                      <label>N</label>
                     </td>
                  </tr> 
               </tbody>
            </table> 

            <!-- e : 여기에 내용입력 -->

            <div class="btn_areaC mt30">
               <a href="" class="btnType blue" id="btnSaveLecture" name="btn" @click.prevent="fn_SaveLecture()"><span>저장</span></a>
              <!--  <a href="" class="btnType gray" id="btnDeleteLecture" name="btn"><span>삭제</span></a> --> 
               <a href=""   class="btnType gray"  id="btnCloseLecture" name="btn" @click.prevent="gfCloseModal()"><span>취소</span></a>
            </div>
         </dd>
      </dl>
      <a href="" class="closePop" @click.prevent="gfCloseModal()"><span class="hidden">닫기</span></a>
   </div>

 
   <!--// 모달팝업 -->

</form>
</body>
</html>