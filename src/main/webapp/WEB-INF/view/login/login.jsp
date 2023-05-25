<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Chain Maker :: Login</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/admin/login.css" />

<!-- 우편번호 조회 -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
	<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script type="text/javascript">

var check;

/* OnLoad Event */
$(document).ready(function() {
	$("#confirm").hide();
	$("#loginRegister").hide();
	$("#loginEmail").hide();
	$("#loginPwd").hide();

	var cookie_user_id = getCookie('EMP_ID');
	if (cookie_user_id != "") {
		$("#EMP_ID").val(cookie_user_id);
		$("#cb_saveId").attr("checked", true);
	}

	$("#EMP_ID").focus();

	init();

});


function fcancleModal(){
	gfCloseModal();
	}

/* 회원가입 모달창 실행 */
function fRegister() {
	//var div_cd;

	//$("#action").val("I");
	check.action = "I";

	// 모달 팝업
	gfModalPop("#layer1");
	//init();
	instaffRegister();


	//모달 초기화

}



 function init() {
	check = new Vue({
		el: '#layer1',
		data : {
			langitems: [],
			langitems1: [],
			langitems2: [],
			langitems3: [],
			listlistCod: '',
			weblistCod:'',
			dblistCod:'',
			wslistCod:'',
			sklcdlistCod:'',
			areacdlistCod:'',
			skillgrpcd:'',
			skilldtlcd:'',

			registerId : "",
			passWord : "",
			name : "",
			gender : "",
			birth : "",
			email : "",
			//detailaddr
			zipCode : "",
			//loginaddr
			address : "",
			//loginaddr1
			detailAddress : "",
			tel1 : "",
			tel2 : "",
			tel3 : "",
			action : "",
			checkLoginIdAndCheckRegisterId : "0",
			checkEmailAndCheckRegister : "0",
			registerPwdOk : "",

			//hidden으로 받아오는 친구들!
			divCd : "",
			delCd : "",
			userType : "",
			approvalCd : "",

			//학생, 강사 체크하기
			stuCk : false,
			teaCk : false,
			fileTable : false,

			resumeCheck : "",

		}
	});

 }



 /*체크리스트 콜백함수*/
 function checklistResult(data){

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
 	$.ajax({
		url : '/checklist.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : true,
		success : function(data) {
			check.check = [];
			check.langitems = data.listlistCod;
			check.langitems1 = data.weblistCod;
			check.langitems2 = data.dblistCod;
			check.langitems3 = data.wslistCod;
			}
		});
		}

$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
})

var chk_arr = [];
$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
	chk_arr.push(chk);
})

/*학생 회원가입 폼 초기화*/
function instaffRegister(){
	check.stuCk=true;
	//$("#stuCk").show();
	check.teaCk=false;
	//$("#teaCk").hide();
	check.userType = "A";
	//$("#user_type").val("A");
	check.divCd = "Student";
	//$("#div_cd").val("Student");

	//$("#user_type_li").hide();
	check.registerId = "";
	//$("#registerId").val("");
	check.passWord = "";
	// $("#registerPwd").val("");
	check.checkLoginIdAndCheckRegisterId = "";
	// $("#registerPwdOk").val("");
	// $("#rggender_th").show();
	// $("#rggender_td").show();
	// $("#registerName").show();
	// $("#registerName_th").show();
	check.gender = "";
 	// $("#gender").val("");
	check.email="";
	// $("#registerEmail").val("");
	check.zipCode="";
	// $("#detailaddr").val("");
	check.address="";
	// $("#loginaddr").val("");
	check.detailAddress = "";
	// $("#loginaddr1").val("");
	check.tel1 = "";
	// $("#tel1").val("");
	check.tel2 = "";
	// $("#tel2").val("");
	check.tel3 = "";
	// $("#tel3").val("");
	check.divCd = "n";
	// $("#del_cd").val("n");
	check.approvalCd = "n";
	// $("#approval_cd").val("n");
	check.checkLoginIdAndCheckRegisterId = "0";
	// $("#ckIdcheckreg").val("0");
	// $("#birthday1").show();
	// //학생 이력서 테이블
	check.fileTable=true;
	// $("#filetable").show();
	// $("#resumecheck").val("N");
	check.resumeCheck = "N";
	$("#resumecheck").hide();
	check.action="I";
}

