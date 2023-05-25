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
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lectureName", "all", "");	
		
		lectureListSearch();
		
		$("#divStudentList").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchLecture':
					lectureListSearch();
					break;
				case 'btnSaveLecture' :
					fn_SaveLecture();
					break;
				case 'btnUpdateLecture' :
					fn_SaveLecture();
					break;
/* 				case 'btnDeleteLecture' :
					$("#action").val("D");
					fn_SaveLecture();
					break; */
				case 'btnCloseLecture' :
					gfCloseModal();
					break;
			}
		});
	}
	//강의 목록 조회
	function lectureListSearch(pagenum) {
		console.log("lectureListSearch");
		
		pagenum = pagenum || 1;

		var checkBox;
		
		
		if ($("#depositCheck").is(":checked")) {
			//alert("checked");
			checkBox = "checked";
		} else checkBox = "";
	
		
		console.log(checkBox);
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				lectureName : $("#lectureName").val(),
				// checkBoxStatus : $("#depositCheck").val()
				checkBoxStatus : checkBox
		};
		
		console.log(param);
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#listLecture").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeLecture, pageBlockSizeLecture, 'lectureListSearch');
			
			$("#lecturePagination").empty().append(paginationHtml);
			
			$("#lectureSeq").val("");
			
			$("#divStudentList").hide();
		};
		
		callAjax("/adm/lectureManagementList.do", "post" , "text", "false", param, listcallback);

	}
	
	// 학생 목록 들어가기전 백업
	function fn_studentListSearch(lectureSeq){
		
		console.log(lectureSeq);
		
		$("#lectureSeq").val(lectureSeq);
		
		studentListSearch();
	}
	
 	function studentListSearch(pagenum){
		
 		$("#divStudentList").show();
 		
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeStudent,
				lectureSeq : $("#lectureSeq").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			 
			$("#listStudent").empty().append(returndata);
			
			var totalcnt = $("#stotalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeStudent, pageBlockSizeStudent, 'studentListSearch');

			$("#studentPagination").empty().append(paginationHtml);
			
			$("#bkpagenum").val(pagenum);
			
		};
		
		callAjax("/adm/studentManagementList.do", "post" , "text", "false", param, listcallback);
 	}
	//강의 등록 , 수정 버튼
	function fn_lecturePopup(lectureSeq){
		
		if(lectureSeq == null || lectureSeq == ""){
		
			$("#action").val("I");
			
			//강의 폼 초기화
			fn_initForm(); 
			
			//모달 팝업
			gfModalPop("#layer1");
		}else{
			$("#action").val("U");
			
			fn_lectureSelect(lectureSeq);
		}
	}
	
	//강의 insert, update마다 값
	function fn_initForm(selectLecture){
	
		console.log("selectLecture : " + selectLecture);

		if(selectLecture == null || selectLecture == ""){	
			
			$("#lecture_total").val("");
			$("#lecture_start").val("");
			$("#lecture_end").val("");
			$("#lecture_goal").val("");
			
			$("#lectureNo").val("");
			$("#lectureSeq").val("");
			$("#roomSeq").val("");
			//$("#btnDeleteLecture").hide();
			
			var inhtml =  "<select name='loginID' id='loginID' style='width: 150px;'></select>";
			$("#loginIdDiv").empty().append(inhtml) ;
			userCombo("usr", "B", "loginID", "sel", "");
			
			var inhtml2 =  "<select name='test_no' id='test_no' style='width: 150px;'></select>";
			$("#testNoDiv").empty().append(inhtml2) ;
			selectComCombo("test", "test_no", "sel", "");
			
			var inhtml3 =  "<select name='room_no' id='room_no' style='width: 150px;'></select>";
			$("#lectureRoomDiv").empty().append(inhtml3) ;
			selectComCombo("room:N", "room_no", "sel", "");	
			
			 var inhtml4 =  "<input type='radio' style='margin-left:121px'  class='inputTxt p15' name='lecture_confirm' id='lecture_confirm' value='Y' onclick='return(false);' /><label>Y</label><input type='radio' class='inputTxt p15' name='lecture_confirm' id='lecture_confirm' value='N' checked onclick='return(false);' /><label>N</label>";			
			$("#lectureConfirmDiv").empty().append(inhtml4) ;
			
			var inhtml5 =  "<input type='radio' style='margin-left:121px'  class='inputTxt p15' name='room_status' id='room_status' value='Y' onclick='return(false);' /><label>Y</label><input type='radio' class='inputTxt p15' name='room_status' id='room_status' value='N' checked onclick='return(false);' /><label>N</label>";	
			$("#roomStatusDiv").empty().append(inhtml5) ; 

		}else{
			
            var inhtml =  "<input type='text' class='inputTxt p100' name='loginID' id='loginID'  readonly />";			
			$("#loginIdDiv").empty().append(inhtml) ;
			
			var inhtml2 = "<input type='text' class='inputTxt p15' name='test_no' id='test_no'  readonly />"  + "Test 명 : " + selectLecture.test_title ;			
			$("#testNoDiv").empty().append(inhtml2) ;
			
			var inhtml3 = "<input type='text' class='inputTxt p15' name='room_no' id='room_no'  readonly />"  + "강의실 명 : " + selectLecture.room_name ;			
			$("#lectureRoomDiv").empty().append(inhtml3) ;
			
			 var inhtml4 =  "<input type='radio' style='margin-left:121px'  class='inputTxt p15' name='lecture_confirm' id='lecture_confirm1' value='Y'/><label>Y</label><input type='radio' class='inputTxt p15' name='lecture_confirm' id='lecture_confirm2' value='N' checked/><label>N</label>";			
			$("#lectureConfirmDiv").empty().append(inhtml4) ;
			
			var inhtml5 =  "<input type='radio' style='margin-left:121px'  class='inputTxt p15' name='room_status' id='room_status1' value='Y' checked/><label>Y</label><input type='radio' class='inputTxt p15' name='room_status' id='room_status2' value='N'/><label>N</label>";			
			$("#roomStatusDiv").empty().append(inhtml5) ;
			
			$("#loginID").val(selectLecture.loginID);
			$("#test_no").val(selectLecture.test_no); 
			$("#room_no").val(selectLecture.room_no); 
			$("input:radio[name=lecture_confirm]:input[value="+ selectLecture.lecture_confirm +"]").prop("checked", true);
			$("input:radio[name=room_status]:input[value="+ selectLecture.room_status +"]").prop("checked", true);
			/* $("#lecture_confirm").val(selectLecture.lecture_confirm);
			$("#room_status").val(selectLecture.room_status); */

			$("#lecture_total").val(selectLecture.lecture_total);
			$("#lecture_start").val(selectLecture.lecture_start);
			$("#lecture_end").val(selectLecture.lecture_end);
			$("#lecture_goal").val(selectLecture.lecture_goal);
			$("#lectureNo").val(selectLecture.lecture_no);
			$("#lectureSeq").val(selectLecture.lecture_seq);
			$("#roomSeq").val(selectLecture.room_seq);
			
			//$("#btnDeleteLecture").show();
			
			
		}
		
	}
	//강의 단건 조회
	function fn_lectureSelect(lectureSeq, roomSeq){
		
		var param = {
				lectureSeq : lectureSeq,
				roomSeq : roomSeq
		};
		
		var selectcallback = function(selectresult){
			console.log("selectresult : " + JSON.stringify(selectresult));	
			
			fn_initForm(selectresult.lectureInfo);
			
			//모달 팝업
			gfModalPop("#layer1");
		};
		
		callAjax("/adm/lectureSelect.do", "post" , "json", "false", param, selectcallback);
		
	}
	//강의 저장
	function fn_SaveLecture(){
		
		var action = $("#action").val();
		
		if(action == "I" || action == "U"){
			if(!fn_validateitem()){
				return;
			}
		}
		
		 if($("#lecture_start").val() != '' && $("#lecture_end").val() != ''){
			if($("#lecture_end").val().replaceAll("-", "") - $("#lecture_start").val().replaceAll("-", "") < 0){
				
				alert("올바른 기간을 선택해주세요.");
				
				gfCloseModal();
				
				return false;
			}
		}
		var param = {
				roomSeq : $("#roomSeq").val(),
				lectureSeq : $("#lectureSeq").val(),
				lectureNo : $("#lectureNo").val(),
				action : $("#action").val(),
				loginID : $("#loginID").val(),
				testNo : $("#test_no").val(),
				roomNo : $("#room_no").val(),
				lectureTotal : $("#lecture_total").val(),
				lectureStart: $("#lecture_start").val(),
				lectureEnd: $("#lecture_end").val(),
				lectureGoal: $("#lecture_goal").val(),
				lectureConfirm: $("input[name=lecture_confirm]:checked").val(),
				roomStatus: $("input[name=room_status]:checked").val()
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
						[ "loginID", "강사명을 입력해 주세요." ]
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
	
/* 	//강의 삭제 버튼 팝업
	function fn_lectureDeletePopup(lectureNo, loginID){
		if(lectureNo == null || lectureNo == "" || loginID == null || loginID == ""){
			alert("값이 없습니다.");
			
			gfCloseModal();
			
		}else{			
			$("#action").val("D");
			
			gfModalPop("#layer2");
			
		}
	} */
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lectureNo" id="lectureNo" value="">
	<input type="hidden" name="lectureSeq" id="lectureSeq" value="">
	<input type="hidden" name="roomSeq" id="roomSeq" value="">
	<input type="hidden" name="bkpagenum" id="bkpagenum" value="">
	
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
						<p class="conTitle">
							<span>강의관리</span> <span class="fr"> 
							    <select name="lectureName" id="lectureName" style="width: 150px;"></select>
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
			                    <a class="btnType blue" href="javascript:fn_lecturePopup();" name="modal"><span>강의 등록</span></a>
			                    <span style="margin: 10px; "><input type="checkbox" id="depositCheck" onChange = "lectureListSearch()"> 종료여부 </span>
			                    
							</span>
						</p>
						
						<div class="divLectureList">
							
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
								<tbody id="listLecture"></tbody>
							</table>
	
						<div class="paging_area"  id="lecturePagination"> </div>
						</div>
						<br><br><br>
						
						<div id="divStudentList">
						
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
								<tbody id="listStudent"></tbody>
							</table>

						<div class="paging_area"  id="studentPagination"> </div>
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
                     <td colspan="3"><div id="loginIdDiv">  </div></td>                       
                  </tr>
                  <tr>
                     <th scope="row">시험과목 <span class="font_red">*</span></th>
                     <td colspan="3"><div id="testNoDiv">  </div></td>
                  </tr>
                  <tr>
                     <th scope="row">강의실 <span class="font_red">*</span></th>
                     <td colspan="3"><div id="lectureRoomDiv">  </div></td>
                  </tr>
                  <tr>
                     <th scope="row">마감인원 </th>
                     <td colspan="3"><input type="text" class="inputTxt p100"
                        name="lecture_total" id="lecture_total" placeholder="숫자만 입력하세요." onkeydown="fFilterNumber(event);"/></td>
                  </tr>
                  <tr>
                     <th scope="row">강의 시작날짜</th>
                     <td><input type="date" class="inputTxt p100"
                        name="lecture_start" id="lecture_start" style="font-size: 15px" /></td>
                     <th scope="row">강의 종료날짜</th>
                     <td><input type="date" class="inputTxt p100"
                        name="lecture_end" id="lecture_end" style="font-size: 15px" /></td>
                  </tr>
                  <tr>
                     <th scope="row">수업목표 </th>
                     <td colspan="3"><input type="text" class="inputTxt p100"
                        name="lecture_goal" id="lecture_goal" /></td>
                  </tr>
                  <tr>
                     <th scope="row">강의 종료여부 </th>
                     <td colspan="3"> <div id="lectureConfirmDiv">  </div>
                     	
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">강의실 사용여부 </th>
                     <td colspan="3"> <div id="roomStatusDiv">  </div>
                     
                     </td>
                  </tr>
               </tbody>
            </table>

            <!-- e : 여기에 내용입력 -->

            <div class="btn_areaC mt30">
               <a href="" class="btnType blue" id="btnSaveLecture" name="btn"><span>저장</span></a>
              <!--  <a href="" class="btnType gray" id="btnDeleteLecture" name="btn"><span>삭제</span></a> --> 
               <a href=""   class="btnType gray"  id="btnCloseLecture" name="btn"><span>취소</span></a>
            </div>
         </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
   </div>

 
   <!--// 모달팝업 -->

</form>
</body>
</html>