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

	//변수 선언
	var tsearcharea;
	var tlistarea;
	var exlist;
	var extList;
    var layer1;
    var layer2;
	// 시험 페이징 설정
	//var pageSizeTest = 5;
	//var pageBlockSizeTest = 5;
	
	/* // 문제 페이징 설정
	var pageSizeQuestion = 5;
	var pageBlockSizeQuestion = 10; */
	
	
	/** OnLoad event */ 
	$(function() {
		console.log($("#bkpagenum").val())
		
		init();
		
		searchTest();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	function init() {
		
		tsearcharea = new Vue({
			el : "#tsearcharea",
			data : {
				testSearch : "",
				tflag : true,
			}
		});
		
		tlistarea = new Vue({
			el : "#tlistarea",
            data : {
            	       listitem : [],
            	       totalcnt : 0,
            	       cpage :0,      //현재 조회하고있는 page
            	       pagesize : 5,
            	       blocksize : 10,//pagenavigation 번호 몇까지 나오는지
            	       pagenavi : "", // vhtml 연결할 놈이어서 str로
            	       tflag : true,
            } , methods : {
            	questionListSearch : function(test_no) {
            		questionListSearch(test_no);
               	 },
               	fn_selectTest : function(test_no){
					fn_selectTest(test_no);
				}
            }
		});
		
		exList = new Vue ({
			el : "#exList",
			data : {
					listitem : [],
	     	        totalcnt : 0,
	     	        cpage :0,      //현재 조회하고있는 page
	     	        pagesize : 5,
	     	        blocksize : 10,//pagenavigation 번호 몇까지 나오는지
	     	        pagenavi : "", // vhtml 연결할 놈이어서 str로
	     	        testno : 0,
	     	        exflag : false,

			},
			methods : {
				fn_selectQuestion : function(test_no,question_no){
					fn_selectQuestion(test_no,question_no);
				}
				
			}
			
		});
		
		extList = new Vue ({
			el : "#extList",
			data : {
				exflag : false,
			},
			
		});
		
		layer1 = new Vue({
			el : "#layer1",
			data : {
				test_no : 0,
				test_title : "",
				action : "",
				tdisflag : false,
				//loginID : $("#loginID").val(),
				//lecture_seq : $("#lecture_seq").val(),
			},
			
		});
		
		layer2 = new Vue({
			el : "#layer2",
			data : {
				qtest_no : 0,
				question_no : 0,
				question_answer : 0,
				question_score : 0,
				question_ex : "",
				question_one : "",
				question_two : "",
				question_three : "",
				question_four : "",
				action : "",
				qdisflag : false,
				//bkpagenum : $("#bkpagenum").val(),
				//qtest_no : 0,
				
			},
			
		});
		
		selectComCombo("test", "testSearch", "all", "");
		
		
	} //init
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSearch':
				searchTest();
				break;			
			case 'btnSaveTest':
				fSaveTest();
				break;
			case 'btnDeleteTest':
				layer1.action="D";
				fSaveTest();
				alert("삭제되었습니다.");
				console.log("삭제");
				break;
			case 'btnSaveQuestion':
				fSaveQuestion();
				alert("저장되었습니다.");
				break;
			case 'btnDeleteQuestion':
				layer2.action="D";
				fSaveQuestion();
				alert("삭제되었습니다.");
				break;
			case 'btnSearchTest':
				searchTest();
				break;
			case 'btnCloseTest':
			case 'btnCloseQuestion':
				gfCloseModal();
				break;
			}
		});
	}
	
	/* 시험목록 조회 */
	function searchTest(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			pagenum : pagenum,
			pageSize : tlistarea.pagesize,
			testSearch : tsearcharea.testSearch

		};

		var listcallback = function(treturndata) {
			console.log("treturndata : " + JSON.stringify(treturndata));
			
			tlistarea.listitem = treturndata.testList;
			tlistarea.totalcnt = treturndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(pagenum, tlistarea.totalcnt, tlistarea.pagesize, tlistarea.blocksize, 'searchTest');
			
			tlistarea.pagenavi = paginationHtml;
			
		};

		callAjax("/tut/vuetestList.do", "post", "json", "true", param,
				listcallback);
		
	};
	
	function questionListSearch(testno) {
		
		exList.testno = testno; // btest_no...?
		
		questionSearch();
	}
	
	/* 시험이름 클릭시 시험문제 관리 page */
	function questionSearch() {
		extList.exflag = true;
		exList.exflag = true;
		
		var param = {
			test_no : exList.testno
		};
		
		console.log(param);

		var listcallback = function(treturndata) {
			console.log("treturndata : " + JSON.stringify(treturndata));

			exList.listitem = treturndata.questionList
			exList.totalcnt = treturndata.qtotalcnt
			
			//var paginationHtml = getPaginationHtml(pagenum, exList.totalcnt, exList.pagesize, exList.blocksize, 'questionSearch');
			//exList.pagenavi = paginationHtml;
			
		};

		callAjax("/tut/vuequestionList.do", "post", "json", "true", param,
				listcallback);

	}
	
	/* 시험관리 신규등록 모달  */
	function fn_testRegPopup(test_no) {
			
			// 폼 초기화
			fn_initForm();

			// 모달 팝업
			gfModalPop("#layer1");

	}
	
	/* 시험관리 디테일 */
	function fn_selectTest(test_no) {
		
		layer1.test_no = test_no;
		
		param = {
			test_no : test_no
		};

		var selectcallback = function(selectresult) {
			console.log("selectcallback : " + JSON.stringify(selectresult));

			fn_initForm(selectresult.testInfo);

			// 모달 팝업
			gfModalPop("#layer1");
			selectComCombo("lecseqbyuser", "lecseqbyuserall", "all", "");  
			 
		}

		callAjax("/tut/testDetail.do", "post", "json", "true", param,
				selectcallback);
		
	};
	
	/* 시험관리 폼 초기화  */
	function fn_initForm(object) {

		if (object == "" || object == null || object == undefined) {
			layer1.action="I";
			layer1.tdisflag = false;

			layer1.test_no = ""; // << test 숫자 입력창 초기값을 0으로 할당?
			layer1.test_title = "";
			
		} else {
			layer1.action="U";
			layer1.tdisflag = true;
			
			
			layer1.test_no = object.test_no;
			layer1.test_title = object.test_title;

		}
	}
	
	/* 모달에서 저장 함수 */
	function fSaveTest() {

		console.log("저장");
		console.log(layer1.action);

		var param = {
			action : layer1.action,
			test_no : layer1.test_no,
			test_title : layer1.test_title,
			//loginID : layer1.loginID,
			//lecture_seq : layer1.lecture_seq
			
		};

		console.log("fSaveTest 의 매개변수 : "+JSON.stringify(param));

		var saveTestSave = function(savereturn) {
			console.log("saveTestSave: ", + JSON.stringify(savereturn));

			alert("저장되었습니다.");
			gfCloseModal();

			searchTest();
			
		}

		callAjax("/tut/testSave.do", "post", "json", "true", param,
				saveTestSave);

	};
	
	/* 시험문제(question) 모달 */
	function fn_questionPopup(test_no,question_no) {
		
			//시험문제(question) 폼 초기화
			fn_initQuestionForm();

			// 모달 팝업
			gfModalPop("#layer2");

	}
	
	/* 시험문제(question) 폼 초기화 */
	function fn_initQuestionForm(object) {
		
		test_no = exList.testno;
		//$("#qtest_no").val($("#btest_no").val());
		//console.log(test_no);

		if (object == "" || object == null || object == undefined) {
			
			layer2.action = "I";
			layer2.qdisflag = false;
			
			layer2.question_no = ""; 
			layer2.question_ex = "";
			layer2.question_answer = "";
			layer2.question_one = "";
			layer2.question_two = "";
			layer2.question_three = "";
			layer2.question_four = "";
			layer2.question_score = "";
			
		    
			
			//$("#btnDeleteQuestion").hide();
		} else {
			
			layer2.action = "U";
			layer2.qdisflag = true;

			layer2.question_no = object.question_no;
			layer2.question_ex = object.question_ex;
			layer2.question_answer = object.question_answer;
			layer2.question_one = object.question_one;
			layer2.question_two = object.question_two;
			layer2.question_three = object.question_three;
			layer2.question_four = object.question_four;
			layer2.question_score = object.question_score;
			
		}
	}
	
	/* 시험문제(question) 디테일 */
	function fn_selectQuestion(test_no,question_no) {
		
		var param = {
			test_no : test_no,
			question_no : question_no
		};

		var selectcallback = function(selectresult) {
			console.log("selectcallback : " + JSON.stringify(selectresult));

			fn_initQuestionForm(selectresult.questionInfo);

			// 모달 팝업
			gfModalPop("#layer2");

		}

		callAjax("/tut/questionDetail.do", "post", "json", "true", param,
				selectcallback);
	}
	
	/* question 모달 저장 */
	function fSaveQuestion() {

		console.log("저장");
		console.log(layer2.action);

		var param = {
			test_no: test_no,
			question_no: layer2.question_no,
			
			question_ex : layer2.question_ex,
			question_answer : layer2.question_answer,
			question_one : layer2.question_one,
			question_two : layer2.question_two,
			question_three : layer2.question_three,
			question_four : layer2.question_four,
			question_score : layer2.question_score,
			qaction : layer2.action
		};
		
		console.log("fSaveQuestion 의 매개변수 : "+JSON.stringify(param));

		var savecallback = function(selectresult) {
			console.log("selectcallback : " + JSON.stringify(selectresult));
			
			gfCloseModal();
			
			//questionListSearch($("#qtest_no").val());
			//questionSearch($("#bkpagenum").val());
			
			questionListSearch(test_no);
			questionSearch(exList.cpage);
		};

		callAjax("/tut/questionSave.do", "post", "json", "true", param,
				savecallback);
		
	};
	
 	function fn_Validateitem() {
		var chk = checkNotEmpty([ [ "question_ex", "문제를 입력해 주세요." ],
				[ "question_answer", "정답을 입력해 주세요" ] ]);

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
	<input type="hidden" name="qaction" id="qaction" value="">
	<input type="hidden" name="btest_no" id="btest_no" value="">
	<input type="hidden" name="bkpagenum" id="bkpagenum" value="">
	<input type="hidden" name="loginID" id="loginID" value="${loginId}"><!-- 시험 시작날짜와 종료날짜 업데이트에 필요함-->
	<input type="hidden" name="lecture_seq" id="lecture_seq" value="" > <!-- 시험 시작날짜와 종료날짜 업데이트에 필요함-->
	
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
								<a href="../tut/test.do" class="btn_set refresh">새로고침</a>
						</p>
						
						
						<!-- div test는 시험명을 클릭했을때 사라지고,,, div question(문제목록)이 떠야한다  -->
						<div>
						<p class="conTitle" id="tsearcharea" v-show="tflag">
							<span>시험 관리</span> <span class="fr"> 
							   <select id="testSearch" name="testSearch" v-model="testSearch" style="width: 150px;" onchange="javascript:searchTest();">
							    </select> 
							            
			                    <!-- <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a> -->
							    <a class="btnType blue" href="javascript:fn_testRegPopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<div id="tlistarea" v-show="tflag">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<%-- <col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%"> --%>
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">시험이름</th>
										<th scope="col"></th>
										<!-- <th scope="col">시험시작일</th>
										<th scope="col">시험종료일</th> -->
									</tr>
								</thead>
								
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=3> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								
								<template v-else>
									<tbody v-for = "(item, index) in listitem">
										<tr >
											<td>{{ item.test_no }}</td>
											<td>
												<a href="" @click.prevent="questionListSearch(item.test_no)">{{ item.test_title }}</a>
											</td>
											<td>
												<a href="" class="btnType3 color1" @click.prevent="fn_selectTest(item.test_no)">
												<span>수정</span>
												</a>
											</td>
										</tr>
									</tbody>
								</template>
							</table>
						<div class="paging_area"  id="testListPagination" v-html="pagenavi"> </div>
						</div>
	
						</div><!-- div test 의 끝 -->
						<br>
						<br>
						<!-- div question(문제목록) -->
						<div id="question">
						<p id="extList" class="conTitle" v-show="exflag">
							<span>시험문제 관리</span> <span class="fr"> 
							  
							    <a	class="btnType blue" href="javascript:fn_questionPopup();" name="modal"><span>신규등록</span></a>
							    <a	class="btnType blue" href="javascript:history.go(0);" name="modal"><span>뒤로가기</span></a>
							</span>
						</p>
						
						<div id="exList" v-show="exflag">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								
									<%-- <col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%"> --%>
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">문제번호</th>
										<th scope="col">문제</th>
										<th scope="col">정답</th>
										<th scope="col">보기1</th>
										<th scope="col">보기2</th>
										<th scope="col">보기3</th>
										<th scope="col">보기4</th>
										<th scope="col">수정/삭제</th>
									
									</tr>
								</thead>
								<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=8> 조회된 데이터가 없습니다. </td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for = "(item, index) in listitem">
										<tr >
											<td>{{ item.question_no }}</td>
											<td>{{ item.question_ex }}</td>
											<td>{{ item.question_answer }}</td>
											<td>{{ item.question_one }}</td>
											<td>{{ item.question_two }}</td>
											<td>{{ item.question_three }}</td>
											<td>{{ item.question_four }}</td>
											<td>
												<a href="" class="btnType3 color1" @click.prevent="fn_selectQuestion(item.test_no,item.question_no)">
												<span>수정</span>
												</a>
											</td>

										</tr>
									</tbody>
								</template>
							</table>
						<!-- <div class="paging_area"  id="questionListPagination" v-html="pagenavi"> </div> -->
						</div>
	
						</div><!-- div question 의 끝 -->
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 시험상세 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>시험일자 등록 및 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">시험번호<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="test_no" id="test_no" v-model="test_no"/></td>
							<th scope="row">시험명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="test_title" id="test_title" v-model="test_title"/></td>
						</tr>
							<!-- <tr id ="CCC">
								<th scope="row">등록된 강의<span class="font_red">*</span></th>
								<a class="btnType3 color1" href="javascript:testDetailSelect();"  class="btnType blue" >강의검색</a>
								<td><select id="lecseqbyuserall" name="lecseqbyuserall"></select></td>
							</tr>
							
							<tr id ="DDD">
								<th scope="row">시험시작일<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="test_start" id="test_start" /></td>
								<th scope="row">시험종료일<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="test_end" id="test_end" /></td>
							</tr> -->
						<tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveTest" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteTest" name="btn" v-show="tdisflag"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseTest" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>


	<!-- 시험문제 모달-->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>시험문제 관리</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="80px">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<input type="hidden" name="qtest_no" id="qtest_no" v-model="qtest_no" value=""/> <!-- 시험번호 숨기기 -->
							<th scope="row">문제번호  <!-- <span class="font_red">*</span> --></th>
							<td><input type="text" class="inputTxt p100" id="question_no" name="question_no" v-model="question_no"/></td>
							<th scope="row" style="width : 40px;">정답<!-- <span class="font_red">*</span> --></th>
							<td><input type="text" class="inputTxt p100" id="question_answer" name="question_answer" v-model="question_answer"/></td>
							<th scope="row" style="width : 40px;">점수<!-- <span class="font_red">*</span> --></th>
							<td><input type="text"  class="inputTxt p100" id="question_score"  name="question_score" v-model="question_score"/></td>
						</tr>
						
						<tr>
							<th scope="row">문제</th>
							<td colspan="5"><input type="text" class="inputTxt p100"
								id="question_ex" name="question_ex" v-model="question_ex"/></td>
						</tr>
						<tr>
							<th scope="row">문제1</th>
							<td colspan="5"><input type="text" class="inputTxt p100"
								id="question_one" name="question_one" v-model="question_one"/></td>
						</tr>
						<tr>
							<th scope="row">문제2</th>
							<td colspan="5"><input type="text" class="inputTxt p100"
								id="question_two" name="question_two" v-model="question_two"/></td>
						</tr>
						<tr>
							<th scope="row">문제3</th>
							<td colspan="5"><input type="text" class="inputTxt p100"
								id="question_three" name="question_three" v-model="question_three"/></td>
						</tr>
						<tr>
							<th scope="row">문제4</th>
							<td colspan="5"><input type="text" class="inputTxt p100"
								id="question_four" name="question_four" v-model="question_four"/></td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveQuestion" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteQuestion" name="btn" v-show="qdisflag"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseQuestion" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>