/*강사 회원가입 폼 초기화*/
function outstaffRegister(){
//추가

	//$("#stuCk").hide();
	check.stuCk=false;
	//$("#teaCk").show();
	check.teaCk=true;
	//$("#user_type").val("D");
	check.userType = "D";
	//$("#div_cd").val("Teacher");
	check.divCd = "Teacher";
	//$("#user_type_li").hide();
	//$("#registerId").val("");
	check.registerId = "";
	//$("#registerPwd").val("");
	check.passWord = "";
	//$("#registerPwdOk").val("");
	check.checkLoginIdAndCheckRegisterId = "";
	//$("#rggender_th").show();
	//$("#rggender_td").show();
	//$("#registerName").show();
	//$("#registerName_th").show();
	//$("#gender").val("");
	check.gender = "";
	//$("#registerEmail").val("");
	check.email="";
	//$("#detailaddr").val("");
	check.zipCode="";
	//$("#loginaddr").val("");
	check.address="";
	//$("#loginaddr1").val("");
	check.detailAddress = "";
	//$("#tel1").val("");
	check.tel1 = "";
	//$("#tel2").val("");
	check.tel2 = "";
	//$("#tel3").val("");
	check.tel3 = "";
	//$("#del_cd").val("n");
	check.divCd = "n";
	//$("#approval_cd").val("n");
	check.approvalCd = "n";
	//$("#ckIdcheckreg").val("0");
	check.checkLoginIdAndCheckRegisterId = "0";
	//$("#birthday1").show();
	//$("#filetable").hide();
	check.fileTable = false;
	//$("#resumecheck").val("N");
	check.resumeCheck = "N";
	$("#resumecheck").hide();
	check.action="I";

}


/* 아이디/비밀번호 찾기 모달창 실행 */
function findIdPwd() {

	// 모달 팝업
	gfModalPop("#layer2");

}


/* 회원가입 validation */
function RegisterVal(){

	// var div_cd = $('#div_cd').val();
	// var user_type = $('#user_type').val();
	// var rgid = $('#registerId').val();
	// var rgpwd = $('#registerPwd').val();
	// var rgpwdok = $('#registerPwdOk').val();
	// var rgname = $('#registerName').val();
	// var user_company =$('#user_company').val();
	// var rgemail = $('#registerEmail').val();
	// var dtadr = $('#detailaddr').val();
	// var lgadr = $('#loginaddr').val();
	// var lgadr1 = $('#loginaddr1').val();
	// var tel1 = $('#tel1').val();
	// var tel2 = $('#tel2').val();
	// var tel3 = $('#tel3').val();

	//밑에 두개는 원래 주석처리 되어 있었음
/* 	var bank_cd = $('#bank_nm').val();
	var bank_account = $('#bank_account').val(); */

	var div_cd = check.divCd;
	var user_type = check.userType;
	var rgid = check.registerId;
	var rgpwd = check.passWord;
	var rgpwdok = check.registerPwdOk
	var rgname = check.name;
	var user_company =$('#user_company').val();
	var rgemail = check.email;
	var dtadr = check.detailAddress;
	var lgadr = check.address;
	var lgadr1 = check.detailAddress;
	var tel1 = check.tel1;
	var tel2 = check.tel2;
	var tel3 = check.tel3;


	if(user_type == ""){
	//if(check.userType == ""){
		swal("타입을 입력해주세요.")
		//swal("타입을 입력해주세요.").then(function() {
			//$("#user_type").focus();
		  //});
		return false;
	}


	if(rgid.length < 1){
// 	if(check.registerId.length < 1){
// 		//swal("아이디를 입력하세요.").then(function() {
		swal("아이디를 입력하세요.")
// 			//$('#registerId').focus();
// 			//check.registerId.focus();
// 		 // });
		return false;
	}
//
 	if(rgpwd.length < 1){
// 		//swal("비밀번호를 입력하세요.").then(function() {
 		swal("비밀번호를 입력하세요.")
// 			// $('#registerPwd').focus();
// 			//$('#registerPwd').focus();
// 			//check.password.focus();
// 		 // });
 		return false;
 	}

 	if(rgpwdok.length < 1){
// 		//swal("비밀번호 확인을 입력하세요.").then(function() {
		swal("비밀번호 확인을 입력하세요.")
// 			// $('#registerPwdOk').focus();
// 			//check.registerPwdOk.focus();
//		  //});
		return false;
	}
//
	if(rgpwd != rgpwdok){
		//swal("비밀번호가 맞지 않습니다.").then(function() {
		swal("비밀번호가 맞지 않습니다.")
			// $('#registerPwd').focus();
			//check.password.focus();
		return false;
	}

	if(rgname.length < 1){
	//if(check.Name.length < 1){
		//swal("이름을 입력하세요.").then(function() {
		swal("이름을 입력하세요.")
			// $('#registerName').focus();
			//check.Name.focus();
		 // });
		return false;
	}
//
//
//
	if(rgemail.length < 1){
		// swal("이메일을 입력하세요.").then(function() {
		swal("이메일을 입력하세요.")
			// $('#registerEmail').focus();
			//$('#registerEmail').focus();
		  // });
		return false;
	}
//
	if(dtadr.length < 1){
		// swal("우편번호를 입력하세요.").then(function() {
		swal("우편번호를 입력하세요.")
			//check.email.focus();
		  // });
		return false;
	}

	if(lgadr.length < 1){
		swal("주소를 입력하세요.")
		//swal("주소를 입력하세요.").then(function() {
			// $('#loginaddr').focus();
			//check.address.focus();
		 // });
		return false;
	}

// 	//원래 주석처리 되어 있던 것
	if(lgadr1.length < 1){
	alert("상세주소를 입력하세요.");
		//$('#loginaddr1').focus();
	return false;
		}

	if(tel1.length < 1){
		swal("전화번호를 입력하세요.")
		//swal("전화번호를 입력하세요.").then(function() {
			// $('#tel1').focus();
			//check.tel1.focus();
		 // });
		return false;
	}

	if(tel2.length < 1){
		swal("전화번호를 입력하세요.")
		//swal("전화번호를 입력하세요.").then(function() {
			// $('#tel1').focus();
			//check.tel2.focus();
		  //});
		return false;
	}

	if(tel3.length < 1){
		swal("전화번호를 입력하세요.")
		// swal("전화번호를 입력하세요.").then(function() {
		// 	check.tel3.focus();
		//   });
		return false;
	}




	return true;

}

