<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="isHaveImg" value="false"></c:set>
<c:set var="isHaveFile" value="false"></c:set>
<c:set var="fileNum" value="0"></c:set>
<c:forEach var="node" items="${doc.files}" varStatus="status">
	<c:set var="isHaveFile" value="true"></c:set>
	<c:set var="exname"
		value="${fn:toUpperCase(fn:replace(node.exname,'.',''))}"></c:set>
	<c:if
		test="${exname=='PNG'||exname=='JPG'||exname=='JPEG'||exname=='GIF'}">
		<c:set var="isHaveImg" value="true"></c:set>
	</c:if>
	<c:set var="fileNum" value="${fileNum+1}"></c:set>
</c:forEach>
<c:forEach var="node" items="${doc.files}">
	<p>
		<a href="${node.url}"
			class="btn btn-primary btn-lg glyphicon glyphicon-download-alt">&nbsp;下载${node.name}(${node.len}b)</a>
	</p>
</c:forEach>

