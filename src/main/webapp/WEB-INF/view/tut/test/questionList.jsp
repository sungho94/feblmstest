<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${ qtotalcnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if> 
							
							<c:if test="${qtotalcnt > 0 }">
								<c:forEach items="${questionList}" var="list">
									<tr>
										<input type="hidden"  name="test_no" id="test_no" value="${list.test_no}" />
										<td>${list.question_no}</td>
										<td>${list.question_ex}</td>
										<td>${list.question_answer}</td>
										<td>${list.question_one}</td>
										<td>${list.question_two}</td>
										<td>${list.question_three}</td>
										<td>${list.question_four}</td>								
										<td>
											<a class="btnType3 color1" href="javascript:fn_questionPopup('${list.test_no}', '${list.question_no}');"><span>수정</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="itotalcnt" name="qtotalcnt" value ="${qtotalcnt}"/>