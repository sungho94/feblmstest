<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<c:forEach items="${regSubjectList}" var="list">
									<tr>
										<td>${list.num}</td>
										<td><a href="javascript:fn_lecturePlan('${list.loginID}', '${list.lecture_seq}')">${list.lecture_name}</a></td>
										<td>${list.teacher_name}</td>
										<td>${list.lecture_start} ~ ${list.lecture_end}</td>
										<td>${list.room_name}</td>
									</tr>
								</c:forEach>
							</c:if>
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>