<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${testList}" var="list">
									<tr>
										<td>${list.test_no}</td>
										<td><a href="javascript:questionListSearch('${list.test_no}');">${list.test_title}</a></td>
							<%-- 			<td>${list.lecture_name}</td>
										<td>${list.room_person }</td>
										<td>${list.teacher_name}</td>
										<td>${list.lecture_start} ~ ${list.lecture_end}</td> --%>
										
										<td>
											<a class="btnType3 color1" href="javascript:fn_testRegPopup('${list.test_no}');"><span>수정</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>