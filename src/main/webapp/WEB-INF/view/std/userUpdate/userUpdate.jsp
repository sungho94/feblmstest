<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>LmsRight</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- 우편번호 찾기 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;

	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;

	/** OnLoad event */
	$(function() {

		userUpdateList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				studentUpdate();
				break;
			case 'btnCloseGrpCod':
			case 'btnCloseDtlCod':
				gfCloseModal();
				break;
			}
		});
	}

	// 우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('user_zipcode').value = data.zonecode;
				document.getElementById("user_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("user_address").focus();
			}
		}).open({
			q : q
		});
	}

	/* $("#loginID").empty().append();
	$("#name").empty().append();
	$("#password").empty().append();
	$("#passwordResult").empty().append();
	$("#zipcode").empty().append();
	$("#addr").empty().append();
	$("#hp").empty().append();
	$("#email").empty().append(); */

	function userUpdateList() {

		var ID = '${loginId}'
		
		console.log(ID);

		var param = {
			loginID : ID
		}

		console.log(param);

		var userUpdateListCallback = function(data) {
			console.log(data);

			userUpdateSelect(data);
		}
		callAjax("/std/userUpdateList.do", "post", "json", "false", param,
				userUpdateListCallback);

	}

	// 상세정보 불러오기
	function userUpdateSelect(data) {

		console.log(data.userUpdateList.resume_file);

		$("#loginID").val(data.userUpdateList.loginID);
		$("#name").val(data.userUpdateList.name);
		$("#password").val(data.userUpdateList.password);
		$("#user_zipcode").val(data.userUpdateList.user_zipcode);
		$("#user_address").val(data.userUpdateList.user_address);
		$("#user_hp").val(data.userUpdateList.user_hp);
		$("#user_email").val(data.userUpdateList.user_email);
		
		$("#selFile").val("");
		
			
	}

	// 개인정보 수정 저장
	function studentUpdate() {
		console.log("들어왔다")

		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';

		var dataWithFile = new FormData(frm);

		var studentUpdateCallBack = function(savereturn) {
			console.log("studentSaveCallBack: ", JSON.stringify(savereturn));
			
			userUpdateList();

		}

		callAjaxFileUploadSetFormData("/std/studentUpdate.do", "post", "json",
				true, dataWithFile, studentUpdateCallBack);
	}
	
	// 유효성 검사
	function fn_validateItem() {
		
		var chk = checkNotEmpty(
			[
				["itemVol", "수량을 입력해 주세요"] ,
				["name", "이름을 입력해 주세요"],
				["password", "비밀번호를 입력해 주세요"],
				["passwordResult", "비밀번호 확인을 입력해 주세요"],
				["user_zipcode", "우편번호를 입력해 주세요"],
				["user_address", "주소를 입력해 주세요"],
				["user_hp", "연락처를 입력해 주세요"],
				["user_email", "이메일을 입력해 주세요"],
				
			]
		)
		
		if(!chk) {
			return;
		}
		
		return true;
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">학습관리</span> <span
									class="btn_nav bold">개인정보 수정</span> <a
									href="../std/userUpdate.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>개인정보 수정</span>
							</p>

							<dd class="content">
								<!-- s : 여기에 내용입력 -->
								<table class="row">
									<caption>caption</caption>
									<colgroup>
										<col width="120px">
										<col width="300px">
										<col width="120px">
										<col width="300px">
									</colgroup>

									<tbody>
										<tr>
											<th scope="row">아이디 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100"
												name="loginID" id="loginID" readonly /></td>
											<th scope="row">이름 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100" name="name"
												id="name" /></td>
										</tr>
										<tr>
											<th scope="row">비밀번호 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100"
												name="password" id="password" /></td>
											<th scope="row">비밀번호 확인 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100"
												name="passwordResult" id="passwordResult" /></td>
										</tr>
										<tr>
											<th scope="row">우편번호 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100"
												name="user_zipcode" id="user_zipcode" /> <input type="button"
												value="우편번호 찾기" onclick="execDaumPostcode()"
												style="width: 130px; height: 20px;" /></td>
											<th scope="row">주소 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100" name="user_address"
												id="user_address" /></td>
										</tr>
										<tr>
											<th scope="row">연락처 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100" name="user_hp"
												id="user_hp" /></td>
											<th scope="row">이메일 <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt p100"
												name="user_email" id="user_email" /></td>
										</tr>
									</tbody>
								</table>
								<br> <br> <br> <br> <br> <br>
								<p class="conTitle">
									<span>추가 입력사항</span>
								</p>

								<table class="row">
									<caption>caption</caption>
									<colgroup>
										<col width="120px">
										<col width="120px">
									</colgroup>

									<tbody>
										<tr>
											<th scope="row">파일첨부</th>
											<td><input type="file" class="inputTxt p100"
												name="selFile" id="selFile" />
											</td>
										</tr>
									</tbody>
								</table>


								<!-- e : 여기에 내용입력 -->

								<div class="btn_areaC mt30">
									<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
									<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
								</div>
							</dd>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>