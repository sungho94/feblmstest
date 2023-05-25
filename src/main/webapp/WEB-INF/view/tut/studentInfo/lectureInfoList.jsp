<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${lectureInfo}" var="list">
									<tr>
										<td><a href="javascript:studentInfoList('${list.lecture_seq}')" >${list.lecture_name}</a></td>
										<td>${list.teacher_name}</td>
										<td>${list.lecture_start}</td>
										<td>${list.lecture_end}</td>
										<td>${list.room_name}</td>
										<td>${list.lecture_person}</td>
										<td>${list.lecture_total}</td>
									</tr>
									<c:if test="${list.lecture_person > list.lecture_total and (!(list.lecture_person and list.lecture_total) eq null) }" >
										<script>lecture_personExceed();</script>
									</c:if>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>