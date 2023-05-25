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
	var emppageSize = 5;
	var emppageBlockSize = 10;
	
	/** OnLoad event */ 
	$(function() {
		
		//취업 정보 등록(상단) 부분
		employclasssearchlist();
		
		//하단 학생에 대한 디테일리스트 부분 숨기기
		$("#studentdetailcontent").hide();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				//학생 신규등록 버튼
				case 'empnewpopup':
					$("#action").val("I");
					empnewpopup(stdID, stdname);
					break;
				//수정 >  수정완료 버튼
				case 'btnSaveempstudent':
					$("#action").val("I");
					fn_insertempstudent();
					break;
				//수정완료 버튼
				case 'btnUpdateempstudent' :
					$("#action").val("U");
					fn_btnempupdate();
					break;
				//검색 버튼
				case 'btnempstuSearch':
					employclasssearchlist();
					break;
				//닫기 버튼
				case 'btnCloseGrpCod' :
					gfCloseModal();
					break;
			}
		});
	}
	//취업정보등록(상단) list 보여주는 부분
	function employclasssearchlist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : emppageSize,
				empstuSearch : $("#empstuSearch").val()
		}
		
		console.log("employclasssearchlist 의 param : ", param);
		
		var listcallback = function (employclasslistdata){
			
			$("#detailstuclasslist").empty().append(employclasslistdata);
			
			var totalcnt = $("#totalcnt").val();
			
			//하단 페이지처리
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, emppageSize, emppageBlockSize, 'employclasssearchlist');
			$("#detailstudentclassPagination").empty().append( paginationHtml );
			
			//페이지 넘어갈 때 하단 디테일 내용 숨기기
			if(pagenum != totalcnt ){
				$("#studentdetailcontent").hide();
			}
		}
		
		callAjax("/adm/empclasslist.do", "post" , "text", "false", param, listcallback);
	}
	
	//취업 정보 등록(상단)에서 확인 버튼을 눌렀을 때
 	function fn_studentdetail(stdID, stdname){
		
		$("#stdID").val(stdID);
		$("#stdname").val(stdname);
		
		//하단 학생 디테일 리스트
		$("#studentdetailcontent").show();
		
		//하단의 emp디테일 데이터 불러오는것 연결
		empdetailsearch();
	}
	
	//하단 디테일 내용 보인은 곳.
	function empdetailsearch(){
		
		var param = {
				stdID : $("#stdID").val(),
				stdname : $("#stdname").val()
		}
		
		console.log("하단 디테일의 param:" ,param); //아이디, 이름 가져오는거 확인
		
		var listcallback= function(emplistdata){
			$("#detailempcontent").empty().append(emplistdata); //하단에 디테일 내용에 값
			console.log("emplistdata : ", emplistdata);
		}
		callAjax("/adm/detailcontent.do", "post" , "text", "false", param, listcallback);
	}
	
	// 하단 디테일에서 수정 버튼 누르면 action값 I와 팝업 뜨는 곳.
	function empnewpopup(){
		$("#action").val("I");
		gfModalPop("#layer2");
		
		//(신규)수정 버튼 눌렀을 때 모달 2에서 학생명, 아이디값 넣어주기.
		$("#emp_no").empty().append("");
		$("#stdempname").empty().append($("#stdname").val()); //이름 넘어옴
		$("#stdloginID").empty().append($("#stdID").val()); //아이디값은 넘어옴
		$("#emp_name").val("");
		$("input:radio[name=emp_state]:input[value='Y']").prop("checked", true);
		$("#emp_join").val("");
		$("#emp_leave").val("");
	}
	
	//신규등록> 등록완료 버튼 눌렀을 때 
	function fn_insertempstudent(){
		
		var param = {
				action : $("#action").val(),
				emp_no : $("#emp_no").val(),
				stdID : $("#stdID").val(),
				stdname : $("#stdname").val(),
				emp_name : $("#emp_name").val(),
				emp_state : $("input:radio[name=emp_state]:checked").val(),
				emp_join : $("#emp_join").val(),
				emp_leave :$("#emp_leave").val()
		}
		
		
		console.log("등록완료 버튼의 param", param);
		
		var saveCallBack = function(data){
			gfCloseModal();
			location.reload();
		}
		callAjax("/adm/empsave.do", "post", "json", "false", param, saveCallBack);
	}
	
	//학생 아이디 눌러주면 정보 수정(update)하기.
	function empupdate(emp_no, emp_name, emp_state, emp_join, emp_leave){
		console.log("detail :", emp_no, emp_name, emp_state, emp_join, emp_leave); //가져오는거 확인
		$("#emp_no").val(emp_no);
		$("#action").val("U");
		gfModalPop("#layer1");
		
		$("#upemp_no").empty().append(emp_no);
		$("#upstdempname").empty().append($("#stdname").val());
		$("#upstdloginID").empty().append($("#stdID").val());
		$("#emp_update_name").val(emp_name);
		$("input:radio[name=emp_update_state]:input[value="+emp_state+"]").prop("checked", true);
		$("#emp_update_join").val(emp_join);
		$("#emp_update_leave").val(emp_leave);
	}
	
	//하단 아이디 > 수정완료 버튼
	function fn_btnempupdate(){
		
		var param = {
				action : $("#action").val(),
				emp_no : $("#emp_no").val(),
				emp_name : $("#emp_update_name").val(),
				emp_state : $("input:radio[name=emp_update_state]:checked").val(),
				emp_join : $("#emp_update_join").val(),
				emp_leave :$("#emp_update_leave").val()
		}
		
		console.log("수정완료의 param : ", param);
		
		var saveCallBack = function(data){
			gfCloseModal();
			location.reload();
		}
		callAjax("/adm/empsave.do", "post", "json", "false", param, saveCallBack);
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="stdname" id="stdname" value="">
	<input type="hidden" name="stdID" id="stdID" value="">
	<input type="hidden" name="emp_no" id="emp_no" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 -->
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">취업관리</span> <span class="btn_nav bold">취업 정보</span> 
								<a href="../adm/employ.do" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle">
							<span>취업 정보 등록</span> <span class="fr"> 
		     	                <input type="text" style="width: 300px; height: 25px;" id="empstuSearch" name="empstuSearch" placeholder="학생 아이디로 검색">                    
			                    <a href="" class="btnType blue" id="btnempstuSearch" name="btn"><span>검  색</span></a>
							</span>
					</p>
					<div class="employclassList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="15%">
									<col width="25%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명</th>
										<th scope="col">연락처</th>
										<th scope="col">아이디</th>
										<th scope="col">가입일자</th>
										<th scope="col">확인</th>
									</tr>
								</thead>
								<tbody id="detailstuclasslist"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="detailstudentclassPagination"> </div>
						
						<br><br><br><br>
						
						<div id="studentdetailcontent">
						<p>
						<div id="detail_btn">
							<span class="fr">
		     	                <a href="javascript:empnewpopup()" class="btnType blue" id="emp_updqte_data" name="modal"><span>신규등록</span></a>
							</span>
						</div>
						</p>
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학번</th>
										<th scope="col">아이디(정보수정)</th>
										<th scope="col">학생명</th>
										<th scope="col">업체명</th>
										<th scope="col">재직여부(N/Y)</th>
										<th scope="col">입사일</th>
										<th scope="col">퇴사일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="detailempcontent"></tbody>
							</table>
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
				<strong>학생정보수정</strong>
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
							<th scope="col">학번</th>
							<td colspan="7"><div id="upemp_no"></div></td>
						</tr>
						<tr>
							<th scope="col">학생명</th>
							<td colspan="3"><div id="upstdempname"></div></td>
							<th scope="col">아이디</th>
							<td colspan="3"><div id="upstdloginID"></div></td>
						</tr>
						<tr>
							<th scope="col">업체명</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_update_name" name="emp_update_name" /></td>
							<th scope="col">재직여부</th>
							<td colspan="3">
							<input type="radio" id="radio1-1" name="emp_update_state" id="emp_update_state_1" value="Y" /> <label for="radio1-1">Y</label>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="radio1-2" name="emp_update_state" id="emp_update_state_2" value="N" /> <label for="radio1-2">N</label>
							</td>
						</tr>
						<tr>
							<th scope="col">입사일</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_update_join" name="emp_update_join" /></td>
							<th scope="col">퇴사일</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_update_leave" name="emp_update_leave" /></td>
						</tr>
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnUpdateempstudent" name="btn"><span>수정 완료</span></a>
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<div id="layer2" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>학생정보</strong>
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
							<th scope="col">학번</th>
							<td colspan="7"><div id="emp_no"></div></td>
						</tr>
						<tr>
							<th scope="col">학생명</th>
							<td colspan="3"><div id="stdempname"></div></td>
							<th scope="col">아이디</th>
							<td colspan="3"><div id="stdloginID"></div></td>
						</tr>
						<tr>
							<th scope="col">업체명</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_name" name="emp_name" /></td>
							<th scope="col">재직여부</th>
							<td colspan="3">
							<input type="radio" id="radio1-1" name="emp_state" id="emp_state_1" value="Y" /> <label for="radio1-1">Y</label>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="radio1-2" name="emp_state" id="emp_state_2" value="N" /> <label for="radio1-2">N</label>
							</td>
						</tr>
						<tr>
							<th scope="col">입사일</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_join" name="emp_join" /></td>
							<th scope="col">퇴사일</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="emp_leave" name="emp_leave" /></td>
						</tr>
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnSaveempstudent" name="btn"><span>등록완료</span></a>
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>