//TODO 수정 중
/*loginID 중복체크*/
function loginIdCheck(){

	//var data = {"loginID" : $("#registerId").val()};
	var data = {"loginID" :check.registerId};
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	//var id = $("#registerId").val();
	var id = check.registerId;
	//console.log(id);
	//console.log(data);

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		//dataType : 'JSON',
		dataType : 'json',
		async : true,
		success : function(data) {

			console.log("아이디 값(data) 0인지 1인지:  " + JSON.stringify(data));

			//if($("#registerId").val()==""){

			if(check.registerId == ""){
				console.log("아이디 입력란이 비어있음 ");
				//swal("아이디를 입력해주세요.").then(function(){
				swal("아이디를 입력해주세요.")
					//$("#registerId").focus();
					//check.registerId.focus();
				//});

				// check.checkLoginIdAndCheckRegisterId.val("0");
				check.checkLoginIdAndCheckRegisterId = "0";
			}
			 else if (data==1){
				console.log("중복된 아이디 ");
				//swal("중복된 아이디가 존재합니다.").then(function(){
				swal("중복된 아이디가 존재합니다.")
					//$("#registerId").focus();
					//check.registerId.focus();

				//});
				console.log(data);
				//$("#ckIdcheckreg").val("0");
				check.checkLoginIdAndCheckRegisterId="0";

			//} else if(!idRules.test($("#registerId").val())){
			} else if(!idRules.test(check.registerId)){
				swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.')
				//swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.').then(function(){
					//$("#registerId").focus();
					//check.registerId.focus();
				//});
				// $("#ckIdcheckreg").val("0");
				check.checkLoginIdAndCheckRegisterId="0";
				return false;
			} else if(data == 0){
				console.log("사용할 수 있는 아이디 입니다.");
				swal("사용할 수 있는 아이디 입니다.");
				//$("#ckIdcheckreg").val("1");
				check.checkLoginIdAndCheckRegisterId="1";
			}
		}
	});
}


/** 회원가입 버튼 아이디 중복 체크*/
function loginIdCheckComplete(){

	//var data = {"loginID" : $("#registerId").val()}
	var data = {"loginID" : check.registerId}

	var idRules =  /^[a-z0-9]{6,20}$/g ;
	//var id = $("#registerId").val();
	var id = check.registerId;

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		//dataType : 'json',
		async : false,
		success : function(data) {
			if (data == 1){
				//$("#ckIdcheckreg").val("0");
				check.checkLoginIdAndCheckRegisterId="0";
				console.log("사용할 수 있는 아이디");
				return false;
			// } else if(!idRules.test($("#registerId").al())){
			} else if(!idRules.test(id)){
				//$("#ckIdcheckreg").val("0");
				check.checkLoginIdAndCheckRegisterId="0";
				return false;
			}
		}
	});
}


