<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>LmsRight</title>
    <!-- sweet alert import -->
    <script src="${CTX_PATH}/js/sweetalert/sweetalert.min.js"></script>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
    <!-- sweet swal import -->

    <script type="text/javascript">
      // 강의 목록 페이징 설정
      var pageSizeLecture = 5;
      var pageBlockSizeLecture = 5;

      // 학생 목록 페이징 설정
      var pageSizeStudent = 5;
      var pageBlockSizeStudent = 10;

      /** OnLoad event */
      $(function () {
        lectureList();

        $('#divStudentList').hide();

        // 버튼 이벤트 등록
        fRegisterButtonClickEvent();
      });

      /** 버튼 이벤트 등록 */
      function fRegisterButtonClickEvent() {
        $('a[name=btn]').click(function (e) {
          e.preventDefault();

          var btnId = $(this).attr('id');

          switch (btnId) {
            case 'btnSearchLecture':
              lectureList();
              break;
            case 'btnSearchStudent':
              studentList();
              break;
            case 'btnCancelLecture':
              cancelLecture();
              break;
            case 'btnCloseModal':
              gfCloseModal();
              break;
          }
        });
      }

      // 강의 목록 조회
      function lectureList(pageNum) {
        $('#divStudentList').hide();

        pageNum = pageNum || 1;

        var param = {
          pageNum: pageNum,
          pageSize: pageSizeLecture,
          lname: $('#lname').val(),
        };

        var lectureListCallBack = function (data) {
          console.log(data);
          $('#tbodyLectureList').empty().append(data);

          var totalCnt = $('#totalCnt').val();

          var paginationHtml = getPaginationHtml(
            pageNum,
            totalCnt,
            pageSizeLecture,
            pageBlockSizeLecture,
            'lectureList'
          );

          $('#lectureListPagination').empty().append(paginationHtml);
        };
        callAjax(
          '/adm/lectureList.do',
          'post',
          'text',
          'false',
          param,
          lectureListCallBack
        );
      }

      // 학생 목록 들어가기전 백업
      function fn_studentList(lecSeq) {
        console.log(lecSeq);

        $('#blecNo').val(lecSeq);

        studentList();
      }

      // 학생 목록 조회
      function studentList(pageNum) {
        $('#divStudentList').show();

        console.log($('#blecNo').val());

        pageNum = pageNum || 1;

        var param = {
          pageNum: pageNum,
          pageSize: pageSizeStudent,
          lecSeq: $('#blecNo').val(),
          sname: $('#sname').val(),
        };

        var studentListCallBack = function (data) {
          $('#tbodyStudentList').empty().append(data);

          var totalCnt = $('#stotalCnt').val();

          var paginationHtml = getPaginationHtml(
            pageNum,
            totalCnt,
            pageSizeStudent,
            pageBlockSizeStudent,
            'studentList'
          );

          $('#studentListPagination').empty().append(paginationHtml);
        };
        callAjax(
          '/adm/studentList.do',
          'post',
          'text',
          'false',
          param,
          studentListCallBack
        );
      }

      // 학생 상세조회 전 백업
      function fn_studentSelect(loginID) {
        $('#bloginID').val(loginID);

        studentSelect();
      }

      // 학생 상세조회
      function studentSelect() {
        var param = {
          loginID: $('#bloginID').val(),
          lecSeq : $('#blecNo').val(),
        };

        var studentSelectCallback = function (data) {
          console.log(data);

          fn_initModal(data.studentSelect);

          gfModalPop('#layer1');
        };

        callAjax(
          '/adm/studentSelect.do',
          'post',
          'json',
          'false',
          param,
          studentSelectCallback
        );
      }

      // 모달창에 데이터 넣기
      function fn_initModal(studentSelect) {
        $('#loginID').empty().append(studentSelect.loginID);
        $('#regdate').empty().append(studentSelect.regdate);
        $('#name').empty().append(studentSelect.name);
        $('#birthday').empty().append(studentSelect.birthday);
        $('#email').empty().append(studentSelect.email);
        $('#address').empty().append(studentSelect.address);

        $('#stLecNo').empty().append(studentSelect.lecture_no);
        $('#stLecName').empty().append(studentSelect.lecture_name);
        $('#stLecDate')
          .empty()
          .append(
            studentSelect.lecture_start + ' ~ ' + studentSelect.lecture_end
          );
        $('#stLecSta').empty().append(studentSelect.student_lecture);
      }

      // 학생 수강 취소
      function cancelLecture() {
        console.log('들어왔다');

        console.log($('#bloginID').val());

        //var action = $("#action").val('D');
        var param = {
          loginID: $('#bloginID').val(),
          lec_seq : $('#blecNo').val()
        };

        var cancelLectureCallBack = function () {
          studentList();

          gfCloseModal();
        };
        callAjax(
          '/adm/studentCancel.do',
          'post',
          'json',
          'false',
          param,
          cancelLectureCallBack
        );
      }
    </script>
  </head>
  <body>
    <form id="myForm" action="" method="">
      <input type="hidden" name="action" id="action" value="" />
      <input type="hidden" name="blecNo" id="blecNo" value="" />
      <input type="hidden" name="bloginID" id="bloginID" value="" />

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
              <jsp:include
                page="/WEB-INF/view/common/lnbMenu.jsp"
              ></jsp:include>
              <!--// lnb 영역 -->
            </li>
            <li class="contents">
              <!-- contents -->
              <h3 class="hidden">contents 영역</h3>
              <!-- content -->
              <div class="content">
                <p class="Location">
                  <a href="../dashboard/dashboard.do" class="btn_set home"
                    >메인으로</a
                  >
                  <span class="btn_nav bold">인원관리</span>
                  <span class="btn_nav bold">학생 관리</span>
                  <a href="../adm/student.do" class="btn_set refresh"
                    >새로고침</a
                  >
                </p>

                <p class="conTitle">
                  <span>학생 관리</span>
                  <span class="fr">
                    강 의 명
                    <input
                      type="text"
                      style="width: 200px; height: 25px"
                      id="lname"
                      name="lanme"
                    />
                    <a
                      href=""
                      class="btnType blue"
                      id="btnSearchLecture"
                      name="btn"
                      ><span>검 색</span></a
                    >
                  </span>
                </p>

                <div id="divLectureList">
                  <table class="col">
                    <caption>
                      caption
                    </caption>
                    <colgroup>
                      <col width="10%" />
                      <col width="15%" />
                      <col width="15%" />
                      <col width="15%" />
                      <col width="45%" />
                    </colgroup>

                    <thead>
                      <tr>
                        <th scope="col">순번</th>
                        <th scope="col">강의 번호</th>
                        <th scope="col">강의명</th>
                        <th scope="col">강사명</th>
                        <th scope="col">강의 기간</th>
                      </tr>
                    </thead>
                    <tbody id="tbodyLectureList"></tbody>
                  </table>
                </div>

                <div class="paging_area" id="lectureListPagination"></div>

                <br /><br /><br /><br /><br /><br />

                <div id="divStudentList">
                  <p class="conTitle">
                    <span>학생 목록</span>
                    <span class="fr">
                      학 생 명
                      <input
                        type="text"
                        style="width: 200px; height: 25px"
                        id="sname"
                        name="sname"
                      />
                      <a
                        href=""
                        class="btnType blue"
                        id="btnSearchStudent"
                        name="btn"
                        ><span>검 색</span></a
                      >
                    </span>
                  </p>

                  <table class="col">
                    <caption>
                      caption
                    </caption>
                    <colgroup>
                      <col width="20%" />
                      <col width="20%" />
                      <col width="20%" />
                      <col width="20%" />
                      <col width="20%" />
                    </colgroup>

                    <thead>
                      <tr>
                        <th scope="col">학생명(ID)</th>
                        <th scope="col">수강강의</th>
                        <th scope="col">휴대전화</th>
                        <th scope="col">가입일자</th>
                        <th scope="col">비고</th>
                      </tr>
                    </thead>
                    <tbody id="tbodyStudentList"></tbody>
                  </table>

                  <div class="paging_area" id="studentListPagination"></div>
                </div>
              </div>
              <!--// content -->

              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
          </ul>
        </div>
      </div>

      <!-- 모달팝업 -->
      <div id="layer1" class="layerPop layerType2" style="width: 600px">
        <dl>
          <dt>
            <strong>학생 정보</strong>
          </dt>
          <dd class="content">
            <!-- s : 여기에 내용입력 -->
            <table class="row">
              <caption>
                caption
              </caption>
              <colgroup>
                <col width="120px" />
                <col width="120px" />
                <col width="120px" />
                <col width="120px" />
                <col width="*" />
                <col width="*" />
              </colgroup>

              <tbody>
                <tr>
                  <th scope="row">ID</th>
                  <td><div id="loginID"></div></td>
                  <th scope="row">가입일자</th>
                  <td><div id="regdate"></div></td>
                </tr>
                <tr>
                  <th scope="row">이름</th>
                  <td><div id="name"></div></td>
                  <th scope="row">생년월일</th>
                  <td><div id="birthday"></div></td>
                </tr>
                <tr>
                  <th scope="row">이메일</th>
                  <td colspan="4"><div id="email"></div></td>
                </tr>
                <tr>
                  <th scope="row">주소</th>
                  <td colspan="4"><div id="address"></div></td>
                </tr>
              </tbody>
            </table>

            <br /><br /><br />

            <div id="">
              <p class="conTitle">
                <span>수강 내역</span>
              </p>

              <table class="col">
                <caption>
                  caption
                </caption>
                <colgroup>
                  <col width="15%" />
                  <col width="15%" />
                  <col width="45%" />
                  <col width="10%" />
                  <col width="15%" />
                </colgroup>

                <thead>
                  <tr>
                    <th scope="col">강의번호</th>
                    <th scope="col">강의명</th>
                    <th scope="col">기간</th>
                    <th scope="col">상태</th>
                    <th scope="col">비고</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><div id="stLecNo"></div></td>
                    <td><div id="stLecName"></div></td>
                    <td>
                      <div id="stLecDate"></div>
                    </td>
                    <td><div id="stLecSta"></div></td>
                    <td>
                      <a
                        href=""
                        class="btnType blue"
                        id="btnCancelLecture"
                        name="btn"
                        ><span>수강취소</span></a
                      >
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <!-- e : 여기에 내용입력 -->

            <div class="btn_areaC mt30">
              <a href="" class="btnType gray" id="btnCloseModal" name="btn"
                ><span>취소</span></a
              >
            </div>
          </dd>
        </dl>
        <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>

      <!--// 모달팝업 -->
    </form>
  </body>
</html>
