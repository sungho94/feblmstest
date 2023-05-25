<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${ itotalcnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if> 
							
							<c:if test="${itotalcnt > 0 }">
								<c:forEach items="${itemList}" var="list">
									<tr>
										<td>${list.item_no}</td>
										<td>${list.item_name}</td>
										<td>${list.item_volume}</td>
										<td>
											<a class="btnType3 color1" href="javascript:fn_itemPopup('${list.item_no}');"><span>수정</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="itotalcnt" name="itotalcnt" value ="${itotalcnt}"/>