/*-------  이메일 입력방식 선택  ------*/

/*이메일 중복 체크*/
function emailCheck(){
	//var data = {"user_email" : $("#registerEmail").val()};
	var data = {"userEmail" : check.email};

	$.ajax({
		url : '/check_email.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if(data == 1){
				//$("#ckEmailcheckreg").val("0");
				check.checkEmailAndCheckRegister="0";
				console.log("사용하고 있는 이메일");
				console.log(data);
				return false;
			} else {
				//$("#ckEmailcheckreg").val("1");
				check.checkEmailAndCheckRegister="1";
				console.log(data);
				console.log("이메일 사용 가능");
			}

		}
	});
}

/* 회원가입  완료*/
function CompleteRegister() {

	var param = document.getElementById("RegisterForm");

    param.enctype = 'multipart/form-data';

    var dataWithFile = new FormData(param);
	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
 	//var password = $("#registerPwd").val();
	var passWord = check.passWord;
 	/*이메일 정규식*/
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	//var email = $("#registerEmail").val();
	var email = check.email;

	/*전화번호 정규식*/
	var tel1Rules = /^\d{2,3}$/;
	var tel2Rules = /^\d{3,4}$/;
	var tel3Rules = /^\d{4}$/;

	// var tel1 = $("#tel1").val();
	// var tel2 = $("#tel2").val();
	// var tel3 = $("#tel3").val();
	var tel1 = check.tel1;
	var tel2 = check.tel2;
	var tel3 = check.tel3;
	//console.log(div_cd);
	console.log(check.divCd);

	/* validation 체크 */
	if(!RegisterVal()){
		return;
	}

	loginIdCheckComplete();
	emailCheck();

	//if (method == null || method == "") method = "post";
	dataWithFile.append("empty", "empty");

	$.ajax({
		url : "/register.do",
		type : "POST",
		dataType : "json",
		async : true,
		data : dataWithFile,
		contentType: false,
		processData: false,
		cache : false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
			$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
		},
		success : function(data) {
			fSaveRegister(data);
			alert("가입이 완료되었습니다.");
		},
		error : function(xhr, status, err) {
			console.log("xhr : " + xhr);
			console.log("status : " + status);
			console.log("err : " + err);

			if (xhr.status == 901) {
				alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
				location.replace('/login.do');
			} else {
				alert('A system error has occurred.' + err);
			}
		},
		complete: function(data) {
			$.unblockUI();
			gfCloseModal();
		}
	});

}

/* 회원 가입 저장 콜백함수 */
 function fSaveRegister(data) {

	if (data.result == "SUCCESS") {
		//alert(data.resultMsg);
		console.log("success" + data);
		gfCloseModal();
	} else {
		//alert(data.resultMsg);
		return false;
	}
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
			//document.getElementById('detailaddr').value = data.zonecode;
			check.zipCode = data.zonecode;

			//document.getElementById("loginaddr").value = addr;
			 check.address = addr;
			// 커서를 상세주소 필드로 이동한다.
			//document.getElementById("loginaddr1").focus();
			//document.getElementById("loginaddr1").focus();
		}
	}).open({
		q : q
	});
}


/* 로그인 validation */
function fValidateLogin() {

	var chk = checkNotEmpty([ [ "EMP_ID", "아이디를 입력해 주세요." ],
			[ "EMP_PWD", "비밀번호를 입력해 주세요." ] ]);

	if (!chk) {
		return;
	}

	return true;
}

/* 로그인 */
function fLoginProc() {
	if ($("#cb_saveId").is(":checked")) { // 저장 체크시
		saveCookie('EMP_ID', $("#EMP_ID").val(), 7);
	} else { // 체크 해제시는 공백
		saveCookie('EMP_ID', "", 7);
	}

	// vaildation 체크
	if (!fValidateLogin()) {
		return;
	}

	var resultCallback = function(data) {
		fLoginProcResult(data);
	};

	callAjax("/loginProc.do", "post", "json", true, $("#myForm")
			.serialize(), resultCallback);
}

/* 로그인 결과 */
function fLoginProcResult(data) {

	var lhost = data.serverName;

	if (data.result == "SUCCESS") {
		location.href = "${CTX_PATH}/dashboard/dashboard.do";
	} else {

		$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
				.dialog({
					modal : true,
					resizable : false,
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
							$("#EMP_ID").val("");
							$("#EMP_PWD").val("");
							$("#EMP_ID").focus();
						}
					} ]
				});
		$(".ui-dialog-titlebar").hide();
	}
}


