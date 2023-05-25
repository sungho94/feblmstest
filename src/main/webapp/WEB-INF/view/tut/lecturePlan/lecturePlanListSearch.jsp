<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${lecturePlanListSearch}" var="list">
									<tr>
										<td><a href="javascript:fn_weekPlanList
										('${list.lecture_seq}', '${list.maxWeek}',
										 '${list.lecture_start}', '${list.lecture_end}')">${list.lecture_name}</a></td>
										<td>${list.lecture_start}</td>
										<td>${list.lecture_end}</td>
										<td>${list.lecture_person}</td>
										<td>${list.lecture_total}</td>
										<td>${list.test_no}</td>
										<td>
											<a href="javascript:fn_lecturePlanListSelect('${list.lecture_seq}')"><span>상세보기</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>