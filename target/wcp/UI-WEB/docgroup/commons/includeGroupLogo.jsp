<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<c:if test="${doc.group!=null}">
	<center>
		<img src="${doc.group.imgurl}"
			class="img-responsive text-center img-thumbnail"
			alt="Responsive image">
		<h3>
			<c:if test="${doc.group.joincheck=='1'}">
			工作小组: ${doc.group.groupname}&nbsp;<span class="glyphicon glyphicon-lock"></span>
			</c:if>
			<c:if test="${doc.group.joincheck=='0'}">
			工作小组:<a href="index/FPGroupInfo.htm?id=${doc.group.id}">${doc.group.groupname}</a>
			</c:if>
		</h3>
	</center>
</c:if>