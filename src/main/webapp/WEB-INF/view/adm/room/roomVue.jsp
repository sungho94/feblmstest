<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.userType ne 'C'}">
	<c:redirect url="/dashboard/dashboard.do" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>study</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	//room 검색어 부분 등록
	var searcharea;
	var roomarea;

	/** OnLoad event */
	$(function() {
		//comcombo("rm_seq","rmseq","all","");
		//vue init 등록
		init();
		
		//search 부분
		searchleclist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function init(){
		//상단 검색부분
		searcharea = new Vue ({
			el : "#searcharea",
			data : {
				sword : "",
				stype : "all",
			},
		});
		//강의실 리스트 뿌리는 부분
		roomarea = new Vue ({
			el :  "#roomarea",
			data : {
				listitem : [], 	//배열변수 등록(json)
				totalcnt : 0, 	//총건수의 변수  0으로 세팅
				cpage : 0,		//조회하는 현재페이지 currentpage 세팅
				pagesize : 5,	//페이지 사이즈 세팅
				blocksize : 10, //보여줄 블록사이즈 세팅
				pagenavi : "",	//navigate 세팅
				room_name : "",
			},
			methods : { 		
				//강의실에서 강의실 이름을 눌렀을 때 room_seq, room_name 을 넘 겨준다.
				itemListSearch : function (room_seq, room_name, room_no){
					//console.log(room_seq, room_name,room_no); //얘는 가져옴
					itemListSearch(room_seq, room_name,room_no);
				},
				//강의실 에서 수정 버튼 눌렀을 때 room_seq 값을 넙겨준다.
				fn_roomRegPopup : function (room_seq){
					//console.log(room_seq);
					fn_roomRegPopup(room_seq);
				}
			}
		});
		
		//item 리스트 뿌리는 부분
		itemarea = new Vue({
			el : "#itemarea",
			data : {
				listitem : [], 	//배열변수 등록(json)
				totalcnt : 0, 	//총건수의 변수  0으로 세팅
				cpage : 0,		//조회하는 현재페이지 currentpage 세팅
				pagesize : 5,	//페이지 사이즈 세팅
				blocksize : 10, //보여줄 블록사이즈 세팅
				pagenavi : "",	//navigate 세팅
				itemlistshow : false,
			},
			methods : {
				fn_itemPopup : function (item_no){
					//console.log(item_no);
					fn_itemPopup(item_no);
				}
			}
		});
		
		//강의실관리 (수정) 모달창
		layer1 = new Vue({
			el : "#layer1",
			data : {
				room_seq : 0,
				room_no : "",
				room_name : "",
				room_person : "",
				room_status : "",
				action : "",
				roomdel : false,
			},
		})
		
		//장비관리 (수정) 모달창
		layer2 = new Vue({
			el : "#layer2",
			data : {
				iroom_no : "",
				iroom_name : "",
				item_no : 0,
				item_name : "",
				item_volume : "",
				item_note : "",
				iaction : "",
				room_seq : "",
				itemdel : false,
			}
		})
	}
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSaveRoom':
				fSaveRoom();
				//alert("저장되었습니다.");
				break;
			case 'btnDeleteRoom':
				//$("#action").val("D");
				layer1.action ="D";
				fSaveRoom();
				alert("삭제되었습니다.");
				console.log("삭제");
				break;
			case 'btnSaveItem':
				fSaveItem();
				alert("저장되었습니다.");
				break;
			case 'btnDeleteItem':
				//$("#iaction").val("D");
				layer2.iaction ="D";
				fSaveItem();
				alert("삭제되었습니다.");
				break;
			case 'btnSearchRoom':
				//searchRoom();
				searchleclist();
				break;
			case 'btnCloseRoom':
			case 'btnCloseItem':
				gfCloseModal();
				break;
			}
		});
	}
	
	function searchleclist(pagenum){
		pagenum = pagenum || 1;
		
		param = {
				pagenum : pagenum,
				pageSize : roomarea.pagesize,
				stype : searcharea.stype,
				sword : searcharea.sword,
		}
		
		//console.log(param); //가져옴
		
		var listcallback = function(roomlistdata) {
			console.log("roomlistdata" + JSON.stringify(roomlistdata));
			
			roomarea.cpage = pagenum;
			roomarea.listitem = roomlistdata.roomInfo;
			roomarea.totalcnt = roomlistdata.totalcnt;
			roomarea.room_name = roomlistdata.roomInfo.room_name;
			
			var paginationHtml = getPaginationHtml(pagenum, roomarea.totalcnt, roomarea.pagesize, roomarea.blocksize, 'searchleclist');
			roomarea.pagenavi = paginationHtml;
		}
		callAjax("/adm/vueroomList.do", "post", "json", "true", param, listcallback);
	}
	
	//상단에서 강의실이름을 눌렀을 때
	function itemListSearch(roomseq, roomname, roomno) {

		console.log(roomseq,roomname,roomno); //가져옴
		
		itemarea.itemlistshow = true;
		
		//백업 받기
		itemarea.roomseq = roomseq; 
		itemarea.roomname = roomname;
		itemarea.roomno = roomno;
		
		itemSearch();
	}
	
	//장비 조회하는 부분
	function itemSearch(pagenum) {
		
		//$("#divItemList").show();
		
		pagenum = pagenum || 1;

		var param = {
				pagenum : pagenum,
				pageSize : itemarea.pagesize,
				room_seq : itemarea.roomseq,
				room_name : itemarea.roomname
		}
		
		console.log(param); //값 가져옴

		var listcallback = function(treturndata) {
			console.log("treturndata : " + JSON.stringify(treturndata));
			
			itemarea.cpage = pagenum;
			itemarea.listitem = treturndata.itemList;
			itemarea.totalcnt = treturndata.totalcnt;
			
		}
		callAjax("/adm/vueitemList.do", "post", "json", "true", param, listcallback);
	}
	
	//각 강의실의 수정 버튼을 눌렀을 때
	function fn_roomRegPopup(room_seq) {
		
		console.log("수정 버튼 클릭 후 room_seq : " + room_seq);
		
		if (room_seq == "" || room_seq == null || room_seq == undefined) {
			
			layer1.action = "I";
			
			// 그룹코드 폼 초기화
			fn_initForm();

			// 모달 팝업
			gfModalPop("#layer1");
		} else {
			layer1.action = "U";
			
			fn_selectRoom(room_seq);
			console.log("값이 있을 때의 room_seq : " + room_seq); //들어오는거 확인
			//gfModalPop("#layer1");
			
		}
	}
	
	//room  수정 버튼 후 initForm
	function fn_initForm(selectRoom) {

		console.log("111 fn_initForm 의 selectRoom : ", selectRoom);
		
		if (selectRoom == "" || selectRoom == null || selectRoom == undefined) {
			
			console.log("undefined 값으로 insert 하는곳 확인 "); //여기를 탐
			layer1.action = "I";
			layer1.room_seq = "";
			layer1.room_no = "";
			layer1.room_name = "";
			layer1.room_person = "";
			layer1.room_status = "N";
			layer1.roomdel = false;
		} else {
			
			layer1.action = "U";
			layer1.room_seq = selectRoom.room_seq;
			layer1.room_no = selectRoom.room_no;
			layer1.room_name = selectRoom.room_name;
			layer1.room_person = selectRoom.room_person;
			layer1.room_status = selectRoom.room_status;
			layer1.roomdel = true;
		}
	}
	
	//강의실 선택시 디테일 
	function fn_selectRoom(room_seq) {

		var param = {
			room_seq : room_seq
		};
		
		console.log(param);
		
		var selectcallback = function(selectresult) {
			
			console.log("fn_selectRoom 의 selectcallback : " + JSON.stringify(selectresult));

			fn_initForm(selectresult.roomInfo);

			// 모달 팝업
			gfModalPop("#layer1");

		}

		callAjax("/adm/vueroomDetail.do", "post", "json", "false", param, selectcallback);
	};
	
	//강의실 저장
	function fSaveRoom(){

		console.log("저장버튼 누름"); //확인됨.
		
		var param = {
			action : layer1.action,
			room_seq : layer1.room_seq,
			room_no : layer1.room_no,
			room_name : layer1.room_name,
			room_person : layer1.room_person,
			room_status : layer1.room_status
		};
		
		console.log(param);

		var saveRoomSave = function(savereturn) {
			console.log("saveRoomSave: ", JSON.stringify(savereturn));

			gfCloseModal();
			
			searchleclist(roomarea.cpage); //저장 후 현재(current page 상태로 리로딩)
		}
		callAjax("/adm/vueroomSave.do", "post", "json", "false", param, saveRoomSave);
	}
	
	//장비 등록 및 수정 버튼 누른 후
	function fn_itemPopup(item_no){
		
		console.log("장비 등록(수정) 버튼 클릭");
		
		if ( item_no == "" || item_no == null || item_no == undefined) {
			console.log("값 없을 때 확인");
			
			layer2.iaction = "I";
			
			//폼 초기화
			fn_initItemForm();
			
			gfModalPop("#layer2");
			
		} else {
			console.log("값 있을 때 확인");
			console.log("값이 있을 때 item_no :" + item_no); //나옴
			
			layer2.iaction = "U";
			
			fn_initItem(item_no);
			
			
		}
	}
	
	//item 값 가져오기.
	function fn_initItem(itemno) {
		
		var param ={
				room_seq : itemarea.roomseq,
				room_no : itemarea.roomno,
				room_name : itemarea.roomname,
				item_no : itemno,
		}
		
		console.log("fn_initItem 의 param ", param); //나옴
		
		var selectcallback = function(selectresult) {
			
			console.log("fn_initItem 의 selectcallback : " + JSON.stringify(selectresult));
			
			fn_selectItem(selectresult.itemInfo, param);
			//fn_initItemForm(selectresult.itemInfo);
			
		}

		callAjax("/adm/vueitemDetail.do", "post", "json", "true", param, selectcallback);
		
	}
	//아이템 수정 값 확인하기
	 function fn_selectItem(itemInfo, param){
		
		console.log("itemInfo 여기서 넘어감 ", itemInfo); //넘어옴
		console.log("selectItem의 param :" , param);	//넘어옴
		
		if(itemInfo == "" || itemInfo == null || itemInfo ==undefined){
			console.log("itemInfo가 없을 때");
			
			//form 초기화
			fn_initItemForm();
			
			gfModalPop("#layer2");
			
		}else {
			console.log("itemInfo가 있을 때");
			
			fn_initItemForm(itemInfo, param);
		}
	}

	//item 값 가져오기
	function fn_initItemForm(itemInfo, param){
		
		console.log("222 itemInfo 여기서 넘어감 ", itemInfo);
		console.log("222 selectItem의 param :" , param);
		
		
		if ( itemInfo == "" || itemInfo == null || itemInfo == undefined ){
			
			console.log("새로등록입니다~");
			
			//room_no 와 room_name을 선언해준다.
			layer2.iroom_no = itemarea.roomno;
			layer2.iroom_name = itemarea.roomname;
			layer2.room_seq = itemarea.roomseq;
			layer2.item_no = "";
			layer2.item_name = "";
			layer2.item_volume = "";
			layer2.item_note = "";
			layer2.iaction = "I";
			
			layer2.itemdel = false;
		} else {
			
			console.log("수정입니다~");
			gfModalPop("#layer2");
			
			layer2.iroom_no = param.room_no;
			layer2.iroom_name = param.room_name;
			layer2.room_seq = param.room_seq;
			layer2.item_no = itemInfo.item_no;
			layer2.item_name = itemInfo.item_name;
			layer2.item_volume = itemInfo.item_volume;
			layer2.item_note = itemInfo.item_note;
			layer2.iaction = "U";
			
			layer2.itemdel = true;
		}
		
	}
	
	function fSaveItem(){
		console.log("저장버튼 누름"); //확인됨.
		
		var param = {
				iroom_no : layer2.iroom_no,
				iroom_name : layer2.iroom_name,
				room_seq : layer2.room_seq,
				item_no : layer2.item_no,
				item_name : layer2.item_name,
				item_volume : layer2.item_volume,
				item_note : layer2.item_note,
				iaction : layer2.iaction,
				
		}
		
		console.log(param);
		
		var savecallback = function(selectresult) {
			console.log("selectcallback : " + JSON.stringify(selectresult));

			gfCloseModal();

			itemSearch(itemarea.cpage);
		}

		callAjax("/adm/vueitemSave.do", "post", "json", "false", param, savecallback);
		
	}

