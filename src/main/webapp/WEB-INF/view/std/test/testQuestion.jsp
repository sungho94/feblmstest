<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<dl>
	<dt>
		<strong>시험 문제</strong>
	</dt>
	<dd class="content">
		<!-- s : 여기에 내용입력 -->
		<table class="row">
			<caption>caption</caption>
			<colgroup>
				<col width="50%">
				<col width="50%">
			</colgroup>

			<tbody>
				<c:if test="${testQuestionCnt eq 0 }">
					<tr>
						<td colspan="2">시험 문제가 없습니다.</td>
					</tr>
				</c:if>

				<c:if test="${testQuestionCnt > 0 }">
					<c:forEach items="${testQuestion}" var="list">
						<tr>
							<th scope="row">Q${list.question_no}. ${list.question_ex}</th>
							<td><input type="radio" id="radio"
								name="use_yn${list.question_no}" value="1" /> <label
								for="radio1">${list.question_one}</label><br> <input
								type="radio" id="radio" name="use_yn${list.question_no}"
								value="2" /> <label for="radio2">${list.question_two}</label><br>
								<input type="radio" id="radio" name="use_yn${list.question_no}"
								value="3" /> <label for="radio3">${list.question_three}</label><br>
								<input type="radio" id="radio" name="use_yn${list.question_no}"
								value="4" /> <label for="radio4">${list.question_four}</label><br>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<input type="hidden" id="testQuestionCnt" name="testQuestionCnt" value ="${testQuestionCnt}"/>
		<input type="hidden" id="lecture_seq" name="lecture_seq" value ="${testQuestion[0].lecture_seq}"/>
		<input type="hidden" id="test_no" name="test_no" value ="${testQuestion[0].test_no}"/>

		<!-- e : 여기에 내용입력 -->

		<div class="btn_areaC mt30">
			<a href="javascript:saveQuestion()" class="btnType blue" id="" name="btn"><span>저장</span></a> 
			<a href="javascript:gfCloseModal()" class="btnType gray" id="" name="btn"><span>취소</span></a>
		</div>
	</dd>
</dl>
<a href="" class="closePop"><span class="hidden">닫기</span></a>