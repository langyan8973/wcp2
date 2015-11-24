<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<c:if test="${USEROBJ!=null}">
	<div class="row ">
		<div class="col-md-12">
			<jsp:include page="/UI-WEB/user/commons/includeUserinfo.jsp"></jsp:include>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<jsp:include page="/UI-WEB/user/commons/includeUsermenu.jsp"></jsp:include>
		</div>
	</div>
</c:if>