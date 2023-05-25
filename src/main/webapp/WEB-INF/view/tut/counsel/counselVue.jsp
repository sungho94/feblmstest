<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	var searcharea;
	var counselarea;
	var stuarea;
	var layer1;
	var layer2;
	var layer3;
	
	/** OnLoad event */ 
	$(function() {
		
		//vue init 등록
		init();
		
		//상단 강의목록
		lectureList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnInsert' :
					fn_modalPop();
					break;
				case 'btnModify' :
					fn_modifyPop();
				break;
				case 'btnSave1' : //layer1(신규등록)의 저장버튼
					//saveCounsel();
					insertCounsel(layer1.action); //I 값을 아예 넣어줌
					break;
				case 'btnSave' : //layer2(수정) 의 저장버튼
					updateCounsel(layer3.action); //U 값을 아예 넣어줌
					break;
				case 'btnDelete' :
					layer2.action = "D";
					updateCounsel(layer2.action); //D 값을 아예 넣어줌
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init(){
		
		//검색어 부분
		searcharea = new Vue({
			el : "#searcharea",
			data : {
				search : "",
			},
		}),
		
		//상단 강의 정보 표시() 
		counselarea = new Vue({
			el : "#counselarea",
			data : {
				listitem : [],
				page : 0,
				pageSize : 5,
				pageBlockSize : 10,
				totalCnt : 0,
				pagenavi : "",
			},
			methods : {
				//상담일지(상단)에서 강의명을 눌렀을 때 lecseq, lecname을 넘겨준다. (backUP 받는 부분)
				fn_backUP : function (lecseq, lecname){
					fn_backUP(lecseq, lecname); //넘겨주는거 확인
				},
				
			},
		})
		//하단 학생목록 부분 
		stuarea = new Vue({
			el : "#stuarea",
			data : {
				listitem : [],
				page : 0,
				pageSize : 5,
				pageBlockSize : 10,
				totalCnt : 0,
				lecture_seq : 0,
				pagenavi : "",
				lecseq : "",	//학생의 lecseq 등록
				lecname : "",	//학생의 lecname 등록
				consultant_no : "", //학생의 상담번호 등록
			},
			methods : {
				//신규등록 버튼을 눌렀을 때 consultant_no 를 넘겨준다.
				fn_modalPop : function (consultant_no) {
					fn_modalPop(consultant_no);
				},
				//수정 버튼을 눌렀을 때 consultant_no를 넘겨준다.
				/* fn_modifyPop : function (consultant_no){
					console.log("수정버튼시");
					fn_modifyPop(consultant_no);
				} */
			}
		})
		
		//신규등록 모달팝업
		layer1 = new Vue({
			el : "#layer1",
			data : {
				lecbyuserall2 : "",
				lectureName : "",
				loginIdDiv : "",
				stu_loginID : "",
				lecseq : "",
				counselDate : "",
				counselWriteDate : "",
				counselContent : "",
				action : "",
			},
		})
		
		//상담 디테일 모달팝업
		layer2 = new Vue({
			el:"#layer2",
			data : {
				lectureDetailName : "",
				studentDetailName : "",
				counselDetailDate : "",
				counselDetailWritelDate : "",
				counselDetailContent : "",
				action : "",
			}
		})
		//수정 모달팝업
		layer3 = new Vue({
			el : "#layer3",
			data : {
				consultant_no : "",
				lectureModifyName : "",
				studentModifyName : "",
				counselModifyDate : "",
				counselModifyWritelDate : "",
				counselModifyContent : "",
				action : "",
			}
		})
	}
	
	//상단 강의 목록
	function lectureList(pageNum) {
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : counselarea.pageSize,
				loginID : '${loginID}',		//로그인한 아이디(현재 로그인한 강사의 강의를 불러와야 하기 때문)
				search : searcharea.search, // 검색어 입력 부분 
		}
		
		console.log(param);
		
		var listCallBack = function(data){
			console.log("lectureList 강의 data 값 : " + JSON.stringify(data));
			
			counselarea.page = pageNum;
			counselarea.listitem = data.counselLectureList;
			counselarea.totalCnt = data.totalcnt;
			
			var paginationHtml = getPaginationHtml(pageNum, counselarea.totalCnt, counselarea.pageSize, counselarea.pageBlockSize, 'lectureList');
			counselarea.pagenavi = paginationHtml;
		}
		callAjax("/tut/vuecounselLectureList.do", "post", "json", true, param, listCallBack);
	}
	
	//상담일지(상단)에서 강의명을 눌렀을 때 lecseq, lecname을 넘겨준다. (backUP 받는 부분)
	function fn_backUP(lecseq, lecname){
		
		console.log("강의 seq 와 name 백업 받는 부분!!!!!!!");
		console.log(lecseq, lecname);
		
		//학생 부분에서 lecseq 와 lecname을 백업 받는다.
		stuarea.lecseq = lecseq;
		stuarea.lecname = lecname;
		
		studentList();
	}
	
	//하단 해당 강의에 대한 학생 목록
	function studentList(pageNum){
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : stuarea.pageSize,
				loginID : '${loginID}',
				lecture_seq : stuarea.lecseq,	//mapper와 이름 맞춰줌
		}
		console.log(param); //가져옴
		
		var studentListCallBack = function(data){
			console.log("studentList의 data : " + JSON.stringify(data));
			
			stuarea.page = pageNum;
			stuarea.listitem = data.counselStudentList;
			stuarea.totalCnt = data.totalCnt;
			
			var paginationHtml = getPaginationHtml(pageNum, stuarea.totalCnt, stuarea.pageSize, stuarea.pageBlockSize, 'studentList');
			stuarea.pagenavi = paginationHtml;
		}
		callAjax("/tut/vuecounselStudentList.do", "post", "json", true, param, studentListCallBack);
	}
	
	//모달 팝업 상담번호 유무에 따라 다른 모달창 뜨게
	function fn_modalPop(consultant_no){
		console.log(consultant_no);
		
		stuarea.consultant_no = consultant_no;
		
		if(consultant_no == "" || consultant_no == null || consultant_no == undefined){
			console.log("없습니다~~");
			
			layer1.action = "I";
			
			//폼 초기화
			fn_form();
		} else {
			console.log("있습니다~~");
			
			layer3.action = "U";
			//학생 상세보기
			detailStudent(consultant_no);
		}
		
	}
	
	//(하단)학생 디테일 상세목록 
	function detailStudent(consultant_no){
		
		var param = {
				consultant_no : consultant_no
		}
		
		console.log(param);
		
		var detailStudentCallBack = function(data){
			console.log("detailStudentCallBack 의 data : "+ JSON.stringify(data)); //가져오는거 확인
			
			fn_form(data.detailStudent);
			//얘를 넘겨줘야 하는데, 넘겨주면 수정에서 한번 더 함.
			fn_modifyForm(data.detailStudent);
			
		}
		callAjax("/tut/vuedetailStudent.do", "post", "json", "false", param, detailStudentCallBack)
	}
	
	//신규 혹은 수정 Form
	function fn_form(data){
		console.log("fn_form 확인");
		console.log(JSON.stringify(data));
		
		if(data == null || data == "" || data == undefined){
			gfModalPop("#layer1"); //신규팝업
			layer1.action = "I";
			
			selectComCombo("lecseqUser", "lecbyuserall2", "all", "");
			
			layer1.lectureName = "";
			layer1.loginIdDiv = "";
			layer1.counselDate = "";
			layer1.counselWriteDate = "";
			layer1.counselContent = "";
		} else {
			gfModalPop("#layer2"); //상세보기 팝업
			
			layer2.lectureDetailName = data.lecture_Name;
			layer2.studentDetailName = data.studentName;
			layer2.counselDetailDate = data.consultant_counsel;
			layer2.counselDetailWritelDate = data.consultant_date;
			layer2.counselDetailContent = data.consultant_content;
		}
	}
	
	//수정 값 저장 및 팝업 열기
	function fn_modifyPop(consultant_no){
		
		layer3.action = "U";
		
		gfModalPop("#layer3");
	}
	
	// 수정 폼 작성
	function fn_modifyForm(consultant_no){
		layer3.lectureModifyName  = layer2.lectureDetailName;
		layer3.studentModifyName  = layer2.studentDetailName;
		layer3.counselModifyDate = layer2.counselDetailDate;
		layer3.counselModifyWritelDate =layer2.counselDetailWritelDate;
		layer3.counselModifyContent = layer2.counselDetailContent;
		//layer3.action = "U";
		
		//updateCounsel(layer3.action);
	}
	
	// 신규등록 만 해보쟈
	function insertCounsel(){
		
		console.log("lecseq : " + layer1.lecseq);
		
		var action = layer1.action;
		var lecture_seq = layer1.lecbyuserall2;
		var consultant_no = layer1.consultant_no;
		var loginID = '${loginID}'
		var stu_loginID = layer1.stu_loginID;
		var consultant_content = layer1.counselContent;
		var consultant_counsel = layer1.counselDate;
		var consultant_date = layer1.counselWriteDate;
		
		var param = {
				action : action,
				lecture_seq : lecture_seq,
				consultant_no : consultant_no,
				loginID : loginID,
				stu_loginID : stu_loginID,
				consultant_content : consultant_content,
				consultant_counsel : consultant_counsel,
				consultant_date : consultant_date,
		}
		
		var saveCounselCallBack = function(){
			gfCloseModal();
			location.reload();
		}
		callAjax("/tut/vuesaveCounsel.do", "post", "json", "false", param, saveCounselCallBack)
	}
	
	
	// 수정 만 해보쟈 수정은 됨 ㅠ
	function updateCounsel(action){
		
		console.log("lecseq : " + stuarea.lecseq);
		console.log("consultant_no : " + stuarea.consultant_no); //받아옴
		console.log("action : " + action);
		
		if(action == "U"){
			var action = "U";
			console.log("U값 받아왓을 때 성공!");
		} else if(action == "D" ){
			var action = layer2.action;
			console.log("D값 받아왓을 때 성공!");
		}
		
		var action = action;
		var consultant_content = layer3.counselModifyContent;
		var consultant_no = stuarea.consultant_no;
		
		var param = {
				action : action,
				consultant_content : consultant_content,
				consultant_no : consultant_no
		}
		
		console.log("update쪽 ?");
		console.log(param);
		
		var saveCounselCallBack = function(){
			gfCloseModal();
			location.reload(stuarea.page);
		}
		callAjax("/tut/vuesaveCounsel.do", "post", "json", "false", param, saveCounselCallBack)
	}
	
	//셀렉박스 꺼
	function lecbyuser() {
		console.log("들어왔다");
		userbylecseqCombo('userbylec',$("#lecbyuserall2").val(),'stuloginID','sel','');       
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="blecture_seq" id="blecture_seq" value="">
	<input type="hidden" name="bconsultant_no" id="bconsultant_no" value="">
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">상담</span> 
								<a href="../tut/counsel.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searcharea">
							<span>상담일지</span> <span class="fr"> 
							   <select id="select" name="select" style="width: 100px;" >
									<option value = "">전체</option>
									<option value = "lecture">강의명</option>
									<option value = "name">강사</option>
							    </select> 
		     	                <input type="text" style="width: 150px; height: 25px;" id="search" name="search" v-model="search">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn" ><span>검  색</span></a>
			                    <a href="" class="btnType blue" id="btnInsert" name="btn"><span>신규등록</span></a>
							</span>
						</p>
						
						<div id = "counselarea">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="35%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명(ID)</th>
										<th scope="col">강의기간</th>
										<th scope="col">강의실</th>
									</tr>
								</thead>
								<template v-if="totalCnt == 0">
									<tbody>
										<tr>
											<td colspan=5>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<templete v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{item.lecture_seq}}</td> <!-- 강의 seq -->
											<td>
											<a href="" @click.prevent="fn_backUP(item.lecture_seq, item.lecture_Name)">
												{{item.lecture_Name}}
											</a>
											</td> <!-- 강의명 -->
											<td>{{item.tchLoginID}}</td> <!-- 강사명 -->
											<td>{{item.lecture_start}} &#126; {{item.lecture_end}}</td> <!-- 강의기간 -->
											<td>{{item.room_name}}</td> <!-- 강의실 -->
										</tr>
									</tbody>
								</templete>
								<template>
									<tbody>
										<tr>
										</tr>
									</tbody>
								</template>
								
							</table>
							<div class="paging_area"  id="lectureListPagination" v-html="pagenavi"> </div>
						</div>
						
						<br><br><br><br><br>
						
						<div id ="stuarea">
							<p class="conTitle">
								<span>학생 목록</span>
							</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">상담 번호</th>
										<th scope="col">학생 명(ID)</th>
										<th scope="col">수강 강의</th>
										<th scope="col">상담일자</th>
										<th scope="col">작성일자</th>
										<th scope="col">강사(ID)</th>
									</tr>
								</thead>
								<template v-if="totalCnt == 0">
									<tbody>
										<tr>
											<td colspan=6>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<templete v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{item.consultant_no}}</td> <!-- 상담 번호 -->
											<td> <a href="" @click.prevent="fn_modalPop(item.consultant_no)">
												{{item.studentName}} ({{item.stuLoginID}})
												</a>
											</td> <!-- 학생명(ID) -->
											<td>{{item.lecture_Name}}</td> <!-- 수강 강의-->
											<td>{{item.consultant_counsel}}</td> <!-- 상담일자 -->
											<td>{{item.consultant_date}}</td> <!-- 작성일자 -->
											<td>{{item.teacherName}} ({{item.tchLoginID}})</td> <!-- 강사(ID) -->
										</tr>
									</tbody>
								</templete>
							</table>
							<div class="paging_area"  id="studentListPagination" v-html="pagenavi"> </div>
						</div>
						
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 신규 등록 모달 팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담 등록</strong>
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
							<th scope="row">강의명 <span class="font_red">*</span></th>
							<td><select name='lecbyuserall2' id='lecbyuserall2' style='width: 100px;' onchange='javascript:lecbyuser()' v-model="lecbyuserall2"></select></td>
							<th scope="row">학생명 <span class="font_red">*</span></th>
							<td><select name='stuloginID' id='stuloginID' style='width: 100px;' v-model="stu_loginID" > </select></td>
						</tr>
						<tr>
							<th scope="row">상담일자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100"
								name="counselDate" id="counselDate" v-model="counselDate" /></td>
							<th scope="row">작성일자 <span class="font_red">*</span></th>
							<td id ="counselWriteDate" v-model="counselWriteDate">
								<c:set var="ymd" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
						<tr>
							<th scope="row">상담내용 <span class="font_red">*</span>
							<td colspan=3>
							<textarea class="inputTxt p100" id = "counselContent" v-model="counselContent" >
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave1" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 신규등록 모달 팝업 -->
	
	<!-- 상세보기 모달 팝업 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상세보기</strong>
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
							<th scope="row">강의명 </th>
							<td><div id = "lectureDetailName" v-html="lectureDetailName"></div></td>
							<th scope="row">학생명 </th>
							<td><div id = "studentDetailName" v-html="studentDetailName"></div></td>
						</tr>
						<tr>
							<th scope="row">상담일자</th>
							<td><div id = "counselDetailDate" v-html="counselDetailDate"></div></td>
							<th scope="row">작성일자 </th>
							<td ><div id = "counselDetailWritelDate" v-html="counselDetailWritelDate"></div></td>
						</tr>
						<tr>
							<th scope="row">상담내용</th>
							<td colspan=3>
							<div id = "counselDetailContent" v-html="counselDetailContent">
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnModify" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 상세보기 모달 팝업 -->
	
	<!-- 수정 모달 팝업 -->
	<div id="layer3" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담 수정</strong>
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
							<th scope="row">강의명 </th>
							<td><div id = "lectureModifyName" v-html="lectureModifyName"></div></td>
							<th scope="row">학생명 </th>
							<td><div id = "studentModifyName" v-html="studentModifyName"></div></td>
						</tr>
						<tr>
							<th scope="row">상담일자</th>
							<td><div id = "counselModifyDate" v-html="counselModifyDate"></div></td>
							<th scope="row">수정일자 </th>
							<td id ="counselModifyWritelDate" v-model="counselModifyWritelDate">
								<c:set var="ymd" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
						<tr>
							<th scope="row">상담내용</th>
							<td colspan=3>
							<textarea class="inputTxt p100" id = "counselModifyContent" v-model="counselModifyContent" >
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 수정 모달팝업 -->
</form>
</body>
</html>