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
	var qnalist;
	var qnadcontent;
	var replydata;
	var replyform;
	var newqna;

	// 그룹코드 페이징 설정
	var qnapageSize = 5;
	var qnapageBlockSize = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		init();
		
		userinfo();
		
		qnasearchlist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		conTitle.userType = "${userType}";
		
		
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveqan' :	
					fSaveqan();
					break;
				case 'btnDeleteqna' :
					newqna.action = "D"
					fSaveqan();
					break;
				case 'btnDeleteReply' :
					fsavereply();
					break;
				case 'btnSearchqna':
					qnasearchlist();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
				case 'btnCloseqna' :
					gfCloseModal();
				qnadcontent.show=false;
				replydata.show=false;
				qnasearchlist();
					break;
				case 'replysave' :
					fsavereply();
					break;
				case 'closePop' :
					gfCloseModal();
			}
		});
	}
	
	function init(){
		conTitle = new Vue({
			el : "#conTitle",
			data : {
				qnasearch : "",
				userType : "",
				loginID : "",
				bloginID : "",
				bname : "",
			},
			methods : {
				//qna 신규등록 버튼 클릭
				qnanewpopup : function(qnano){
					qnadcontent.show = false;
					qnadcontent.detail_btn_show = false;
					replydata.show = false;
					
					if(qnano == "" || qnano == null || qnano == undefined ){
						newqna.action = "I";
						fn_qnaForm(); //폼 초기화?
						//$("#qnadcontent").hide(); //신규등록 버튼 누르면서 이전 QnA 디테일 목록을 가린다.
						gfModalPop("#layer1"); //신규등록 버튼을 눌렀을 때 layer1 모달창이 뜬다.
						
					} else {
						newqna.action = "U";
						
						qnalist.fn_qnalistsearch(qnano);
						gfModalPop("#layer1");
					}
					
				}
			}
		});
		
		qnalist = new Vue({
			el : "#qnalist",
			data : {
				totalcnt : 0,
				listitem : [],
				pagenavi : "",
			},
			methods : {
				//qna 타이틀 눌렀을 때 세부사항이 나올 수 있게
				fn_qnalistsearch : function(qna_no){
					qnadcontent.qnano = qna_no;
					qnadcontent.show = true;
					replydata.show = true;
					qnalistsearch();
				}
			}
		});
		
		qnadcontent = new Vue({
			el : "#qnadcontent",
			data : {
				show : false,
				qnano : "",
				qna_title : "",
				name : "",
				qna_date : "",
                qna_count : "",
                qna_content : "",
                detail_login : "",
                detail_btn_show : false
			},
			methods : {
				fn_updateBackup : function(){
					var qnano = qnadcontent.qnano
					
					conTitle.qnanewpopup(qnano);
				}
			}
		});
		
		replydata = new Vue({
			el : "#replydata",
			data : {
				show : false,
				totalcnt : 0,
				itemlist : [],
				reply_no : "",
				action : "",
				reply_date : "",
				reply_content : "",
			},
			methods : {
				//삭제 버튼을 눌렀을 때
				fn_replydelete : function(qnano, rplyno, rplyID){
					replyform.qnano=qnano;
					replyform.reply_no = rplyno;
					replyform.action = "D";
					
					fsavereply();
					replysearchlist();
				},
				
				//답변달기 버튼
				btnaddreply : function(){
					
					var param = {
							qnano : qnadcontent.qnano,
							loginID : conTitle.bloginID,
							date : replydata.reply_date = new Date().toISOString().slice(0, 10),
					}
					
					fn_replyForm(param);
				}
			}
		});
		
		//댓글 저장, 수정, 삭제 관련 Vue
		replyform = new Vue({
			el : "#layer2",
			data : {
				reply_no :  "",
				action : "",
				qnano : "",
				reply_date : "",
				loginID : "",
				reply_content : ""
			}
		});
		
		//qna 저장, 수정, 삭제 관련 Vue
		newqna = new Vue({
			el : "#layer1",
			data :{
				action : "",
				qna_no : "",
				name : "",
				qna_title : "",
				qna_date :"",
				qna_content : "",
				qna_count : "",
			}
		});
	}
	
	//로그인 정보 가져오기
	function userinfo(){
		conTitle.loginID = '${loginID}'
			
			var param = {
					loginID : conTitle.loginID
			}
			
			
			var userinfoCallBack = function(data){
				console.log("data : " + JSON.stringify(data));
				
				conTitle.bloginID = data.userinfo.loginID;
				conTitle.bname = data.userinfo.name;
				
			}
			callAjax("/all/userinfo.do", "post", "json", "false", param, userinfoCallBack);
		
	}
	
	//qna 목록 조회
	function qnasearchlist(pagenum){
		
		var pagenum = pagenum || 1;
		
		var param = {
				pagenum : pagenum,
				pageSize : qnapageSize,
				qnasearch : conTitle.qnasearch
		};
		
		var listcallback = function(returnData){
			console.log("returnData : " + JSON.stringify(returnData));
			
			qnalist.totalcnt = returnData.totalcnt;
			qnalist.listitem = returnData.qnalist;
			
			var pagenationHtml = getPaginationHtml(pagenum, qnalist.totalcnt, qnapageSize, qnapageBlockSize, 'qnasearchlist');
			qnalist.pagenavi = pagenationHtml;
			
			qnadcontent.show = false;
			qnadcontent.detail_btn_show = false;
			replydata.show = false;
		};
		
		callAjax("/all/qnalistVue.do", "post" , "json", "true", param, listcallback);
		
	}
	
	//qna하단 디테일 데이터 불러오기
	function qnalistsearch(pagenum) {
		var pagenum = pagenum || 1;
		
		var param = {
				qnano : qnadcontent.qnano
		}
		
		var listcallback = function(returnData){
			console.log("returnData : " + JSON.stringify(returnData));
			console.log("newqna.action : " + newqna.action)
			
			qnadataillista(returnData);
		}
		
		callAjax("/all/qnacontent.do", "post" , "json", "false", param, listcallback);
	}
	
	//qna하단 디테일 보이게
	function qnadataillista(data){
		console.log("qnadataillista 디테일 데이터 : ", data);
		
		qnadcontent.qna_title = data.qnainfo.qna_title;
		qnadcontent.name = data.qnainfo.name;
		qnadcontent.qna_date = data.qnainfo.qna_date;
		qnadcontent.qna_count = data.qnainfo.qna_count;
		qnadcontent.qna_content = data.qnainfo.qna_content;
		
		var detail_login = data.qnainfo.loginID; //디테일 작성자의 로그인 아이디
		var nowloginID = conTitle.bloginID; //현재 로그인한 사람의 로그인 아이디
		
		console.log("detail_login : " + detail_login);
		console.log("nowloginID : " + nowloginID);
		
		if(detail_login === nowloginID){
			qnadcontent.detail_btn_show = true;
		} else {
			qnadcontent.detail_btn_show = false;
		}
		
		replysearchlist(qnadcontent.qnano);
		
		//수정버튼 눌렀을 때 데이터값 가져오기
		newqna.qna_no = data.qnainfo.qna_no;
		newqna.name = data.qnainfo.name;
		newqna.qna_title = data.qnainfo.qna_title;
		newqna.qna_date = data.qnainfo.qna_date;
		newqna.qna_content = data.qnainfo.qna_content;
		console.log("newqna : ", newqna)
		if(newqna.action === "U"){
			qnadcontent.show = true;
			replydata.show = true;
		}
	}
	
	//댓글리스트
	function replysearchlist(qnano){
		
		var param = {
				qnano : qnano
		}
		
		console.log("qnano : " + param.qnano);
		
		var listcallback = function(returnData){
			console.log("returnDatareply : " + JSON.stringify(returnData));
			
			replydata.totalcnt = returnData.totalcnt;
			replydata.itemlist = returnData.replylist;
		}
		
		callAjax("/all/replylistVue.do", "post" , "json", "true", param, listcallback);
		
	}
	
	//저장할 때
	function fsavereply(){
		
		
		var param = {
				action : replyform.action,
				qna_no : replyform.qnano,
				reply_no : replyform.reply_no,
				reply_date : replyform.reply_date,
				loginID : replyform.loginID,
				reply_content : replyform.reply_content
		}
		
		var saveCallBack = function (data){
			gfCloseModal();
			replysearchlist(replyform.qnano);
		}
		
		callAjax("/all/replysave.do", "post", "json", "false", param, saveCallBack);
	}
	
	//답변 팝업창에 qnano(qna 번호), loginID(로그인ID), date(날짜)와 입력 및 빈칸은 빈칸으로 나타내기
	function fn_replyForm (data){
		console.log("fn_replyForm의 데이터 : ", data);
		
		gfModalPop("#layer2");
		
		//팝업창과 함께 데이터 입력
		replyform.reply_no = "";
		replyform.action = "I";
		replyform.qnano = data.qnano;
		replyform.reply_date = data.date = new Date().toISOString().slice(0, 10);
		replyform.loginID = data.loginID;
		replyform.reply_content = "";
		
		console.log("replyform : ", replyform)
	}
	
	//qna 신규등록, 수정할 때 폼 초기화
	function fn_qnaForm(qnaForm, data){
		
		console.log(" 수정 버튼 눌렀을 때 data : ", data);
		
		console.log(conTitle.bloginID);
		
		newqna.qna_no = "";
		newqna.name = conTitle.bname;
		newqna.qna_title = "";
		newqna.qna_date = new Date().toISOString().slice(0, 10);
		newqna.qna_content = "";
		
		console.log("newqna : ", newqna);
	}
	
	//qna 저장, 수정
	function fSaveqan(){
		var param = {
			action : newqna.action,
			qna_no : newqna.qna_no,
			loginID : conTitle.bloginID,
			name : newqna.name,
			qna_new_date : newqna.qna_date,
			qna_new_title : newqna.qna_title,
			qna_new_content : newqna.qna_content,
			qna_new_count : newqna.qna_count
		}
		
		var saveCallBack = function(data){
			gfCloseModal();
			qnasearchlist();
			replysearchlist(newqna.qna_no);
			
			if(newqna.action === "U"){
				qnalistsearch();
			}
		}
		
		alert("저장되었습니다.");
		
		console.log("param : ", param);
		
		callAjax("/all/qnasave.do", "post", "json", "false", param, saveCallBack);
		
		
	}
	
	
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<!-- <input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="qnano" id="qnano" value=""> qna 디테일 데이터 번호
	<input type="hidden" name="bloginID" id="bloginID" value=""> 현재 로그인 아이디
	<input type="hidden" name="bname" id="bname" value=""> 로그인한 이름
	<input type="hidden" name="brplyno" id="brplyno" value=""> reply 디테일 데이터 번호
	<input type="hidden" name="baction" id="baction" value=""> reply 에 대한 action값 -->
	
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
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">QnA</span> 
								<a href="../all/qna.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="conTitle" >
							<span>QnA</span> <span class="fr"> 
		     	                <input type="text" style="width: 300px; height: 25px;" id="qnasearch" name="qnasearch" placeholder="작성자명으로 검색" v-model="qnasearch">                    
			                    <a href="" class="btnType blue" id="btnSearchqna" name="btn"><span>검  색</span></a>
			                    <template v-if="userType === 'A'">
			                    	<a	class="btnType blue" href="" @click.prevent="qnanewpopup()" id="qna_updqte_data" name="modal"><span>신규등록</span></a>
			                    </template>
							</span>
						</p>
						
						<div class="qnalist" id="qnalist">
							
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">글번호</th>
										<th scope="col">글제목</th>
										<th scope="col">등록일</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<template v-if="totalcnt===0">
									<tbody>
										<tr>
											<td colspan=5>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item, index) in listitem">
										<tr>
											<td>{{item.qna_no}}</td>
											
											<td><a href="" @click.prevent="fn_qnalistsearch(item.qna_no)">{{item.qna_title}}</a></td>
											<td>{{item.qna_date}}</td>
											<td>{{item.name}}</td>
											<td>{{item.qna_count}}</td>
										</tr>
									</tbody>
								</template>
							</table>
							
						<div class="paging_area"  id="qnaPagination" v-html="pagenavi"> </div>
						</div>
						
						<br><br><br><br>
						
						<div id="qnadcontent" v-show="show">
						<p>
						<div id="detail_btn" v-show="detail_btn_show">
							<span class="fr"> 
		     	                <a href="" @click.prevent="fn_updateBackup()" class="btnType blue" id="qna_updqte_data" name="modal"><span>수정</span></a>
								<a href="" class="btnType blue" id="btnDeleteqna" name="btn"><span>삭제</span></a> 
							</span>
						</div>
						</p>
							<table class="row">
							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>

								<tr>
									<th scope="row">글번호</th>
									<td colspan="1"><div id="detail_qna_no">{{qnano}}</div> </td>
									<th scope="row">작성자</th>
									<td colspan="2"><div id="detail_name">{{name}}</div></td>
									<th scope="row">등록일</th>
									<td colspan="2"><div id="detail_qna_date">{{qna_date}}</div></td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td colspan="5"><div id="detail_qna_title">{{qna_title}}</div></td>
									<th scope="row">조회수</th>
									<td colspan="2"><div id="detail_qna_count">{{qna_count}}</div></td>
								</tr>
								<tr>
									<th scope="row">내용</th>
									<td colspan="8"><div id="detail_qna_content">{{qna_content}}</div></td>
								</tr>
							</table>
							</div>
						
						<div id="replydata" v-show="show">
							<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="20%">
								<col width="40%">
								<col width="25%">
								<col width="15%">
							</colgroup>
								<thead>
									<tr>
										<th scope="col">댓글작성자</th>
										<th scope="col">댓글내용</th>
										<th scope="col">댓글작성일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<template v-if="totalcnt === 0">
									<tbody>
										<tr>
											<td colspan=4> 조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="(item,index) in itemlist">
										<tr>
											<td>{{item.loginID}}</td>
											<td>{{item.reply_content}}</td>
											<td>{{item.reply_date}}</td>
											<td v-if="item.loginID === conTitle.bloginID">
											 	<a class="btnType blue" id="reply_delbtn" href="" @click.prevent="fn_replydelete(item.qna_no, item.reply_no)"><span>삭제</span></a>
											</td>
											<td v-else></td>
										</tr>
									</tbody>
								</template>
								<!-- <tbody id="tbodyreplylistdata"></tbody> -->
							</table>
						
						
						<div class="btn_areaC mt30">
							<template v-if="conTitle.userType !== 'A'">
								<a href="" @click.prevent="btnaddreply()" class="btnType blue" id="modal" name="modal"><span>답변</span></a>
							</template>
								<a href=""	class="btnType gray" id="btnCloseqna" name="btn"><span>취소</span></a>
						</div>
						</div>
						<!-- </div> -->
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
				<strong>신규등록</strong>
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
						<col width="120px">
						<col width="*">
						
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글번호<span class="font_red">*</span></th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="qna_no" name="qna_no" readonly="readonly" placeholder="글번호입니다." v-model="qna_no"/></td>
							<th scope="row">작성자<span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="name" name="name" readonly="readonly" v-model="name"/></div></td>
							<th scope="row">등록일</th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="qna_new_date" name="qna_new_date" readonly="readonly" v-model="qna_date"></input></td>
						</tr>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="7"><input type="text" class="inputTxt p100" id="qna_new_title" name="qna_new_title" v-model="qna_title"/></td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td colspan="7"><input colspan="3" type="text" class="inputTxt p100" id="qna_new_content" name="qna_new_content" v-model="qna_content"/></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveqan" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>QnA답변하기</strong>
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
							<th>댓글번호</th>
							<td colspan="1"><input type="text" class="inputTxt p100" id="reply_no" name="reply_no" readonly="readonly" v-model="reply_no"></input></td>
							<th>댓글작성일</th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="reply_date" name="reply_date" readonly="readonly" v-model="reply_date"></input></td>
							<th>댓글작성자</th>
							<td colspan="2"><input type="text" class="inputTxt p100" id="loginID" name="loginID" readonly="readonly" v-model="loginID"></input></td>
						</tr>
						<tr>
							<th>댓글내용</th>
							<td colspan="8"><input type="text" class="inputTxt p100" id="reply_content" name="reply_content" v-model="reply_content"></input></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="replysave" name="btn"><span>저장</span></a>
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