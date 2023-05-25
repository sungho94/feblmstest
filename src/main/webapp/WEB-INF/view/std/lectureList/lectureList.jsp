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

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeLecture = 5;
	var pageBlockSizeLecture = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("lecture_no", "lectureName", "all", "");
		
		lectureListSearch();
		
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
					studentInsert();
					break;
				case 'btnCloseLecture' :
					gfCloseModal();
					break;
			}
		});
	}
	
function lectureListSearch(pagenum) {
		
		pagenum = pagenum || 1;
		
		//alert(pagenum);
		
		var param = {
				pagenum : pagenum,
				pageSize : pageSizeLecture,
				lectureName : $("#lectureName").val()
		};
		
		var listcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			$("#listLecture").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSizeLecture, pageBlockSizeLecture, 'lectureListSearch');
			
			$("#lecturePagination").empty().append(paginationHtml);
			
		};
		
		callAjax("/std/lectureListSearch.do", "post" , "text", "false", param, listcallback);

	}
	
	function fn_lectureListSearch(lectureSeq){
		
		var param = {
				lectureSeq : lectureSeq
		}
		console.log(param);
		
		var resultcallback = function(data) {
			console.log("resultcallback : " + JSON.stringify(data));
			
/* 			$("#listPlan").empty().append(data); */
			
			$("#action").val("I");
			
			fn_initForm(data.lectureSelect);
			
			fn_lecturePlanSearch(lectureSeq);
			
			gfModalPop("#layer1"); 
			
		}
		callAjax("/std/lectureSelect.do", "post" , "json", true, param, resultcallback);
		
		
		
	}
	
	function fn_lecturePlanSearch(lectureSeq){
		
		var param = {
				lectureSeq : lectureSeq
		}
		console.log(param);
		
		var planCallback = function(data) {
			console.log("resultcallback : " + JSON.stringify(data));
			
 			$("#listPlan").empty().append(data);
			
			
		}
		callAjax("/std/lecturePlanSelect.do", "post" , "text", "false", param, planCallback);
		
	}
	
	function fn_initForm(data){
		
		console.log("data : " + data);
		
        var inhtml =  "<input type='text' class='inputTxt p100' name='lecture_name' id='lecture_name'  readonly />";			
		$("#lectureNameDiv").empty().append(inhtml) ;
		
		var inhtml2 = "<input type='text' class='inputTxt p100' name='teacher_name' id='teacher_name'  readonly />"			
		$("#teacherNameDiv").empty().append(inhtml2) ;
		
		var inhtml3 = "<input type='text' class='inputTxt p100' name='lecture_start' id='lecture_start'  readonly />"			
		$("#lectureStartDiv").empty().append(inhtml3) ;
		
		var inhtml4 =  "<input type='text' class='inputTxt p100' name='lecture_end' id='lecture_end' readonly />";			
		$("#lectureEndDiv").empty().append(inhtml4) ;
		
		var inhtml5 =  "<input type='text' class='inputTxt p100' name='lecture_person' id='lecture_person' readonly />";			
		$("#lecturePersonDiv").empty().append(inhtml5) ;
		
		var inhtml6 =  "<input type='text' class='inputTxt p100' name='lecture_total' id='lecture_total' readonly />";			
		$("#lectureTotalDiv").empty().append(inhtml6) ;
		
		var inhtml7 =  "<input type='text' class='inputTxt p100' name='lecture_goal' id='lecture_goal' readonly />";			
		$("#lectureGoalDiv").empty().append(inhtml7) ;
		
		var inhtml8 =  "<input type='text' class='inputTxt p100' name='room_name' id='room_name' readonly />";			
		$("#roomNameDiv").empty().append(inhtml8) ;
		

		$("#lecture_name").val(data.lecture_name);
		$("#teacher_name").val(data.teacher_name);
		
		$("#lecture_person").val(data.lecture_person);
		$("#lecture_total").val(data.lecture_total);
		$("#lecture_start").val(data.lecture_start);
		$("#lecture_end").val(data.lecture_end);
		$("#lecture_goal").val(data.lecture_goal);
		$("#room_name").val(data.room_name);
		$("#lectureSeq").val(data.lecture_seq);
		$("#loginID").val(data.loginID);
		$("#plan_week").val(data.plan_week);
		$("#plan_goal").val(data.plan_goal);
		$("#plan_content").val(data.plan_content);
			
		/* if(data.cnt == 1) {
			$("#btnSaveLecture").hide();				
		} else {
			if(data.lecture_person >= data.lecture_total){
				$("#btnSaveLecture").hide();
			}else{
				$("#btnSaveLecture").show();
			}    
		}	 */
		 if(data.cnt == 1){
			 $("#btnSaveLecture").hide();
		 }else{
			 if(Number(data.lecture_person) >= Number(data.lecture_total)){
				 $("#btnSaveLecture").hide();
			 }else{
				 $("#btnSaveLecture").show();
			 }
		 }
		
	}
	
	function studentInsert(){
		
		var action = $("#action").val();
		var param={
				action : $("#action").val(),
				lectureSeq : $("#lectureSeq").val(),
				loginID : $("#loginID").val()
		}
		
			var saveCallback = function(data){
    		
    		console.log("saveCallback : " + JSON.stringify(data));
    		
    		if(data.result == "INSERT"){
    	        alert("저장 되었습니다.");
    	        
    	        gfCloseModal();
    	        
    	        lectureListSearch();
    	         
    		}else{
    			alert("실패 되었습니다.");
    			return false;
    		}
    	}
		callAjax("/std/studentInsert.do", "post", "json", true, param, saveCallback);
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="lectureSeq" id="lectureSeq" value="">
	<input type="hidden" name="action" id="action" value="">
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의목록</span> 
								<a href="../std/lectureList.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 강의목록 select문 빼야될 수도 있어서 메모 -->
						<p class="conTitle">
							<span>강의목록</span> <span class="fr"> 
							    <select name="lectureName" id="lectureName" style="width: 150px;"></select>
			                    <a href="" class="btnType blue" id="btnSearchLecture" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divLectureList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
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
									</tr>
								</thead>
								<tbody id="listLecture"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecturePagination"> </div>
						
						
						
						
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
					<strong>강의 신청</strong>
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
								<th scope="row">과목 </th>
								<td><div id="lectureNameDiv">  </div></td>
								<th scope="row">강사명 </th>
								<td><div id="teacherNameDiv">  </div></td>
							</tr>
							<tr>
								<th scope="row">강의 시작일 </th>
								<td><div id="lectureStartDiv">  </div></td>
									<th scope="row">강의 마감일 </th>
								<td><div id="lectureEndDiv">  </div></td>
							</tr>
							<tr>
								<th scope="row">모집인원 </th>
								<td><div id="lecturePersonDiv">  </div></td>
									<th scope="row">마감인원 </th>
								<td><div id="lectureTotalDiv">  </div></td>
							</tr>
							<tr>
								<th scope="row">수업목표</th>
								<td><div id="lectureGoalDiv">  </div></td>
								<th scope="row">강의실</th>
								<td><div id="roomNameDiv">  </div></td>
							</tr>
							<tr>
								<th scope="row">강의계획</th>
								<td colspan="3"><div id="lecturePlanDiv">
								
								<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="60%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주 차수</th>
										<th scope="col">학습목표</th>
										<th scope="col">학습내용</th>
									</tr>
								</thead>
								<tbody id="listPlan"></tbody>
							</table>
						</div>
							</td>
							</tr>
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveLecture" name="btn"><span>신청</span></a> 
						<a href=""	class="btnType gray"  id="btnCloseLecture" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>