</script>

</head>
<body>
	<form id="myForm" action="" method="">

		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="broom_no" id="broom_no" value="">
		<input type="hidden" name="iaction" id="iaction" value="">
		<input type="hidden" name="broom_name" id="broom_name" value="">
		<input type="hidden" name="bkpagenum" id="bkpagenum" value="">
		<input type="hidden" name="room_seq" id="room_seq" value=""><!-- roomDetail 에서 따온 값을 roomUpdate 할때 써먹을거 -->
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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">시설관리</span>
								<span class="btn_nav bold">강의실 </span>
								<a href="../adm/Room.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>강의실</span> <span class="fr">
									<select id="stype" name="stype" style="width: 150px;" v-model="stype">
										<option value="all">전체</option>
										<option value="rmnumber">순번</option>
										<option value="rmname">강의실이름</option>
										<option value="teacher">강사</option>
									</select> 검색어
									<input type="text" style="width: 300px; height: 25px;" id="sword" name="sword" v-model="sword"> 
										<a href="" class="btnType blue" id="btnSearchRoom" name="btn">
											<span>검색</span>
										</a>
										<a class="btnType blue" href="javascript:fn_roomRegPopup();" name="modal">
											<span>신규등록</span>
										</a>
								</span>


							</p>

							<div class="roomList" id="roomarea">

								<table style="margin-top: 10px" width="100%" cellpadding="5"
									cellspacing="0" border="1" align="left"
									style="collapse; border: 1px #50bcdf;">
									<tr style="border: 0px; border-color: blue">
										<td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
										<td width="50" height="25"
											style="font-size: 100%; text-align: left; padding-right: 25px;">

										</td>

									</tr>
								</table>

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
									</colgroup>

									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">강의실 이름</th>
											<th scope="col">강의이름</th>
											<th scope="col">자리수</th>
											<th scope="col">강사</th>
											<th scope="col">강의기간</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=7>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
									</template>
									<template v-else>
									<tbody>
										<tr v-for="(item, index) in listitem">
											<td>{{ item.room_no }}</td> <!-- 순번 -->
											<td><a href="" @click.prevent="itemListSearch(item.room_seq, item.room_name,item.room_no )">[{{ item.room_name }}]</a></td><!-- 강의실이름 -->
											<td>{{ item.lecture_name }}</td><!-- 강의이름 -->
											<td>{{ item.room_person }}</td><!-- 자리수 -->
											<td>{{ item.teacher_name }}</td><!-- 강사 -->
											<td>{{ item.lecture_start }}  &#126; {{ item.lecture_end }}</td><!-- 강의기간 -->
											<td>
												<!-- <a class="btnType3 color1" href="javascript:fn_roomRegPopup({item.room_seq})"> -->
												<a @click="fn_roomRegPopup(item.room_seq)">
													<span>[수정]</span>
												</a>
											</td><!-- 강의실의 수정버튼 -->
										</tr>
									</tbody>
									</template>
								</table>
								<div class="paging_area" id="roomListPagination" v-html="pagenavi"></div>
							</div>


							<br><br><br>
							
							<!-- <div id="divItemList"> -->
							<div id="itemarea" v-show="itemlistshow">
							<p class="conTitle">
								<span>장비</span> <span class="fr"> <a class="btnType blue"
									href="javascript:fn_itemPopup();" name="modal"><span>신규등록</span></a>
								</span>
							</p>


								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="50%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">장비코드</th>
											<th scope="col">장비명</th>
											<th scope="col">수량</th>
											<th scope="col">비고</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<!-- <tbody id="tbodyItemList"></tbody> -->
									<template v-if="totalcnt == 0">
									<tbody>
										<tr>
											<td colspan=5>조회된 데이터가 없습니다.</td>
										</tr>
									</tbody>
									</template>
									<template v-else>
									<tbody>
										<tr v-for="(item, index) in listitem">
											<td>{{ item.item_no }}</td> <!-- 장비코드 -->
											<td>{{ item.item_name }}</td><!-- 장비명 -->
											<td>{{ item.item_volume }}</td><!-- 수량 -->
											<td>{{ item.item_note }}</td><!-- 비고 -->
											<td>
												<!-- <a class="btnType3 color1" href="javascript:fn_itemPopup(item.room_seq);"><span>수정</span></a> -->
												<a @click="fn_itemPopup(item.item_no)">
													<span>[수정]</span>
												</a>
											</td><!-- 장비의 수정버튼 -->
										</tr>
									</tbody>
									</template>
								</table>
							<div class="paging_area" id="itemListPagination"></div>
						</div>


						</div> 
						<br><br>

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>




		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강의실 관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">순번 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="room_no" id="room_no" v-model="room_no" />
								</td>
								<th scope="row">강의실이름 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="room_name" id="room_name" v-model="room_name" />
								</td>
							</tr>
							<tr>
								<th scope="row">자릿수 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="room_person" id="room_person" v-model="room_person" />
								</td>
								<th scope="row">사용유무 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="radio" id="radio1-2" name="room_status" id="room_status_2" value='N'  v-model="room_status"/> <!-- 이름을 통일시켜줌 -->
									<label for="radio1-2">미사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="radio1-1" name="room_status" id="room_status_1" value='Y' v-model="room_status" />
									<label for="radio1-1">사용</label>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveRoom" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteRoom" name="btn" v-show="roomdel"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnCloseRoom" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>


		<!-- 장비 관리 모달창 -->

		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>장비 관리</strong>
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
								<th scope="row">강의실코드 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="iroom_no" id="iroom_no" v-model="iroom_no" readonly />
								</td>
								<th scope="row">강의실 명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="iroom_name" id="iroom_name" v-model="iroom_name" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row">장비코드<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="item_no" name="item_no" v-model="item_no"  readonly/>
								</td>
								<th scope="row">장비명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="item_name" name="item_name" v-model="item_name" />
								</td>
							</tr>

							<tr>
								<th scope="row">수량</th>
								<td>
									<input type="text" class="inputTxt p100" id="item_volume" name="item_volume" v-model="item_volume" onkeydown="fFilterNumber(event);" />
								</td>
								<th scope="row">비고</th>
								<td>
									<input type="text" class="inputTxt p100" id="item_note" name="item_note" v-model="item_note" />
								</td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveItem" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteItem" name="btn" v-show="itemdel"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnCloseItem" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		<!--// 모달팝업 -->
	</form>
</body>
</html>