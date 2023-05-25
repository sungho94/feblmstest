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
								<c:forEach items="${counselStudentList}" var="list">
									<tr>
										<td>${list.consultant_no}</td>
										<td>
											<a href="javascript:fn_modalPop('${list.consultant_no}')">
												${list.studentName}(${list.stuLoginID})
											</a>
										</td>
										<td>${list.lecture_Name}</td>
										<td>${list.consultant_counsel}</td>
										<td>${list.consultant_date}</td>
										<td>${list.teacherName}(${list.tchLoginID})</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalCnt" name="stotalCnt" value ="${totalCnt}"/>