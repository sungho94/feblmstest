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

	// 수강중인 강의 목록
	var pageSize = 5;
	var pageBlockSize = 5;
	
	
	/** OnLoad event */ 
	$(function() {
		comcombo("rm_seq", "rmseq", "all", "");
		
		testLectureList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					testLectureList();
					break;
			}
		});
	}
	
	// 강의 목록 조회
	function testLectureList(pageNum){
		
		pageNum = pageNum || 1;
		
		var param = {
				pageNum : pageNum,
				pageSize : pageSize,
				loginID : '${loginID}',
				select : $("#select").val(),
				search : $("#search").val()
		}
		var testLectureListCallBack= function(data){
			$("#lectureList").empty().append(data);
			
			var total = $("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(pageNum, total, pageSize, pageBlockSize, 'testLectureList');
			
			$("#lectureListPagination").empty().append(paginationHtml);
			
		}
		callAjax("/std/testLectureList.do", "post", "text", "false", param, testLectureListCallBack);
	}
	
	// 시험 문제 불러오기
	function fn_test(lecture_seq){
		
		var param = {
				lecture_seq : lecture_seq,
		}
		
		var testCallBack = function(data){
			console.log(data);
			$("#testQuestion").empty().append(data);
			gfModalPop("#testQuestion");
			
		}
		callAjax("/std/testQuestion.do", "post", "text", "false", param, testCallBack)
	}
	
	// 시험문제 저장
	function saveQuestion(){
		var saveQuestionCallBack = function(){
			gfCloseModal();
			location.reload();
			
		}
		callAjax("/std/saveQuestion.do", "post", "json", "false", $("#questionForm").serialize(), saveQuestionCallBack)
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험 관리</span> 
								<a href="../std/test.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>시험 응시</span> <span class="fr"> 
								<select id="select" name="select" style="width: 100px;" >
									<option value = "">전체</option>
									<option value = "lecture">강의명</option>
									<option value = "name">강사</option>
							    </select> 
		     	                <input type="text" style="width: 150px; height: 25px;" id="search" name="search">                    
			                    <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
			                    </span>
						</p>
						
						<div class="divComGrpCodList">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의 기간</th>
										<th scope="col">결과</th>
										<th scope="col">시험응시</th>
									</tr>
								</thead>
								<tbody id="lectureList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lectureListPagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	</form>

	<!-- 모달팝업 -->
	<form id="questionForm" action="" method="">	
		<div id="testQuestion" class="layerPop layerType2" style="width: 600px;"></div>
	<!--// 모달팝업 -->
	</form>
</body>
</html>