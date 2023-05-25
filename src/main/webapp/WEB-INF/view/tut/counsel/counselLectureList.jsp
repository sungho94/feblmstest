<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<c:forEach items="${counselLectureList}" var="list">
									<tr>
										<td>${list.lecture_seq}</td>
										<td><a href="javascript:fn_backUP('${list.lecture_seq}')">${list.lecture_Name}</a></td>
										<td>${list.teacherName}(${list.tchLoginID})</td>
										<td>${list.lecture_start} ~ ${list.lecture_end}</td>
										<td>${list.room_name}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>