/*이메일 기능  (아이디 있는지 없는지 체크)*/
function SendEmail() {
	var data = {
		"user_email" : $("#emailText").val(),
		/*"data-code" : $("#emailText").attr("data-code")*/
	};

	$.ajax({
		url : "/selectFindInfoId.do",
		type : "post",
		dataType : "json",
		async : false,
		data : data,
		success : function(flag) {
				if ($("#emailText").val() == "") {
					swal("이메일을 입력해주세요.");
			}	else if (flag.result == "FALSE") {
					swal("존재하지 않는 이메일 입니다.");
				}
				else if (flag.result == "SUCCESS") {
					swal("해당 이메일로 인증번호를 전송하였습니다.");

					$("#authNumId").val(flag);
					$("#confirm").show();
					findMailSendId();
			}
		}
	});
}

/*ID 찾기 이메일 전송*/
function findMailSendId(){
	var data = {
			"email" : $("#emailText").val(),
			"authNumId" : $("#authNumId").val()
		};
	$.ajax({
		url : "/sendmail.do",
		type : "post",
		dataType : "json",
		async : true,
		data : data,
		success : function(flag) {
				$("#authNumId").val(flag.authNumId);
		},
		error : function(request,status,error){
			swal("실패");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

}

/* 이메일 인증 */
function SendComplete() {
 	var inputNum = $("#emailNum").val();
	var emailNum = $("#authNumId").val();
	console.log(emailNum);

	if (inputNum.length < 1) {
		swal("인증번호를 입력해주세요.");
		return false;

	} else if (emailNum != inputNum) {
		swal("인증번호가 틀렸습니다.");
		return false;
		}

	 else if (emailNum == inputNum) {
		swal("인증 되었습니다.");

		// 아이디 메일 전송 함수호출
		findId();
	}
}

/* 아이디 뜨게 하는 */
var findId = function() {
	var data = {
		"user_email" : $("#emailText").val()
	};
	$.ajax({
		url : '/selectFindInfoId.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : false,
		success : function(flag) {
			// 모달 or span
			console.log(flag);
			swal("귀하의 아이디는  " + flag.resultModel.loginID + " 입니다");
			$("#emailText").val('');
			$("#confirm").hide();
			$("#emailText").val('');
			$("#authNumId").val('');
			$("#emailNum").val('');
			$("#authNumId").val('');
		gfCloseModal();
		}
	});
}

/* 비밀번호 찾기에서 아이디 체크하는 창(가입된 아이디가 알람창으로) */
function RegisterIdCheck(){
	var loginid = $("#emailIdText").val();


	var data = {
			"loginID" :loginid
	};
	console.log(data);

	$.ajax({
		url : "/registerIdCheck.do",
		type : "post",
		dataType : "json",
		async : false,
		data : data,
		success : function(data){
			if(loginid.length < 1){
				swal("아이디를 입력해주세요.");
				$("#loginEmail").hide();
			}

			else if (data.result == "SUCCESS"){

				swal("아이디가 존재합니다.");
				$("#loginEmail").show();
			}else{
				//console.log("data : " + JSON.stringify(data));
				swal("아이디가 존재하지 않습니다.");
				$("#loginEmail").hide();
			}

		}

	});
}

/* 이메일 기능 (비밀번호 기능)*/
function SendPwdEmail() {

	var data = {
		user_email : $("#emailPwdText").val(),
		loginID : $("#emailIdText").val(),
/* 		"data-code" : $("#emailPwdText").attr("data-code") */

	};

	console.log(data);



	$.ajax({
		url : "/selectFindInfoPw.do",
		type : "post",
		dataType : "json",
		async : false,
		data : data,
		success : function(flag) {


			if ($("#emailPwdText").val() == "") {
				swal("이메일을 입력해주세요.");
			} else if (flag.result == "FALSE") {
				swal("이메일이 틀렸습니다.");
				console.log("flag : " + JSON.stringify(flag));
			} else if (flag.result == "SUCCESS") {
				console.log("flag : " + JSON.stringify(flag));
				swal("해당 이메일로 인증번호를 전송하였습니다.");
				$("#authNumPwd").val(flag);
				$("#loginPwd").show();
				findMailSendPwd();
			}

		}
	});
}

/*비밀번호 찾기 이메일 전송*/
function findMailSendPwd(){
	var data = {
			"emailPwd" : $("#emailIdText").val(),
			"email" : $("#emailPwdText").val(),
			"authNumIdPwd" : $("#authNumPwd").val()
		};
	$.ajax({
		url : "/sendmail.do",
		type : "post",
		dataType : "json",
		async : true,
		data : data,
		success : function(flag) {
				$("#authNumPwd").val(flag.authNumId);
		},
		error : function(request,status,error){
			swal("실패");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

}

/* function pwdCheck(){
	var email = $("#emailPwdText");

	if(email.length < 1){
		alert("이메일을 입력해주세요.");
	}
}
 */

/* 이메일 비밀번호 인증 */
function SendCompletePwd() {
	var inputPwd = $("#emailPwdNum").val();
	var emailPwdNum = $("#authNumPwd").val();
	if (inputPwd.length < 1) {
		swal("인증번호를 입력해주세요.");
		return false;
	} else if (emailPwdNum != inputPwd) {
		swal("인증번호가 틀렸습니다.");
		return false;
	} else if (emailPwdNum == inputPwd) {
		swal("인증번호가 맞습니다.");
		$("#authNumPwd").val('');

		// 비밀번호 호출하는 함수
		findPwd();
	}
}


/* 비밀번호 뜨게 하는 창 */
var findPwd = function() {
	var data = {
		"loginID" : $("#emailIdText").val(),
		"user_email" : $("#emailPwdText").val()
	};
	$.ajax({
		url : '/selectFindInfoPw.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : false,
		success : function(flag) {
			swal("귀하의 비밀번호는  " + flag.resultModel.password + " 입니다");
			$("#loginEmail").hide();
			$("#loginPwd ").hide();
			$("#emailIdText").val('');
			$("#emailPwdText").val('');
			$("#emailPwdNum").val('');
			gfCloseModal();
		}
	});
}

/* 아이디 찾기 버튼 클릭 이벤트 */
function fSelectId() {

	gfModalPop("#layer2");
	$("#registerEmailId").show();
	$("#loginRegister").hide();
	$("#loginEmail").hide();
	$("#loginPwd").hide();
	$("#emailText").val('');
}

/* 비밀번호 찾기 버튼 클릭 이벤트 */
function fSelectPwd() {

	$("#registerEmailId").hide();
	$("#confirm").hide();
	$("#loginRegister").show();
	$("#loginEmail").hide();
	$("#loginPwd").hide();
	$("#emailIdText").val('');
	gfModalPop("#layer2");
}

/* 아이디 찾기 메일 인증하기 버튼 클릭 이벤트 */
function fSelectIdOk() {
	$("#emailOk").on("click", function() {
		swal("인증이 완료 되었습니다.")
	});
}

/** ID 조회 */
function fSelectData() {
	var resultCallback = function(data) {
		fSelectDataResult(data);
	};
	callAjax("/selectFindInfoId.do", "post", "json", true, $("#modalForm")
			.serialize(), resultCallback);
}

/** PW 조회 */
function fSelectDataPw() {
	var resultCallback = function(data) {
		fSelectDataResultPw(data);
	};

	callAjax("/selectFindInfoPw.do", "post", "json", true, $("#modalForm2")
			.serialize(), resultCallback);
}

/** pw 저장 */
function fSaveData() {

	var resultCallback = function(data) {
		fSaveDataResult(data);
	};

	callAjax("/updateFindPw.do", "post", "json", true, $("#modalForm2")
			.serialize(), resultCallback);
}

/** 데이터 저장 콜백 함수 */
function fSaveDataResult(data) {
	if (data.result == "SUCCESS") {
		// 응답 메시지 출력
		swal(data.resultMsg);
		location.href = "/login.do";
	} else {
		// 오류 응답 메시지 출력
		alert(data.resultMsg);
	}
}


</script>
</head>
<body>
	<form id="myForm" action="" method="post">
	<div id="background_board" >
		<div class="login_form shadow" align="center">
		<div class="login-form-right-side">
                <div class="top-logo-wrap">
                <img src="${CTX_PATH}/images/admin/login/logo_img.png">
                </div>
                <h3>안되는 것이 실패가 아니라 포기하는 것이 실패다</h3>
                <p>
						성공은 실패의 꼬리를 물고 온다.
						지금 포기한 것이 있는가?<br>그렇다면 다시 시작해 보자.<br>
						안되는 것이 실패가 아니라 포기하는 것이 실패다.<br>
						포기한 순간이 성공하기 5분전이기 쉽다.<br> 실패에서 더 많이 배운다.<br>
						실패를 반복해서 경험하면 실망하기 쉽다. <br>하지만 포기를 생각해선 안된다.
						실패는 언제나 중간역이지 종착역은 아니다. <br>
               </p>
               <p>- 이대희, ‘1%의 가능성을 희망으로 바꾼 사람들’ 에서</p>
            </div>
		<div class= "login-form-left-side">
			<fieldset>
				<legend>로그인</legend>
				<p class="id">
					<label for="user_id">아이디</label> <input type="text" id="EMP_ID"
						name="lgn_Id" placeholder="아이디"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"
						style="ime-mode: inactive;" />
				</p>
				<p class="pw">
					<label for="user_pwd">비밀번호</label> <input type="password"
						id="EMP_PWD" name="pwd" placeholder="비밀번호"
						onfocus="this.placeholder=''; return true"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
				</p>
				<p class="member_info" style="font-size: 15px">
					<input type="checkbox" id="cb_saveId" name=""
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}">
					<span class="id_save">ID저장</span> <br>
				</p>
				<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>Login</strong></a>
				<br>
				<a href="javascript:fRegister();" id="RegisterBtn"
					name="modal"><strong>[회원가입]</strong></a>
					<a href="javascript:findIdPwd();"><strong>[아이디/비밀번호 찾기]</strong></a>
			</fieldset>
			</div>
		</div>
	</div>
</form>
<!-- 모달팝업 -->
<%--	TODO!!!!!!!!!!!!!!!!! 회원가입 모달창 입니다--%>

	<div id="layer1" class="layerPosition layerPop layerType2" style="width: 600px;">
      <form id="RegisterForm" action="" method="post">
	      <input type="hidden" name="action" id="action" value="" v-model="action">
	      <input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" v-model="checkLoginIdAndCheckRegisterId" value="0"/>
	      <input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" v-model="checkEmailAndCheckRegister" value="0"/>
		<dl>
			<dt>
					<br>
					<br>
					<strong style="font-size:120%">&nbsp;&nbsp;&nbsp;&nbsp;회원가입</strong>
					<br>
			</dt>
			<dd class="content">
				<div class="btn_areaC">
					<a href="javascript:instaffRegister();" class="btnType blue" id="register_instaff"><span>학생회원</span></a>
					<a href="javascript:outstaffRegister();" class="btnType" id="regster_outstaff"><span>강사회원</span></a>
<%--					<a href="" class="btnType" id="register_outstaff2" @click="outstaffRegister2();"><span>뷰강사회원</span></a>--%>
					<br>
					<br>
				</div>
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
						<col width="120px">
					</colgroup>
						<tbody>
							<tr class="hidden">
								<td><input type="text" name="div_cd" id="div_cd" v-model="divCd" /></td>
								<td><input type="text" name="del_cd" id="del_cd" v-model="delCd" /></td>
						 		<td><input type="text" name="user_type" id="user_type" v-model="userType"/></td>
								<td><input type="text" name="approval_cd" id="approval_cd" v-model="approvalCd"/></td>
							</tr>
							<tr>
								<th scope="row" id="stuCk" v-show="stuCk">학생가입</th>
								<th scope="row" id="teaCk" v-show="teaCk">강사 가입</th>
							</tr>



							<tr>
								<th scope="row">아이디<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100"
									name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 "
									id="registerId" v-model="registerId" /></td>
								<td><input type="button" value="중복확인"
									onclick="loginIdCheck()" style="width: 130px; height: 20px;" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password"
									placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100"
									name="password" id="registerPwd" v-model="passWord"/></td>
							</tr>

							<tr>
								<th scope="row" style="padding: 0 0">비밀번호 확인<span
									class="font_red">*</span></th>
								<td colspan="3"><input type="password"
									class="inputTxt p100" name="password1" id="registerPwdOk" v-model="registerPwdOk" /></td>
							</tr>

							<tr>
								<th scope="row" id="registerName_th">이름 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name"
									id="registerName" v-model="name" /></td>

								<th scope="row" id="rggender_th">성별</th>
								<td id="rggender_td">
								<select name="gender_cd" id="gender_cd" style="width: 128px; height: 28px;" v-model="gender">
										<option value="" selected="selected">선택</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
								</select></td>
							</tr>

							<tr id="birthday1">
								<th scope="row">생년월일 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100"
									name="birthday" id="birthday" style="font-size: 15px" v-model="birth"/>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
									<td colspan="3"><input type="text" class="inputTxt p100"
									name="user_email" id="registerEmail" v-model="email" />

								<td colspan="3">

								</td>

							</tr>

							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100"
									name="user_zipcode" id="detailaddr" v-model="zipCode"/></td>

								<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()"
									style="width: 130px; height: 20px;" /></td>
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="user_address" id="loginaddr" v-model="address"/></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="user_dt_address" id="loginaddr1" v-model="detailAddress"/></td>
							</tr>
							<tr>

								<th scope="row">전화번호<span class="font_red">*</span></th>
								<td colspan="3"><input class="inputTxt"
									style="width: 110px" maxlength="3" type="text" id="tel1"
									name="user_tel1" v-model="tel1"> - <input class="inputTxt"
									style="width: 110px" maxlength="4" type="text" id="tel2"
									name="user_tel2" v-model="tel2"> - <input class="inputTxt"
									style="width: 110px" maxlength="4" type="text" id="tel3"
									name="user_tel3" v-model="tel3"></td>
							</tr>
							<tr id="resumecheck">
								<th scope="row">이력서제출여부</th>
								<td><input type="radio" id="radio2-1"
									name="student_resume_yn" id="student_resume_yn_1" value='Y'/> <label for="radio1-1">사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio2-2"
									name="student_resume_yn" id="student_resume_yn_2" value="N"/> <label for="radio1-2">미사용</label>
								</td>
<%--								 추가 --%>
								<td><input type="hidden" v-model="resumeCheck"></td>
							</tr>

				</table>

					<table class="row" id="filetable" v-show="fileTable">
						<tr>
							<th scope="row" >이력서<span class="font_red">*</span></th>
								<td colspan="5">
									<input type="file" name="resume" id="resume" ></input>
								</td>
						</tr>
					</table>

				<div class="btn_areaC mt30">
					<a class="btnType blue" id="RegisterCom" name="btn"> <span @click="CompleteRegister">회원가입 완료</span></a>
					<a href="javascript:fcancleModal()" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</form>
	</div>





<!-- 아이디 비밀번호 찾기 모달 -->
<form id="sendForm" action="" method="post">
	<input type="hidden" name="authNumId" id="authNumId" value="" />
	<input type="hidden" name="authNumPwd" id="authNumPwd" value="" />
	<input type="hidden" name="ckIdcheck" id="ckIdcheck" value=""/>
	<div id="layer2" class="layerPop layerType2" style="width: 750px;">
		<dl>
			<dt>
				<strong>아이디/비밀번호 찾기</strong>
			</dt>
			<dd>
				<div class="btn_areaC mt30">
					<a href="javascript:fSelectId();" class="btnType gray" id="findId"><span>아이디
							찾기</span></a> <a href="javascript:fSelectPwd();" class="btnType gray"
						id="findPwd"><span>비밀번호 찾기</span></a>
				</div>
			</dd>
			<dd class="content">

				<!-- 아이디/비밀번호 찾기 폼 -->
				<table class="row" id="findForm">
					<tbody>
						<tr>
							<td id="registerEmailId"><input type="text" id="emailText"
								data-code="I" placeholder="가입하신 이메일을 입력하세요" size="30"
								style="height: 30px;" /> <a href="javascript:SendEmail();"
								class="btnType blue" id="findIdSubmit"><span>이메일 전송</span></a></td>

							<td id="confirm"><input type="text" id="emailNum" name="authnum"
								placeholder="전송된 인증번호를 입력하세요" size="30" style="height: 30px;" />
								<a href="javascript:SendComplete();" class="btnType blue"
								id="sendMail"><span>인증하기</span></a></td>
						</tr>
					</tbody>
				</table>

				<table class="row" id="findPwdForm">
					<tbody>
						<tr>
							<td id="loginRegister"><input type="text" id="emailIdText"
								placeholder="가입하신 아이디를 입력하세요" size="30" style="height: 30px;" />
								<a href="javascript:RegisterIdCheck();" class="btnType blue" id=""><span>아이디 체크</span></a></td>

							<td id="loginEmail"><input type="text" id="emailPwdText"
								data-code="P" placeholder="가입하신 이메일을 입력하세요" size="30"
								style="height: 30px;" /> <a href="javascript:SendPwdEmail();"
								class="btnType blue" id=""><span>이메일 전송</span></a></td>

							<td id="loginPwd"><input type="text" id="emailPwdNum"
								data-code="P" placeholder="전송된 비밀번호를 입력하세요" size="30"
								style="height: 30px;" /> <a
								href="javascript:SendCompletePwd();" class="btnType blue"
								id="emailOk"><span>인증하기</span></a></td>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>