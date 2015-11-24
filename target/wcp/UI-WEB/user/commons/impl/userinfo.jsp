<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<c:if test="${USEROBJ!=null}">
	<div class="row">
		<div class="col-xs-6">
			<c:if test="${photourl!=null}">
				<img id="imgShowBoxId" src="${photourl}" alt="..."
					class="img-thumbnail" />
			</c:if>
			<c:if test="${photourl==null}">
				<img id="imgShowBoxId"
					src="<PF:basePath/>WEB-FACE/img/style/photo.png" alt="..."
					class="img-thumbnail" />
			</c:if>
		</div>
		<div class="col-xs-6">
			<address>
				<br />
				<strong>${USEROBJ.name}</strong>
				<br />
				${USERORG.name}
			</address>
		</div>
	</div>
</c:if>
