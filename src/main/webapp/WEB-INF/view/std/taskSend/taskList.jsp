<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="7">데이터가 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${totalCnt > 0 }">
		<c:forEach items="${taskList}" var ="list">
			<tr>
				<td>${list.plan_week}</td>
				<td>${list.plan_goal}</td>
				
				<c:if test="${list.task_no eq 0}">
				 	<td>등록 된 과제가 없습니다.</td>
				</c:if>
				
				<c:if test="${list.task_no > 0}">
					<td>
				    <a class="btnType3 color1" 
				       href="javascript:fn_taskContent('${list.task_no}','${list.plan_no}', '${list.plan_week}', '${list.lectureName}')" >
				     <span>과제 내용</span></a>
				     </td>
				</c:if>
						
				<td>
				   <c:if test="${list.task_no > 0}">
				   <a class="btnType3 color1" 
				      href="javascript:fn_taskSend('${list.plan_week}', '${list.lectureName}',  
				      '${list.plan_no}', '${list.task_no}')">
				      <span>제출하기</span></a>
				   </c:if>   
				</td>
		</c:forEach> 
		</c:if>
		<input type="hidden" id="taskCnt" name="taskCnt" value ="${totalCnt}"/>
		
  