<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<dl>
			<dt>
				<strong>설문 조사</strong>
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
					<c:forEach items="${surveyQuestionList}" var="list" varStatus = "a" >
						<tr>
							<th scope="row">Q${list.serveyitem_queno}. ${list.serveyitem_question}</th>
							<td>
								<input type="radio" id="radio" name="use_yn${a.index}" value="1"/> 
									<label for="radio1">${list.serveyitem_que_one}</label><br>
								<input type="radio" id="radio" name="use_yn${a.index}" value="2"/> 
									<label for="radio2">${list.serveyitem_que_two}</label><br>
								<input type="radio" id="radio" name="use_yn${a.index}" value="3"/> 
									<label for="radio3">${list.serveyitem_que_three}</label><br>
								<input type="radio" id="radio" name="use_yn${a.index}" value="4"/> 
									<label for="radio4">${list.serveyitem_que_four}</label><br>
								<input type="radio" id="radio" name="use_yn${a.index}" value="5"/> 
									<label for="radio5">${list.serveyitem_que_five}</label>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
								
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:saveSurvey()"	class="btnType blue"  id="" name="btn"><span>저장</span></a>
					<a href="javascript:gfCloseModal()"	class="btnType gray"  id="" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
		
	

	<!--// 모달팝업 -->